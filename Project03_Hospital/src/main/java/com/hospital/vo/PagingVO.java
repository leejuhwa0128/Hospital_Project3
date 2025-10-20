// PagingVO.java
package com.hospital.vo; // 프로젝트의 vo 패키지에 맞춰 수정하세요.

public class PagingVO {

    // 현재 페이지, 페이지당 게시물 수, 전체 게시물 수
    private int currentPage;    // 현재 페이지
    private int pageSize;       // 페이지당 게시물 수 (예: 10)
    private int totalCount;     // 전체 게시물 수

    // 페이징에 필요한 추가 정보
    private int totalPages;     // 전체 페이지 수
    private int pageBlockSize;  // 페이지 블록의 크기 (예: 5)
    private int startPage;      // 페이지 블록 시작 번호
    private int endPage;        // 페이지 블록 끝 번호

    // 이전/다음 페이지 블록 이동 여부
    private boolean hasPrevious;
    private boolean hasNext;

    public PagingVO(int totalCount, int currentPage, int pageSize, int pageBlockSize) {
        this.totalCount = totalCount;
        this.currentPage = currentPage;
        this.pageSize = pageSize;
        this.pageBlockSize = pageBlockSize;

        // 전체 페이지 수 계산
        this.totalPages = (int) Math.ceil((double) totalCount / pageSize);

        // 페이지 블록의 시작 페이지 번호 계산
        this.startPage = (int) ((currentPage - 1) / pageBlockSize) * pageBlockSize + 1;

        // 페이지 블록의 끝 페이지 번호 계산
        this.endPage = Math.min(startPage + pageBlockSize - 1, totalPages);

        // 이전/다음 페이지 블록 존재 여부
        this.hasPrevious = startPage > 1;
        this.hasNext = endPage < totalPages;
    }

    // Getter, Setter 메서드
    public int getCurrentPage() {
        return currentPage;
    }

    public int getPageSize() {
        return pageSize;
    }

    public int getTotalCount() {
        return totalCount;
    }

    public int getTotalPages() {
        return totalPages;
    }

    public int getPageBlockSize() {
        return pageBlockSize;
    }

    public int getStartPage() {
        return startPage;
    }

    public int getEndPage() {
        return endPage;
    }

    public boolean getHasPrevious() {
        return hasPrevious;
    }
    
    public int getPreviousPage() {
        return startPage - 1;
    }

    public boolean getHasNext() {
        return hasNext;
    }
    
    public int getNextPage() {
        return endPage + 1;
    }

    // 데이터베이스 쿼리에 사용할 시작 인덱스
    public int getStartIndex() {
        return (currentPage - 1) * pageSize;
    }
}