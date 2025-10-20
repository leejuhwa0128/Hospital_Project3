package com.hospital.vo;

import java.util.Date;

public class UserActivityLogVO {
	private int logId;
	private String userId;
	private String action;
	private String targetTable;
	private int targetId;
	private Date timestamp;
	private String userType;

	// === Getter & Setter ===

	public int getLogId() {
		return logId;
	}

	public void setLogId(int logId) {
		this.logId = logId;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getAction() {
		return action;
	}

	public void setAction(String action) {
		this.action = action;
	}

	public String getTargetTable() {
		return targetTable;
	}

	public void setTargetTable(String targetTable) {
		this.targetTable = targetTable;
	}

	public int getTargetId() {
		return targetId;
	}

	public void setTargetId(int targetId) {
		this.targetId = targetId;
	}

	public Date getTimestamp() {
		return timestamp;
	}

	public void setTimestamp(Date timestamp) {
		this.timestamp = timestamp;
	}

	public String getUserType() {
		return userType;
	}

	public void setUserType(String userType) {
		this.userType = userType;
	}

	// === toString ===

	@Override
	public String toString() {
		return "UserActivityLogVO [logId=" + logId + ", userId=" + userId + ", action=" + action + ", targetTable="
				+ targetTable + ", targetId=" + targetId + ", timestamp=" + timestamp + ", userType=" + userType + "]";
	}
}
