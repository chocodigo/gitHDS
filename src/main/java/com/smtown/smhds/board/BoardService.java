package com.smtown.smhds.board;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.smtown.smhds.account.Account;
import com.smtown.smhds.board.BoardVO;
import com.smtown.smhds.util.PrintPage;
import com.smtown.smhds.util.FileVO;

/**
 * <pre>
 *	BoardService.java - 요청사항 게시판 서비스
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

@Service
public class BoardService{
    private BoardMapper boardMapper;

    public BoardService(BoardMapper boardMapper){
        this.boardMapper = boardMapper;
    }

    //로그인 생일인증
    public int boardCompareBirthService(Account account) throws Exception{
        return boardMapper.boardCompareBirth(account);
    }

    //비밀번호 변경
    public int boardResetPasswordService(Account account) throws Exception{
        return boardMapper.boardResetPassword(account);
    }

    //게시글 목록
    public List<BoardVO> boardListService(PrintPage printPage) throws Exception {

        return boardMapper.boardList(printPage);
    }

    //카테고리 이름
    public List<BoardVO> boardCateListService() throws Exception{
        return boardMapper.boardCateList();
    }

    //자동완성 기능
    public List<String> boardSuggestionService(PrintPage printPage) throws Exception{
        return boardMapper.boardSuggestion(printPage);
    }

    //게시글 상세
    public BoardVO boardDetailService(String idxx_numb) throws Exception {

        return boardMapper.boardDetail(idxx_numb);
    }

    //게시글 작성
    public int boardInsertService(BoardVO board) throws Exception {

        return boardMapper.boardInsert(board);
    }

    //게시글 작성 시 idxx_numb 생성
    public String boardSelectIdxxService() throws Exception{
        return boardMapper.boardSelectIdxx();
    }

    //파일 업로드
    public int fileInsertService(FileVO file) throws Exception{
        return boardMapper.fileInsert(file);
    }

    //파일 상세
    public FileVO fileDetailService(String idxx_numb) throws Exception{
        return boardMapper.fileDetail(idxx_numb);
    }

    //게시글 수정
    public int boardUpdateService(BoardVO board) throws Exception {

        return boardMapper.boardUpdate(board);
    }

    //게시글 상태 수정
    public int boardUpdateStatService(BoardVO board)throws Exception{
        return boardMapper.boardUpdateStat(board);
    }

    //게시글 삭제
    public int boardDeleteService(String idxx_numb) throws Exception {

        return boardMapper.boardDelete(idxx_numb);
    }

    //파일 삭제
    public int fileDeleteService(String idxx_numb) throws Exception{

        return boardMapper.fileDelete(idxx_numb);
    }

    //게시글 갯수
    public int boardcount(PrintPage printPage) throws Exception{
        return boardMapper.boardCount(printPage);
    }

    //최신글 상태, 정보 조회
    public BoardVO boardCurrentService(String user_name) throws Exception{
        return boardMapper.boardCurrent(user_name);
    }

    //특정 사용자가 쓴 게시글 목록
    public List<BoardVO> boardListByUserService(PrintPage printPage, String user_name) throws Exception {

        return boardMapper.boardListByUser(printPage, user_name);
    }

    //특정 사용자가 쓴 게시글 갯수
    public int boardCountByUserService(String user_name) throws Exception{
        return boardMapper.boardCountByUser(user_name);
    }
}