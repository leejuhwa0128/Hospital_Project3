package com.hospital.impl;

import com.hospital.dao.EventDAO;
import com.hospital.service.EventService;
import com.hospital.vo.EventVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.*;

@Service
public class EventServiceImpl implements EventService {

    @Autowired
    private EventDAO eventDAO;

    // ========================= 기본 이벤트 =========================
    @Override
    public List<EventVO> getEventsByCategoryInfo(String category) {
        return eventDAO.selectEventsByCategoryInfo(category);
    }

    @Override
    public EventVO getEventByIdInfo(int eventId) {
        return eventDAO.selectEventByIdInfo(eventId);
    }

    @Override
    public void insertEventInfo(EventVO eventVO) {
        eventDAO.insertEventInfo(eventVO);
    }

    @Override
    public void updateEventInfo(EventVO eventVO) {
        eventDAO.updateEventInfo(eventVO);
    }

    @Override
    public void deleteEventInfo(int eventId) {
        eventDAO.deleteEventInfo(eventId);
    }

    @Override
    public List<EventVO> getGeneralInfoEventsInfo() {
        return eventDAO.selectGeneralInfoEventsInfo();
    }

    // 페이징 (카테고리 공통)
    @Override
    public int countEventsByCategory(String category) {
        return eventDAO.countEventsByCategory(category);
    }

    @Override
    public List<EventVO> getEventsByCategoryWithPaging(String category, int offset, int pageSize) {
        return eventDAO.selectEventsByCategoryWithPaging(category, offset, pageSize);
    }

    @Override
    public void incrementViewCount(int eventId) {
        // DAO에 updateViewCount / increaseNewsView 두 가지가 있으나,
        // 인터페이스 명세는 "조회수 증가"이므로 일반 업데이트 메서드 사용
        eventDAO.updateViewCount(eventId);
    }

    @Override
    public List<EventVO> getEventsByCategory(String category) {
        return eventDAO.selectEventsByCategoryInfo(category);
    }

    @Override
    public List<EventVO> getFilteredEvents(List<String> categories, int offset, int limit) {
        return eventDAO.selectFilteredEvents(categories, offset, limit);
    }

    // 강좌/행사 등록
    @Override
    public void insertLectureEvent(EventVO event) {
        eventDAO.insertLectureEvent(event);
    }

    // (클래스에 존재하던 동일 기능 별도 메서드도 유지)
    @Override
    public List<EventVO> selectEventsByCategoryInfo(String category) {
        return eventDAO.selectEventsByCategoryInfo(category);
    }

    // ========================= 채용 전용 =========================
    /** 채용 총 개수 (subCategory가 null/빈문자면 전체) */
    @Override
    public int countRecruit(String subCategory) {
        Map<String, Object> params = new HashMap<>();
        params.put("subCategory",
                (subCategory != null && !subCategory.trim().isEmpty()) ? subCategory.trim() : null);
        return eventDAO.countRecruit(params);
    }

    /** 채용 목록 (페이징) */
    @Override
    public List<EventVO> selectRecruitPage(String subCategory, int offset, int pageSize) {
        Map<String, Object> params = new HashMap<>();
        params.put("subCategory",
                (subCategory != null && !subCategory.trim().isEmpty()) ? subCategory.trim() : null);
        params.put("offset", offset);
        params.put("pageSize", pageSize);
        return eventDAO.selectRecruitPage(params);
    }

    // 검색
    @Override
    public List<EventVO> searchEventsByKeyword(String searchKeyword) {
        return eventDAO.searchEventsByKeyword(searchKeyword);
    }

    // 채용 목록 (Map 파라미터 버전)
    @Override
    public List<EventVO> getRecruitPage(Map<String, Object> paramMap) {
        return eventDAO.selectRecruitPage(paramMap);
    }
}
