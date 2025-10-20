package com.hospital.dao;
import org.apache.ibatis.annotations.Param;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.hospital.vo.DepartmentVO;
import com.hospital.vo.DoctorScheduleVO;
import com.hospital.vo.DoctorVO;
import com.hospital.vo.PatientVO;
import com.hospital.vo.ReservationVO;

@Mapper
public interface ReservationDAO {
	List<ReservationVO> getReservationsByPatientNo(int patientNo);

	int insertReservation2(ReservationVO vo);

	int updateReservationStatus(@Param("reservationId") int reservationId, @Param("status") String status);

	int countTodayReservations();
	
	List<DepartmentVO> selectDepartments();

    List<DoctorVO> selectDoctorsByDept(@Param("deptId") String deptId);

    List<DoctorScheduleVO> selectSchedulesByDoctorFromToday(@Param("doctorId") String doctorId);

    List<Long> selectReservedScheduleIdsByDoctor(@Param("doctorId") String doctorId);

    
    int countActiveByScheduleId(int scheduleId);
    String findDepartmentNameById(String deptId);
    ReservationVO selectReservationByIdAndPatient(Map<String,Object> param);
    List<Map<String,Object>> searchDepartmentsByName(String q);
    List<Map<String,Object>> searchDoctorsByDeptAndName(String deptId, String q);
    String selectDoctorNameByIdForSuggest(String doctorId);
    List<String> selectScheduleDatesByDoctor(String doctorId);
    List<Map<String,String>> selectScheduleTimesByDoctorAndDate(String doctorId, String date);
    Long findScheduleIdByDoctorDateTime(String doctorId, String date, String time);
    List<Map<String, Object>> getDoctorsListByDept(String deptId);
    List<String> getAvailableTimesByDoctorAndDate(String doctorId, String date);
    
    PatientVO findPatientByNameAndRrn(@Param("name") String name, @Param("rrn") String rrn);
    int insertGuestPatient(PatientVO vo);

    List<ReservationVO> selectReservationsByNameAndRrn(@Param("name") String name, @Param("rrn") String rrn);
    int countRegisteredByRrn(@Param("rrn") String rrn);
    PatientVO findPatientByRrn(@Param("rrn") String rrn);
    int  insertReservation2(Map<String,Object> param);
    Long lastInsertedReservationId(); // selectKey 못쓰는 경우만

    // 문진표 (RESERVATION_ID 포함)
    int insertQuestionnaireWithReservation(Map<String,Object> param);

    
    void updateReservationStatusCancelled(long reservationId);

    // 취소용 보조
    Long findScheduleIdByReservationId(@Param("reservationId") Long reservationId);
    Map<String,Object> findDoctorDateTimeByReservationId(@Param("reservationId") Long reservationId);
    int  updateReservationStatusCancelled(@Param("reservationId") Long reservationId);
    String selectDeptNameByDoctorId(@Param("doctorId") String doctorId);

    String selectDeptNameByDeptId(@Param("deptId") String deptId);
    
    com.hospital.vo.ReservationVO selectReservationForComplete(
            @org.apache.ibatis.annotations.Param("reservationId") int reservationId,
            @org.apache.ibatis.annotations.Param("patientNo")     int patientNo);
    
    
    
    
}


