package com.smtown.smhds.comment;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.smtown.smhds.account.Account;

/**
 * <pre>
 *	CommentController.java - 요청사항 게시판 댓글 컨트롤러
 * </pre>
 *
 * @author	최해림
 * @since	2019.06.10
 * @version	1.0
 *
 * <pre>
 * == Modification Information ==
 * Date		Modifier		Comment
 * ====================================================
 * 2019.06.10	최해림		Initial Created.
 * ====================================================
 * </pre>
 *
 * Copyright SM Entertainment.(C) All right reserved.
 */

@Controller
@RequestMapping("/comment")
public class CommentController {

    /*
     * 요청사항 게시판 답글 서비스(Service) 클래스
     */
    @Autowired
    CommentService commentService;

    /*
     * 답글 등록
     * @param idxx_numb - 댓글 등록할 게시글 ID
     * 		  comm_cont - 댓글 내용
     * @return 댓글 작성 Query 실행
     * @exception Exception - 조회시 발생한 예외
     */
    @RequestMapping("/insert")
    public String commentInsert(HttpServletRequest request) throws Exception{


        return "comment/commentInsert";				//댓글 작성 Query 실행
    }

    @RequestMapping("/insertProc")
    public String commentInsertProc(HttpServletRequest request) throws Exception{
        Account account = (Account)SecurityContextHolder.getContext().getAuthentication().getPrincipal();	//계정정보 받아오기
        String idxx_numb = request.getParameter("idxx_numb");
        String comm_cont = request.getParameter("comm_cont");
        String comm_idxx = commentService.commentSelectIdxxService();


        CommentVO comment = new CommentVO();								//댓글 VO 생성
        comment.setIdxx_numb(idxx_numb);									//글의 idxx_numb 등록
        comment.setComm_idxx(comm_idxx); 	//comm_idxx 생성
        comment.setComm_cont(comm_cont);									//댓글의 내용 등록
        comment.setUser_name(account.getUsername());						//사용자 이름 등록

        commentService.commentInsertService(comment);

        return "/detail/"+idxx_numb;
    }

    /*
     * 답글 수정
     * @param comm_idxx - 수정할 댓글 ID
     * 		  comm_cont - 수정할 댓글 내용
     * @return 댓글 수정 Query 실행
     * @exception Exception - 조회시 발생한 예외
     */
    @RequestMapping("/update")
    public int commentUpdate(@RequestParam String comm_idxx, @RequestParam String comm_cont) throws Exception{

        CommentVO comment = new CommentVO();					//댓글 VO 생성
        comment.setComm_idxx(comm_idxx);						//댓글 ID 등록
        comment.setComm_cont(comm_cont);						//댓글 내용 등록

        return commentService.commnetUpdateService(comment);	//댓글 수정 Query 실행
    }

    /*
     * 답글 삭제
     * @param comm_idxx - 수정할 댓글 ID
     * 		  comm_cont - 수정할 댓글 내용
     * @return 댓글 수정 Query 실행
     * @exception Exception - 조회시 발생한 예외
     */
    @RequestMapping("/delete")
    @ResponseBody
    public int commentDelete(HttpServletRequest request) throws Exception{
        String comm_idxx = request.getParameter("comm_idxx");

        return commentService.commentDeleteService(comm_idxx);
    }
}
