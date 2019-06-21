package com.smtown.smhds.board;

import java.util.List;

import com.smtown.smhds.account.Account;
import com.smtown.smhds.util.PrintPage;
import com.smtown.smhds.util.FileVO;
import org.springframework.stereotype.Repository;

/**
 * <pre>
 *	BoardMapper.java - 요청사항 게시판 매퍼
 * </pre>
 *
 * @author	최해림
 * @since	2019.05.21
 * @version	1.0
 *
 * <pre>
 * == Modification Information ==
 * Date		Modifier		Comment
 * ====================================================
 * 2019.05.21	최해림		Initial Created.
 * ====================================================
 * </pre>
 *
 * Copyright SM Entertainment.(C) All right reserved.
 */
@Repository
public interface BoardMapper {
    public int boardCompareBirth(Account account) throws Exception;	//생일인증

    public int boardResetPassword(Account account) throws Exception; //비밀번호 재설정

    public int boardCount(PrintPage printPage) throws Exception;	//게시글 갯수

    public List<BoardVO> boardList(PrintPage printPage) throws Exception;	//게시글 목록

    public List<BoardVO> boardCateList() throws Exception;	//카테고리 이름

    public List<String> boardSuggestion(PrintPage printPage) throws Exception;	//자동완성 기능

    public BoardVO boardDetail(String idxx_numb) throws Exception;	//게시글 상세

    public int boardInsert(BoardVO board) throws Exception;	//게시글 작성

    public String boardSelectIdxx() throws Exception; //idxx_numb 생성

    public int fileInsert(FileVO file) throws Exception;	//파일 업로드

    public FileVO fileDetail(String idxx_numb) throws Exception;	//파일 상세

    public int boardUpdate(BoardVO board) throws Exception;	//게시글 수정

    public int boardUpdateStat(BoardVO board) throws Exception; //게시글 상태 수정

    public int boardDelete(String idxx_numb) throws Exception;	//게시글 삭제

    public int fileDelete(String idxx_numb) throws Exception;	//파일 삭제

    public BoardVO boardCurrent(String user_name) throws Exception;	//최신글 정보 조회

    public List<BoardVO> boardListByUser(PrintPage printPage, String user_name) throws Exception;	//특정 사용자가 쓴 게시글 조회

    public int boardCountByUser(String user_name) throws Exception;	//특정 사용자가 쓴 게시글 갯수
}
