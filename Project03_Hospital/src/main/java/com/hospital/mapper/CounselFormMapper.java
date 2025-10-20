package com.hospital.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.hospital.vo.CounselFormVO;

@Mapper
public interface CounselFormMapper {

	// 상담 등록
	int insertCounsel(CounselFormVO counsel);

	// 전체 상담 목록 조회
	List<CounselFormVO> getAllCounsel();

	// 상담 단건 조회
	CounselFormVO getCounselById(int counselId);

	// 상담 상태 변경
	int updateStatus(@Param("counselId") int counselId, @Param("status") String status);

	// ✅ 추가: 빠른예약 목록 조회
	List<CounselFormVO> getFastReservations();
	
	// CounselFormMapper.java
	List<CounselFormVO> selectByEmail(String email);

}
