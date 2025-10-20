package com.hospital.dao;

import com.hospital.vo.EventVO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * EventDAO
 * - MyBatis 매퍼(eventMapper.xml) 호출 전용 DAO
 * - 기본 이벤트 / 채용 / 강좌 / 검색 / 서브카테고리 / 필터 조회 지원
 */
@Repository
public class EventDAO {

    @Autowired
    private SqlSession sqlSession;

    // ======================= 기본 이벤트 CRUD =======================

    /** 카테고리별 이벤트 목록 */
    public List<EventVO> selectEventsByCategoryInfo(String category) {
        return sqlSession.selectList("eventMapper.selectEventsByCategoryInfo", category);
    }

    /** 이벤트 단건 조회 */
    public EventVO selectEventByIdInfo(int eventId) {
        return sqlSession.selectOne("eventMapper.selectEventByIdInfo", eventId);
    }

    /** 이벤트 등록 */
    public void insertEventInfo(EventVO eventVO) {
        sqlSession.insert("eventMapper.insertEventInfo", eventVO);
    }

    /** 이벤트 수정 */
    public void updateEventInfo(EventVO eventVO) {
        sqlSession.update("eventMapper.updateEventInfo", eventVO);
    }

    /** 이벤트 삭제 */
    public void deleteEventInfo(int eventId) {
        sqlSession.delete("eventMapper.deleteEventInfo", eventId);
    }

    /** 일반 정보 이벤트 목록 */
    public List<EventVO> selectGeneralInfoEventsInfo() {
        return sqlSession.selectList("eventMapper.selectGeneralInfoEventsInfo");
    }

    // ======================= 공통 페이징 =======================

    /** 카테고리별 총 이벤트 수 */
    public int countEventsByCategory(String category) {
        return sqlSession.selectOne("eventMapper.countEventsByCategory", category);
    }

    /** 카테고리별 이벤트 페이징 목록 */
    public List<EventVO> selectEventsByCategoryWithPaging(String category, int offset, int pageSize) {
        Map<String, Object> params = new HashMap<>();
        params.put("category", category);
        params.put("offset", offset);
        params.put("pageSize", pageSize);
        return sqlSession.selectList("eventMapper.selectEventsByCategoryWithPaging", params);
    }

    /** 조회수 증가 */
    public void updateViewCount(int eventId) {
        sqlSession.update("eventMapper.updateViewCount", eventId);
    }

    /** 소식 상세 조회 시 조회수 증가 */
    public void incrementViewCount(int eventId) {
        sqlSession.update("eventMapper.increaseNewsView", eventId);
    }

    // ======================= 필터/검색 =======================

    /** 카테고리 다중 필터링 조회 */
    public List<EventVO> selectFilteredEvents(List<String> categories, int offset, int limit) {
        Map<String, Object> params = new HashMap<>();
        params.put("categories", categories);
        params.put("offset", offset);
        params.put("limit", limit);
        return sqlSession.selectList("eventMapper.selectFilteredEvents", params);
    }

    /** 키워드 검색 */
    public List<EventVO> searchEventsByKeyword(String searchKeyword) {
        return sqlSession.selectList("eventMapper.searchEventsByKeyword", searchKeyword);
    }

    // ======================= 강좌/행사 =======================

    /** 강좌/행사 등록 */
    public void insertLectureEvent(EventVO event) {
        sqlSession.insert("eventMapper.insertLectureEvent", event);
    }

    // ======================= 채용 관련 =======================

    /** 채용 총 개수 */
    public int countRecruit(Map<String, Object> params) {
        return sqlSession.selectOne("eventMapper.countRecruit", params);
    }

    /** 채용 목록 (페이징) */
    public List<EventVO> selectRecruitPage(Map<String, Object> params) {
        return sqlSession.selectList("eventMapper.selectRecruitPage", params);
    }

    // ======================= 추가: 서브카테고리/직무 =======================

    /** 카테고리+서브카테고리 이벤트 수 */
    public int countEventsByCategoryAndSub(String category, String subCategory) {
        Map<String, Object> params = new HashMap<>();
        params.put("category", category);
        params.put("subCategory", subCategory);
        return sqlSession.selectOne("eventMapper.countEventsByCategoryAndSub", params);
    }

    /** 카테고리+서브카테고리 이벤트 페이징 조회 */
    public List<EventVO> selectEventsByCategoryAndSubWithPaging(String category, String subCategory, int offset, int limit) {
        Map<String, Object> params = new HashMap<>();
        params.put("category", category);
        params.put("subCategory", subCategory);
        params.put("offset", offset);
        params.put("limit", limit);
        return sqlSession.selectList("eventMapper.selectEventsByCategoryAndSubWithPaging", params);
    }

    /** 카테고리+직무 이벤트 페이징 조회 */
    public List<EventVO> selectEventsByCategoryAndJobWithPaging(String category, String job, int offset, int size) {
        Map<String, Object> params = new HashMap<>();
        params.put("category", category);
        params.put("job", job);
        params.put("offset", offset);
        params.put("size", size);
        return sqlSession.selectList("eventMapper.selectEventsByCategoryAndJobWithPaging", params);
    }
}
