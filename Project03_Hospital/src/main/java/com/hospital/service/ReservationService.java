package com.hospital.service;

import java.util.List;
import java.util.Map;

import com.hospital.vo.DepartmentVO;
import com.hospital.vo.DoctorScheduleVO;
import com.hospital.vo.DoctorVO;
import com.hospital.vo.PatientVO;
import com.hospital.vo.ReservationVO;

public interface ReservationService {
    
    // 기존 예약 목록 조회
    List<ReservationVO> getReservationsByPatientNo(int patientNo);

    // 예약 생성
    boolean insertReservation(ReservationVO vo);

    // 예약 상태 변경
    void updateReservationStatus(int reservationId, String status);

    // 오늘 예약 건수
    int countTodayReservations();

    // 전체 진료과 목록
    List<DepartmentVO> getDepartments();

    // 진료과별 의사 목록
    List<DoctorVO> getDoctorsByDept(String deptId);

    // 특정 의사의 오늘 이후 스케줄 목록
    List<DoctorScheduleVO> getSchedulesByDoctorFromToday(String doctorId);

    // 특정 의사의 예약된 스케줄 ID 목록
    List<Long> getReservedScheduleIdsByDoctor(String doctorId);

    // 예약 생성 (리턴: 생성된 ID)
    int createReservation(ReservationVO vo);

    // 해당 스케줄이 이미 예약되었는지 여부
    boolean isScheduleTaken(int scheduleId);

    // 진료과명 조회
    String getDepartmentNameById(String deptId);

    // 나의 예약 목록
    List<ReservationVO> getMyList(int patientNo, String status);

    // 나의 예약 상세
    ReservationVO getMyOne(int patientNo, long reservationId);

    // 나의 예약 수정
    boolean updateMyReservation(int patientNo, long reservationId,
                                String department, String doctorId,
                                String reservationDate, String scheduleTime, Long scheduleId,
                                String status);

    // 나의 예약 취소
    boolean cancelMyReservation(int patientNo, long reservationId);

    // 나의 예약 삭제
    boolean deleteMyReservation(int patientNo, long reservationId);

    // 진료과명 검색 (자동완성용)
    List<Map<String,Object>> searchDepartmentsByName(String q);

    // 특정 진료과 의사 검색 (자동완성용)
    List<Map<String,Object>> getDoctorsByDeptForSuggest(String deptId, String q);

    // 의사 이름 조회 (새 ID 반영)
    Map<String,Object> getDoctorNameByIdForSuggest(String doctorId);

    // 특정 의사의 예약 가능 날짜 목록
    List<String> getScheduleDatesByDoctor(String doctorId);

    // 특정 의사의 날짜별 예약 가능 시간 목록
    List<Map<String,String>> getScheduleTimesByDoctorAndDate(String doctorId, String date);

    // 특정 의사의 날짜·시간으로 스케줄 ID 찾기
    Long findScheduleIdByDoctorDateTime(String doctorId, String date, String time);
    
    List<Map<String, Object>> getDoctorsListByDept(String deptId);
   
    List<String> getAvailableTimesByDoctorAndDate(String doctorId, String date);
    
    PatientVO getOrCreateGuestPatient(String name, String rrn);

    // 비회원: 이름+주민번호로 예약 목록
    List<ReservationVO> getGuestReservationsByNameRrn(String name, String rrn);
    boolean isRegisteredRrn(String rrn);
    // 예약 생성(로그인/비회원 공용)
    long saveQuestionnaireAndReserve(
            Integer patientNo,       // ✅ Integer
            String  department,      // ✅ String (DEPARTMENT 컬럼)
            String  doctorId,        // ✅ String
            Long    scheduleId,      // ✅ Long
            String  reservationDate, // ✅ "yyyy-MM-dd"
            String  reservationTime, // ✅ "HH:mm"
            String  status,          // ✅ BOOKED 등
            String  content          // ✅ 문진표 CLOB
        );

/** doctorId(문자)로 부서명 조회 (USERS 등에서) */
String findDepartmentNameByDoctorId(String doctorId);

/** deptId로 부서명 조회 (DEPARTMENTS 테이블이 있을 때만) */
String findDepartmentNameByDeptId(String deptId);

/** scheduleId로 doctorId/department 등을 역조회할 때 사용 (선택) */
Map<String, Object> findDoctorDeptByScheduleId(Long scheduleId);

    void cancelReservation(long reservationId);
   ReservationVO getReservationForComplete(int reservationId, int patientNo);

   PatientVO findPatientByRrn(String rrn);
   int countRegisteredByRrn(String rrn);


}
