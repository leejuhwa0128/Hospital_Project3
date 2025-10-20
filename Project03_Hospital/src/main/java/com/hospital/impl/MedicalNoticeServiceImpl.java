package com.hospital.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hospital.dao.MedicalNoticeDAO;
import com.hospital.service.MedicalNoticeService;
import com.hospital.vo.MedicalNoticeVO;

@Service
public class MedicalNoticeServiceImpl implements MedicalNoticeService {

	@Autowired
	private MedicalNoticeDAO medicalNoticeDAO;

	@Override
	public List<MedicalNoticeVO> getAllMedicalNotices() {
		return medicalNoticeDAO.getAllMedicalNotices();
	}

	@Override
	public MedicalNoticeVO getMedicalNoticeById(int noticeId) {
		return medicalNoticeDAO.getMedicalNoticeById(noticeId);
	}

	@Override
	public void insertMedicalNotice(MedicalNoticeVO vo) {
		medicalNoticeDAO.insertMedicalNotice(vo);
	}

	@Override
	public void updateMedicalNotice(MedicalNoticeVO vo) {
		medicalNoticeDAO.updateMedicalNotice(vo);
	}

	@Override
	public void deleteMedicalNotice(int noticeId) {
		medicalNoticeDAO.deleteMedicalNotice(noticeId);
	}
}
