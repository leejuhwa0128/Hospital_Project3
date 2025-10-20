package com.hospital.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Param;

import com.hospital.vo.NoticeVO;

@Mapper
public interface Notice2Mapper {

	@Select("SELECT n.NOTICE_ID, n.TITLE, n.CONTENT, n.CREATED_AT, n.CREATED_BY, n.TARGET_ROLE, " +
	        "       NVL(a.NAME, u.NAME) AS CREATED_BY_NAME " +
	        "FROM MEDICAL_NOTICES n " +
	        "LEFT JOIN ADMINS a ON a.ADMIN_ID = n.CREATED_BY " +
	        "LEFT JOIN USERS  u ON u.USER_ID  = n.CREATED_BY " +
	        "WHERE n.TARGET_ROLE = 'all' OR n.TARGET_ROLE = #{role} " +
	        "ORDER BY n.CREATED_AT DESC")
	List<NoticeVO> getNoticesByRole(@Param("role") String role);

	@Select("SELECT n.NOTICE_ID, n.TITLE, n.CONTENT, n.CREATED_AT, n.CREATED_BY, n.TARGET_ROLE, " +
	        "       NVL(a.NAME, u.NAME) AS CREATED_BY_NAME " +
	        "FROM MEDICAL_NOTICES n " +
	        "LEFT JOIN ADMINS a ON a.ADMIN_ID = n.CREATED_BY " +
	        "LEFT JOIN USERS  u ON u.USER_ID  = n.CREATED_BY " +
	        "WHERE n.NOTICE_ID = #{noticeId}")
	NoticeVO getNoticeById(@Param("noticeId") int noticeId);
    
	@Select({
	    "<script>",
	    "SELECT n.NOTICE_ID, n.TITLE, n.CONTENT, n.CREATED_AT, n.CREATED_BY, n.TARGET_ROLE,",
	    "       NVL(a.NAME, u.NAME) AS CREATED_BY_NAME",
	    "FROM MEDICAL_NOTICES n",
	    "LEFT JOIN ADMINS a ON a.ADMIN_ID = n.CREATED_BY",
	    "LEFT JOIN USERS  u ON u.USER_ID  = n.CREATED_BY",
	    "WHERE (n.TARGET_ROLE = 'all' OR n.TARGET_ROLE = #{role})",
	    "<if test='searchType == \"title\"'>",
	    "  AND LOWER(n.TITLE) LIKE '%' || LOWER(#{keyword}) || '%'",
	    "</if>",
	    "<if test='searchType == \"writer\"'>",
	    "  AND LOWER(NVL(a.NAME, u.NAME)) LIKE '%' || LOWER(#{keyword}) || '%'",  // ← 이름으로 검색
	    "</if>",
	    "<if test='searchType == \"content\"'>",
	    "  AND LOWER(n.CONTENT) LIKE '%' || LOWER(#{keyword}) || '%'",
	    "</if>",
	    "ORDER BY n.CREATED_AT DESC",
	    "</script>"
	})

    List<NoticeVO> searchNoticesByRoleAndKeyword(@Param("role") String role,
                                                 @Param("searchType") String searchType,
                                                 @Param("keyword") String keyword);


}