package com.hospital.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hospital.dao.DoctorScheduleDAO;
import com.hospital.service.DoctorScheduleService;
import com.hospital.vo.DoctorScheduleVO;

@Service
public class DoctorScheduleServiceImpl implements DoctorScheduleService {

	@Autowired
	private DoctorScheduleDAO doctorScheduleDAO;

	@Override
	public List<DoctorScheduleVO> getSchedulesByDoctorId(String doctorId) {
		return doctorScheduleDAO.getSchedulesByDoctorId(doctorId);
	}

	/* 기본 삭제 (예약이 연결된 경우 삭제 불가) */
	@Override
	@Transactional
	public void deleteSchedule(long scheduleId) {
		deleteSchedule(scheduleId, false); // force = false
	}

	/* 강제 삭제 포함 (예약 취소 + FK 끊기 + 삭제) */
	@Override
	@Transactional
	public void deleteSchedule(long scheduleId, boolean force) {
		int active = doctorScheduleDAO.countActiveReservationsBySchedule(scheduleId);
		if (active > 0 && !force) {
			throw new IllegalStateException("연결된 예약이 있어 삭제할 수 없습니다. 강제 삭제를 사용하세요.");
		}
		if (active > 0 && force) {
			doctorScheduleDAO.cancelReservationsBySchedule(scheduleId);
		}
		doctorScheduleDAO.nullifyReservationsBySchedule(scheduleId);
		doctorScheduleDAO.deleteSchedule(scheduleId);
	}

	@Override
	public DoctorScheduleVO getScheduleById(int scheduleId) {
		return doctorScheduleDAO.getScheduleById(scheduleId);
	}

	@Override
	public void updateSchedule(DoctorScheduleVO vo) {
		doctorScheduleDAO.updateSchedule(vo);
	}

	@Override
	public void insertSchedule(DoctorScheduleVO vo) {
		doctorScheduleDAO.insertSchedule(vo);
	}

	@Override
	public List<DoctorScheduleVO> getSchedulesByDoctorAndDate(String doctorId, String date) {
		return doctorScheduleDAO.selectByDoctorAndDate(doctorId, date);
	}
}
