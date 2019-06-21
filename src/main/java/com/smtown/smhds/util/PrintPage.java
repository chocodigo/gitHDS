package com.smtown.smhds.util;

//특정 페이지 출력
public class PrintPage {
    //보여줄 페이지 번호
    private int page;
    //페이지 당 보여줄 게시글의 개수
    private int perPageNum;
    //검색값
    private String search;
    //카테고리 값
    private String cate_gory;

    //기본값 설정
    public PrintPage() {
        this.page=1;
        this.perPageNum=10;
        this.search="";
        this.cate_gory="01";
    }

    public String getCate_gory() {
        return cate_gory;
    }

    public void setCate_gory(String cate_gory) {
        this.cate_gory = cate_gory;
    }


    public int getPage() {
        return page;
    }

    public void setPage(int page) {
        if(page <=0) {
            this.page = 1;
            return;
        }

        this.page = page;
    }

    public int getPerPageNum() {
        return perPageNum;
    }

    public void setPerPageNum(int perPageNum) {
        if(perPageNum <= 0) {
            this.perPageNum=10;
            return;
        }

        this.perPageNum = perPageNum;
    }

    //limit 구문에서 시작위치를 지정할 때 사용
    public int getPageStart() {
        return (this.page-1) * perPageNum;
    }

    public String getSearch() {
        return search;
    }

    public void setSearch(String search) {
        this.search = search;
    }

    @Override
    public String toString() {
        return "PrintPage [page=" + page +", perPageNum=" + perPageNum + "]";
    }
}
