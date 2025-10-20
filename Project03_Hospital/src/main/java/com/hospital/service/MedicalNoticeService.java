package com.hospital.service;

import java.util.List;
import com.hospital.vo.MedicalNoticeVO;

public interface MedicalNoticeService {
	List<MedicalNoticeVO> getAllMedicalNotices();

	MedicalNoticeVO getMedicalNoticeById(int noticeId);

	void insertMedicalNotice(MedicalNoticeVO vo);

	void updateMedicalNotice(MedicalNoticeVO vo);

	void deleteMedicalNotice(int noticeId);
}
