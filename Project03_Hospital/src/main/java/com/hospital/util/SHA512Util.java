package com.hospital.util;

import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;

public class SHA512Util {
	public static String encrypt(String input) {
		try {
			MessageDigest md = MessageDigest.getInstance("SHA-512");
			md.update(input.getBytes()); // ✅ UTF-8 제거
			byte[] bytes = md.digest();
			StringBuilder sb = new StringBuilder();
			for (byte b : bytes) {
				sb.append(String.format("%02x", b));
			}
			return sb.toString();
		} catch (Exception e) {
			throw new RuntimeException("SHA-512 암호화 오류", e);
		}
	}
}
