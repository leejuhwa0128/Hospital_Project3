package com.hospital.service;

import java.util.List;
import com.hospital.vo.UserActivityLogVO;

public interface UserActivityLogService {
	void logActivity(UserActivityLogVO log);

	List<UserActivityLogVO> getAllLogs();
}
