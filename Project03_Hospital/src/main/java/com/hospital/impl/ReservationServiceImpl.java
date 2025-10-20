package com.hospital.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hospital.dao.ReservationDAO;
import com.hospital.service.ReservationService;
import com.hospital.vo.DepartmentVO;
import com.hospital.vo.DoctorScheduleVO;
import com.hospital.vo.DoctorVO;
import com.hospital.vo.PatientVO;
import com.hospital.vo.ReservationVO;

@Service
@Transactional
public class ReservationServiceImpl implements ReservationService {

    @Autowired
    private ReservationDAO reservationDAO;

    @Autowired
    private SqlSessionTemplate sqlSession;

    private final String ns = "com.hospital.dao.ReservationDAO.";

    /* ===================== 기본 예약 ===================== */

    @Override
    public List<ReservationVO> getReservationsByPatientNo(int patientNo) {
        return reservationDAO.getReservationsByPatientNo(patientNo);
    }

    @Transactional
    @Override
    public int createReservation(ReservationVO vo) {
        // 매퍼 insertReservation2(selectKey 사용)로 예약 생성
        sqlSession.insert(ns + "insertReservation2", vo);
        return vo.getReservationId();
    }

    @Override
    public boolean isScheduleTaken(int scheduleId) {
        // RESERVATIONS에서 점유 여부 판단 (STATUS: 대기/확정/완료 만 점유로 계산하도록 매퍼 확인 필요)
        Integer c = sqlSession.selectOne(ns + "countActiveReservationByScheduleId", scheduleId);
        return c != null && c > 0;
    }

    @Override
    public void updateReservationStatus(int reservationId, String status) {
        reservationDAO.updateReservationStatus(reservationId, status);
    }

    /* ===================== 부서/의사/스케줄 ===================== */

    @Override
    public List<DepartmentVO> getDepartments() {
        return reservationDAO.selectDepartments();
    }

    @Override
    public String getDepartmentNameById(String deptId) {
        return reservationDAO.findDepartmentNameById(deptId);
    }

    @Override
    public List<DoctorVO> getDoctorsByDept(String deptId) {
        return reservationDAO.selectDoctorsByDept(deptId);
    }

    @Override
    public List<DoctorScheduleVO> getSchedulesByDoctorFromToday(String doctorId) {
        return reservationDAO.selectSchedulesByDoctorFromToday(doctorId);
    }

    public List<Long> getReservedScheduleIdsByDoctor(String doctorId) {
        return reservationDAO.selectReservedScheduleIdsByDoctor(doctorId);
    }

    /* ===================== 자동완성/검색 ===================== */

    @Override
    public List<Map<String, Object>> searchDepartmentsByName(String q) {
        return sqlSession.selectList(ns + "searchDepartmentsByName", q);
    }

    @Override
    public List<Map<String, Object>> getDoctorsByDeptForSuggest(String deptId, String q) {
        Map<String, Object> p = new HashMap<>();
        p.put("deptId", deptId);
        p.put("q", q);
        return sqlSession.selectList(ns + "searchDoctorsByDeptAndName", p);
    }

    @Override
    public Map<String, Object> getDoctorNameByIdForSuggest(String doctorId) {
        return sqlSession.selectOne(ns + "selectDoctorNameByIdForSuggest", doctorId);
    }

    /* ===================== 달력/시간 ===================== */

    @Override
    public List<String> getScheduleDatesByDoctor(String doctorId) {
        return sqlSession.selectList(ns + "selectScheduleDatesByDoctor", doctorId);
    }

    @Override
    public List<Map<String, String>> getScheduleTimesByDoctorAndDate(String doctorId, String date) {
        Map<String, Object> p = new HashMap<>();
        p.put("doctorId", doctorId);
        p.put("date", date);
        @SuppressWarnings("unchecked")
        List<Map<String, String>> list = (List<Map<String, String>>)(List<?>)
                sqlSession.selectList(ns + "selectScheduleTimesByDoctorAndDate", p);
        return list;
    }

    @Override
    public Long findScheduleIdByDoctorDateTime(String doctorId, String date, String time) {
        Map<String, Object> p = new HashMap<>();
        p.put("doctorId", doctorId);
        p.put("date", date);
        p.put("time", time);
        return sqlSession.selectOne(ns + "findScheduleIdByDoctorDateTime", p);
    }

    /* ===================== 내 예약 ===================== */

    @Override
    public List<ReservationVO> getMyList(int patientNo, String status) {
        Map<String, Object> p = new HashMap<>();
        p.put("patientNo", patientNo);
        p.put("status", status);
        return sqlSession.selectList(ns + "selectByPatient", p);
    }

    @Override
    public ReservationVO getMyOne(int patientNo, long reservationId) {
        Map<String, Object> p = new HashMap<>();
        p.put("patientNo", patientNo);
        p.put("reservationId", reservationId);
        // 매퍼 id 명확히 존재하는 것으로 교체
        return sqlSession.selectOne(ns + "selectOneForOwner", p);
    }

    @Override
    public boolean updateMyReservation(int patientNo, long reservationId,
                                       String department, String doctorId,
                                       String reservationDate, String scheduleTime, Long scheduleId,
                                       String status) {
        Map<String, Object> p = new HashMap<>();
        p.put("patientNo", patientNo);
        p.put("reservationId", reservationId);
        p.put("department", department);
        p.put("doctorId", doctorId);
        p.put("reservationDate", reservationDate);
        p.put("scheduleTime", scheduleTime);
        p.put("scheduleId", scheduleId);
        p.put("status", status);
        return sqlSession.update(ns + "updateMyReservation", p) == 1;
    }

