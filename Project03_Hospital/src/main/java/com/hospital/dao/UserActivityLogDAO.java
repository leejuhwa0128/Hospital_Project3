package com.hospital.dao;

import java.util.List;
import com.hospital.vo.UserActivityLogVO;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface UserActivityLogDAO {
	void insertLog(UserActivityLogVO log);

	List<UserActivityLogVO> getAllLogs();
}
