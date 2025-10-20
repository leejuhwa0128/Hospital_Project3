package com.hospital.util;

import java.util.Date;

public class TimeUtil {

	public static String formatRelativeTime(Date createdAt) {
		long diffMillis = new Date().getTime() - createdAt.getTime();
		long diffMinutes = diffMillis / (60 * 1000);
		long diffHours = diffMinutes / 60;
		long diffDays = diffHours / 24;

		if (diffMinutes < 1) {
			return "방금 전";
		} else if (diffMinutes < 60) {
			return diffMinutes + "분 전";
		} else if (diffHours < 24) {
			return diffHours + "시간 전";
		} else {
			return diffDays + "일 전";
		}
	}
}
