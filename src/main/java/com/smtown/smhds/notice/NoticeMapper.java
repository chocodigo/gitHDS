package com.smtown.smhds.notice;

import java.util.List;

import com.smtown.smhds.notice.NoticeVO;
import com.smtown.smhds.util.FileVO;
import com.smtown.smhds.util.PrintPage;

public interface NoticeMapper {
    public int noticeCount(PrintPage printPage) throws Exception;	//게시글 갯수

    public List<NoticeVO> noticeList(PrintPage printPage) throws Exception;	//게시글 목록

    public List<NoticeVO> noticeMainList() throws Exception;	//메인화면에 보여줄 공지사항 목록

    public List<NoticeVO> noticeListMain(int limit) throws Exception;		//메인 게시글

    public List<String> noticeSuggestion(PrintPage printPage) throws Exception;	//자동완성 기능

    public NoticeVO noticeDetail(String idxx_numb) throws Exception;	//게시글 상세

    public int noticeInsert(NoticeVO notice) throws Exception;	//게시글 작성

    public int noticeUpdate(NoticeVO notice) throws Exception;	//게시글 수정

    public int noticeDelete(String idxx_numb) throws Exception;	//게시글 삭제

    public String noticeSelectIdxx() throws Exception; //idxx_numb 생성
}
