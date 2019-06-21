package com.smtown.smhds.faq;

import java.util.List;

import com.smtown.smhds.faq.FaqVO;
import com.smtown.smhds.util.PrintPage;

public interface FaqMapper {
    public int faqCount(PrintPage printPage) throws Exception;	//게시글 갯수

    public List<FaqVO> faqList(PrintPage printPage) throws Exception;	//게시글 목록

    public List<FaqVO> faqMainList() throws Exception;	//메인화면에 보여줄 faq 목록

    public List<FaqVO> faqListMain(int limit) throws Exception;		//메인 게시글

    public List<String> faqSuggestion(PrintPage printPage) throws Exception;	//자동완성 기능

    public FaqVO faqDetail(String idxx_numb) throws Exception;	//게시글 상세

    public int faqInsert(FaqVO faq) throws Exception;	//게시글 작성

    public int faqUpdate(FaqVO faq) throws Exception;	//게시글 수정

    public int faqDelete(String idxx_numb) throws Exception;	//게시글 삭제

    public String faqSelectIdxx() throws Exception; //idxx_numb 생성
}
