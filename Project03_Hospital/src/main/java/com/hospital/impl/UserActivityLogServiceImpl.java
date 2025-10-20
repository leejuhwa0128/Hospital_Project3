package com.hospital.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hospital.dao.UserActivityLogDAO;
import com.hospital.service.UserActivityLogService;
import com.hospital.vo.UserActivityLogVO;

@Service
@Transactional
public class UserActivityLogServiceImpl implements UserActivityLogService {

	@Autowired
	private UserActivityLogDAO logDAO;

	@Override
	public void logActivity(UserActivityLogVO log) {
		logDAO.insertLog(log);
	}

	@Override
	public List<UserActivityLogVO> getAllLogs() {
		return logDAO.getAllLogs();
	}
}
