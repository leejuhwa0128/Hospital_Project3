package com.hospital.dao;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import com.hospital.vo.MedicalNoticeVO;

@Mapper
public interface MedicalNoticeDAO {
	List<MedicalNoticeVO> getAllMedicalNotices();

	MedicalNoticeVO getMedicalNoticeById(int noticeId);

	void insertMedicalNotice(MedicalNoticeVO vo);

	void updateMedicalNotice(MedicalNoticeVO vo);

	void deleteMedicalNotice(int noticeId);
}
