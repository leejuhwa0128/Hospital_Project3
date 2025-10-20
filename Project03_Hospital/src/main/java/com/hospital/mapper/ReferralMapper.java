package com.hospital.mapper;

import java.util.List;

import org.apache.ibatis.annotations.*;

import com.hospital.vo.PartnerHospitalVO;
import com.hospital.vo.ReferralCommentVO;
import com.hospital.vo.ReferralNoticeVO;
import com.hospital.vo.ReferralReplyVO;
import com.hospital.vo.ReferralRequestVO;
import com.hospital.vo.UserVO;

@Mapper
public interface ReferralMapper {

    // 협력 병원 전체 조회
    @Select("SELECT name, address, phone, website FROM partner_hospitals ORDER BY name")
    List<PartnerHospitalVO> selectAllPartnerHospitals();

    // 협진 담당 의사 목록 조회
    @Select("SELECT u.*, d.name AS department_name, p.name AS hospital_name " +
            "FROM users u " +
            "JOIN departments d ON u.dept_id = d.dept_id " +
            "JOIN partner_hospitals p ON u.hospital_id = p.hospital_id " +
            "WHERE u.role = 'coop'")
    @Results(id = "coopDoctorMap", value = {
            @Result(property = "departmentName", column = "department_name"),
            @Result(property = "hospitalName", column = "hospital_name")
    })
    List<UserVO> getAllCoopDoctors();

    // 로그인한 협진 담당자(user_id 기준) 신청 목록 조회 + 회신 여부 포함
    @Select("SELECT r.*, d.name AS department_name, u.name AS doctor_name, p.name AS hospital_name, " +
            "       CASE WHEN EXISTS (SELECT 1 FROM referral_replies rr WHERE rr.request_id = r.request_id) THEN 1 ELSE 0 END AS reply_exists " +
            "FROM referral_requests r " +
            "LEFT JOIN departments d ON r.department = d.dept_id " +
            "LEFT JOIN users u ON r.doctor_id = u.user_id " +
            "LEFT JOIN partner_hospitals p ON u.hospital_id = p.hospital_id " +
            "WHERE r.user_id = #{userId} " +
            "ORDER BY r.created_at DESC")
    @Results({
            @Result(property = "departmentName", column = "department_name"),
            @Result(property = "doctorName", column = "doctor_name"),
            @Result(property = "hospitalName", column = "hospital_name"),
            @Result(property = "replyExists", column = "reply_exists", javaType = Boolean.class)
    })
    List<ReferralRequestVO> getReferralRequestsByUser(@Param("userId") String userId);

    // request_id 기준 상세조회
    @Select("SELECT r.*, " +
            "       d.name AS department_name, " +
            "       u.name AS doctor_name, " +
            "       p.name AS hospital_name, " +
            "       u2.name AS user_name " +
            "FROM referral_requests r " +
            "JOIN departments d ON r.department = d.dept_id " +
            "JOIN users u ON r.doctor_id = u.user_id " +
            "JOIN partner_hospitals p ON u.hospital_id = p.hospital_id " +
            "JOIN users u2 ON r.user_id = u2.user_id " +
            "WHERE r.request_id = #{requestId}")
    @Results({
            @Result(property = "departmentName", column = "department_name"),
            @Result(property = "doctorName", column = "doctor_name"),
            @Result(property = "hospitalName", column = "hospital_name"),
            @Result(property = "userName", column = "user_name")
    })
    ReferralRequestVO getReferralRequestById(int requestId);

    // 회신 내용 저장
    @Insert("INSERT INTO referral_replies (" +
            "reply_id, request_id, responder_name, reply_content, reply_date, status, hospital_id, attachment_path" +
            ") VALUES (" +
            "seq_reply_id.NEXTVAL, #{requestId}, #{responderName}, #{replyContent}, SYSDATE, #{status}, #{hospitalId}, NULL)")
    void insertReply(ReferralReplyVO reply);

    // 요청 상태 변경
    @Update("UPDATE referral_requests SET status = #{status} WHERE request_id = #{requestId}")
    void updateRequestStatus(@Param("requestId") int requestId, @Param("status") String status);