    @Override
    public boolean cancelMyReservation(int patientNo, long reservationId) {
        Map<String, Object> p = new HashMap<>();
        p.put("patientNo", patientNo);
        p.put("reservationId", reservationId);
        return sqlSession.update(ns + "cancelMyReservation", p) == 1;
    }

    @Override
    public boolean deleteMyReservation(int patientNo, long reservationId) {
        Map<String, Object> p = new HashMap<>();
        p.put("patientNo", patientNo);
        p.put("reservationId", reservationId);
        return sqlSession.delete(ns + "deleteMyReservation", p) == 1;
    }

    @Override
    public List<Map<String, Object>> getDoctorsListByDept(String deptId) {
        return reservationDAO.getDoctorsListByDept(deptId);
    }

    @Override
    public List<String> getAvailableTimesByDoctorAndDate(String doctorId, String date) {
        return reservationDAO.getAvailableTimesByDoctorAndDate(doctorId, date);
    }

    @Override
    public PatientVO getOrCreateGuestPatient(String name, String rrn) {
        if (rrn == null || !rrn.matches("^\\d{13}$")) {
            throw new IllegalArgumentException("주민번호는 13자리 숫자여야 합니다.");
        }

        PatientVO byRrn = reservationDAO.findPatientByRrn(rrn);
        if (byRrn != null) {
            if (byRrn.getPatientUserId() != null && !byRrn.getPatientUserId().trim().isEmpty()) {
                throw new IllegalStateException("이미 가입되어있는 회원입니다.");
            }
            return byRrn;
        }

        PatientVO found = reservationDAO.findPatientByNameAndRrn(name, rrn);
        if (found != null) return found;

        PatientVO vo = new PatientVO();
        vo.setPatientName(name);
        vo.setPatientRrn(rrn);
        reservationDAO.insertGuestPatient(vo); // selectKey로 patientNo 세팅
        return vo;
    }

    @Override
    public boolean isRegisteredRrn(String rrn) {
        Integer c = sqlSession.selectOne(ns + "countRegisteredByRrn", rrn);
        return c != null && c > 0;
    }

    /* ===================== 문진표 + 예약 동시 저장 ===================== */

    @Transactional
    @Override
    public long saveQuestionnaireAndReserve(Integer patientNo,
            String department, String doctorId, Long scheduleId,
            String reservationDate, String reservationTime, String status,
            String content) {

        // 1) 예약 INSERT (selectKey로 reservationId 채워질 예정)
        Map<String,Object> r = new HashMap<>();
        r.put("patientNo",        patientNo);
        r.put("department",       department);       // 부서명 문자열
        r.put("doctorId",         doctorId);
        r.put("scheduleId",       scheduleId);
        r.put("reservationDate",  reservationDate);  // "yyyy-MM-dd"
        r.put("reservationTime",  reservationTime);  // "HH:mm"
        r.put("status",           (status == null || status.isEmpty()) ? "대기" : status);

        reservationDAO.insertReservation2(r); // mapper의 <selectKey>가 r.reservationId 세팅

        Long reservationId = ((Number) r.get("reservationId")).longValue();

        // 2) 문진표 INSERT
        Map<String,Object> q = new HashMap<>();
        q.put("reservationId", reservationId);
        q.put("content",       content);
        reservationDAO.insertQuestionnaireWithReservation(q);

        // 3) 끝
        return reservationId;
    }

    @Override
    public String findDepartmentNameByDoctorId(String doctorId) {
        if (doctorId == null || doctorId.trim().isEmpty()) return null;
        return reservationDAO.selectDeptNameByDoctorId(doctorId);
    }

    @Override
    public String findDepartmentNameByDeptId(String deptId) {
        if (deptId == null) return null;
        return reservationDAO.selectDeptNameByDeptId(deptId);
    }

    @Transactional
    @Override
    public void cancelReservation(long reservationId) {
        // 예약만 '취소'로
        sqlSession.update(ns + "updateReservationStatusCancelled", reservationId);
        // ❌ openScheduleSlotById / openScheduleSlotByKey 호출 제거
    }
    
    @Override
    public ReservationVO getReservationForComplete(int reservationId, int patientNo) {
        return reservationDAO.selectReservationForComplete(reservationId, patientNo);
    }
    
   
    @Override public PatientVO findPatientByRrn(String rrn){ return reservationDAO.findPatientByRrn(rrn); }
    @Override public int countRegisteredByRrn(String rrn){ return reservationDAO.countRegisteredByRrn(rrn); }

	@Override
	public boolean insertReservation(ReservationVO vo) {
		// TODO Auto-generated method stub
		return false;
	}


	@Override
	public List<ReservationVO> getGuestReservationsByNameRrn(String name, String rrn) {
		// TODO Auto-generated method stub
		return null;
	}


	@Override
	public Map<String, Object> findDoctorDeptByScheduleId(Long scheduleId) {
		// TODO Auto-generated method stub
		return null;
	}
	
	/* ===================== 관리자 조회용 ===================== */
    @Override
    public int countTodayReservations() {
        return reservationDAO.countTodayReservations();
    }
}
