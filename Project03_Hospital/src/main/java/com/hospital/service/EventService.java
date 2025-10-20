package com.hospital.service;

import com.hospital.vo.EventVO;
import java.util.List;
import java.util.Map;

public interface EventService {

    // ========================= 기본 이벤트 =========================
    List<EventVO> getEventsByCategoryInfo(String category);
    EventVO getEventByIdInfo(int eventId);
    void insertEventInfo(EventVO eventVO);
    void updateEventInfo(EventVO eventVO);
    void deleteEventInfo(int eventId);
    List<EventVO> getGeneralInfoEventsInfo();

    // 페이징 (카테고리 공통)
    int countEventsByCategory(String category);
    List<EventVO> getEventsByCategoryWithPaging(String category, int offset, int pageSize);

    void incrementViewCount(int eventId);

    List<EventVO> getEventsByCategory(String category);
    List<EventVO> getFilteredEvents(List<String> categories, int offset, int limit);

    // 강좌/행사 등록
    void insertLectureEvent(EventVO event);

    // (클래스에 존재하던 동일 기능 별도 메서드도 유지)
    List<EventVO> selectEventsByCategoryInfo(String category);

    // ========================= 채용 전용 =========================
    /** 채용 총 개수 (subCategory가 null/빈문자면 전체) */
    int countRecruit(String subCategory);

    /** 채용 목록 (페이징) */
    List<EventVO> selectRecruitPage(String subCategory, int offset, int pageSize);

    // 검색
    List<EventVO> searchEventsByKeyword(String searchKeyword);

    // 채용 목록 (Map 파라미터 버전)
    List<EventVO> getRecruitPage(Map<String, Object> paramMap);
}
