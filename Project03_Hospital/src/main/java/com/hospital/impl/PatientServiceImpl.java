package com.hospital.impl;

import java.util.*;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hospital.dao.PatientDAO;
import com.hospital.dao.UserDAO;
import com.hospital.service.PatientService;
import com.hospital.util.SHA512Util;
import com.hospital.vo.PatientVO;

@Service
public class PatientServiceImpl implements PatientService {

	@Autowired
	private PatientDAO patientDAO;

	@Autowired
	private UserDAO userDAO;

	@Autowired
	private SqlSession sqlSession;

	@Override
	public boolean registerPatient(PatientVO vo) throws DuplicateKeyException {
		try {
			if (patientDAO.existsByUserId(vo.getPatientUserId()) > 0
					|| userDAO.existsByUserId(vo.getPatientUserId()) > 0) {
				throw new DuplicateKeyException("이미 사용 중인 아이디입니다.");
			}
			if (patientDAO.existsByRrn(vo.getPatientRrn()) > 0 || userDAO.existsByRrn(vo.getPatientRrn()) > 0) {
				throw new DuplicateKeyException("이미 등록된 주민등록번호입니다.");
			}
			if (patientDAO.existsByEmail(vo.getPatientEmail()) > 0 || userDAO.existsByEmail(vo.getPatientEmail()) > 0) {
				throw new DuplicateKeyException("이미 등록된 이메일입니다.");
			}

			return patientDAO.insertPatient(vo) > 0;

		} catch (DataIntegrityViolationException e) {
			e.printStackTrace();
			String rootMessage = e.getMostSpecificCause().getMessage();
			throw new DuplicateKeyException(rootMessage);
		}
	}

	@Override
	public PatientVO findNonMemberPatient(String name, String rrn) {
		return patientDAO.findNonMemberPatient(name, rrn);
	}

	@Override
	public void updatePatientToMember(PatientVO vo) {
		// 중복 검사 (ID, 이메일은 기존 전역 검사)
		if (patientDAO.existsByUserId(vo.getPatientUserId()) > 0 || userDAO.existsByUserId(vo.getPatientUserId()) > 0) {
			throw new DuplicateKeyException("이미 사용 중인 아이디입니다.");
		}
		if (patientDAO.existsByEmail(vo.getPatientEmail()) > 0 || userDAO.existsByEmail(vo.getPatientEmail()) > 0) {
			throw new DuplicateKeyException("이미 등록된 이메일입니다.");
		}

		// 비회원 예약 내역 업데이트 → 회원 전환
		int updated = patientDAO.updatePatientToMember(vo);

		if (updated == 0) {
			throw new RuntimeException("비회원 예약 내역을 찾을 수 없습니다.");
		}
	}

	@Override
	public PatientVO login(PatientVO vo) {
		// ✅ 암호화된 비밀번호로 비교

		return patientDAO.login(vo);
	}

	@Override
	public List<PatientVO> getAllPatients() {
		return patientDAO.getAllPatients();
	}

	@Override
	public List<PatientVO> searchPatients(String keyword) {
		return patientDAO.searchPatients(keyword);
	}

	@Override
	public PatientVO getPatientByNo(int patientNo) {
		return patientDAO.getPatientByNo(patientNo);
	}

	@Override
	public void deletePatient(int patientNo) {
		patientDAO.deletePatientByNo(patientNo);
	}

	@Override
	public void logdeletePatient(String patientUserId) {
		patientDAO.deletePatientByUserId(patientUserId);
	}

	@Override
	public void insertSocialPatient(PatientVO vo) {
		if (patientDAO.existsByEmail(vo.getPatientEmail()) > 0) {
			return;
		}
		patientDAO.insertSocialPatient(vo);
	}

	@Override
	public PatientVO findPatientByEmail(String email) {
		return userDAO.findPatientByEmail(email);
	}

	@Override
	public boolean updatePatientInfo(PatientVO vo) {
		return patientDAO.updatePatientInfo(vo) > 0;
	}

	@Override
	public void updatePatientInfoAndPassword(PatientVO vo) {
		patientDAO.updatePatientInfoAndPassword(vo);
	}

	@Override
	public PatientVO getPatientById(String patientUserId) {
		return patientDAO.getPatientById(patientUserId);
	}

	@Override
	public String findPatientId(String name, String patientPhone) {
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("name", name);
		paramMap.put("patientPhone", patientPhone);
		return sqlSession.selectOne("com.hospital.dao.PatientDAO.findPatientId", paramMap);
	}

	@Override
	public String findTempPassword(String patientUserId, String patientRrn) {
		Map<String, Object> param = new HashMap<>();
		param.put("id", patientUserId.trim());
		param.put("rrn", patientRrn.trim());

		int count = sqlSession.selectOne("com.hospital.dao.PatientDAO.findPatientForPassword", param);

		if (count == 1) {
			String tempPassword = UUID.randomUUID().toString().substring(0, 8);

			Map<String, Object> updateParam = new HashMap<>();
			updateParam.put("id", patientUserId.trim());
			updateParam.put("tempPassword", SHA512Util.encrypt(tempPassword)); // ✅ 암호화된 임시 비밀번호 저장

			sqlSession.update("com.hospital.dao.PatientDAO.updateTempPassword", updateParam);

			return tempPassword; // 사용자에게는 평문 전달
		}
		return null;
	}

	@Override
	public boolean isUserIdDuplicated(String userId) {
		return patientDAO.selectPatientByUserId(userId) != null;
	}

	@Override
	public boolean isEmailDuplicated(String email) {
		return patientDAO.selectPatientByEmail(email) != null;
	}

	@Override
	public int countPatients() {
		return patientDAO.countPatients();
	}

	@Override
	public boolean isRrnDuplicated(String rrn) {
		return patientDAO.existsByRrn(rrn) > 0;
	}

	@Override
	public boolean isPhoneDuplicated(String phone) {
		return patientDAO.existsByPhone(phone) > 0;
	}

	@Override
	public PatientVO getPatientByUserId(String userId) {
		return patientDAO.getPatientByUserId(userId);
	}

	@Override
	@Transactional
	public boolean stripToGuest(int patientNo) {
		return patientDAO.stripToGuest(patientNo) == 1;
	}
}