    // 간단한 신청 목록 조회
    @Select("SELECT r.*, d.name AS department_name, " +
            "       CASE WHEN EXISTS (SELECT 1 FROM referral_replies rr WHERE rr.request_id = r.request_id) THEN 1 ELSE 0 END AS reply_exists " +
            "FROM referral_requests r " +
            "LEFT JOIN departments d ON r.department = d.dept_id " +
            "WHERE r.user_id = #{userId}")
    @Results({
            @Result(property = "departmentName", column = "department_name"),
            @Result(property = "replyExists", column = "reply_exists", javaType = Boolean.class)
    })
    List<ReferralRequestVO> selectReferralRequestsByUserId(@Param("userId") String userId);

    @Select("SELECT * FROM referral_replies WHERE request_id = #{requestId}")
    ReferralReplyVO getReplyByRequestId(@Param("requestId") int requestId);

    @Insert("INSERT INTO referral_comment (comment_id, request_id, doctor_id, comment_text, comment_at) " +
            "VALUES (seq_comment_id.NEXTVAL, #{requestId}, #{doctorId}, #{commentText}, SYSDATE)")
    void insertReferralComment(ReferralCommentVO comment);

    @Select("SELECT rc.*, u.name AS doctorName " +
            "FROM referral_comment rc " +
            "JOIN users u ON rc.doctor_id = u.user_id " +
            "WHERE rc.request_id = #{requestId} ORDER BY rc.comment_at ASC")
    @Results({
        @Result(property = "commentId", column = "comment_id"),
        @Result(property = "requestId", column = "request_id"),
        @Result(property = "doctorId", column = "doctor_id"),
        @Result(property = "commentText", column = "comment_text"),
        @Result(property = "commentAt", column = "comment_at"),
        @Result(property = "doctorName", column = "doctorName")
    })
    List<ReferralCommentVO> getReferralCommentsByRequestId(@Param("requestId") int requestId);

    @Update("UPDATE referral_comment SET comment_text = #{commentText} WHERE comment_id = #{commentId} AND doctor_id = #{doctorId}")
    int updateReferralComment(ReferralCommentVO comment);

    @Delete("DELETE FROM referral_comment WHERE comment_id = #{commentId} AND doctor_id = #{doctorId}")
    int deleteReferralComment(@Param("commentId") int commentId, @Param("doctorId") String doctorId);

    
    
    @Select("SELECT r.*, d.name AS department_name, u.name AS doctor_name, p.name AS hospital_name, u2.name AS user_name, " +
            "       CASE WHEN EXISTS (SELECT 1 FROM referral_replies rr WHERE rr.request_id = r.request_id) THEN 1 ELSE 0 END AS reply_exists " +
            "FROM referral_requests r " +
            "LEFT JOIN departments d ON r.department = d.dept_id " +
            "LEFT JOIN users u ON r.doctor_id = u.user_id " +
            "LEFT JOIN partner_hospitals p ON r.hospital_id = p.hospital_id " +
            "LEFT JOIN users u2 ON r.user_id = u2.user_id " + 
            "WHERE r.hospital_id = #{hospitalId} " +
            "ORDER BY r.created_at DESC")
    @Results({
            @Result(property = "departmentName", column = "department_name"),
            @Result(property = "doctorName", column = "doctor_name"),
            @Result(property = "hospitalName", column = "hospital_name"),
            @Result(property = "userName", column = "user_name"),
            @Result(property = "replyExists", column = "reply_exists", javaType = Boolean.class)
    })
    List<ReferralRequestVO> selectReferralRequestsByHospitalId(@Param("hospitalId") int hospitalId);

    @Select({
        "SELECT * FROM (",
        "  SELECT NOTICE_ID, TITLE, CONTENT, CREATED_AT, CREATED_BY, TARGET_ROLE",
        "  FROM REFERRAL_NOTICES",
        "  WHERE NVL(UPPER(TRIM(TARGET_ROLE)),'ALL') = 'ALL'",
        "  ORDER BY CREATED_AT DESC",
        ") WHERE ROWNUM <= #{limit}"
    })
    List<ReferralNoticeVO> selectLatestForAll(@Param("limit") int limit);

    @Delete({
        "DELETE FROM REFERRAL_NOTICES",
        "WHERE NOTICE_ID = #{noticeId}",
        "  AND UPPER(TRIM(CREATED_BY)) = UPPER(TRIM(#{userId}))"
    })
    int deleteByIdConditional(@Param("noticeId") long noticeId,
                              @Param("userId")   String userId);
}

