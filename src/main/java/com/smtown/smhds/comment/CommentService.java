package com.smtown.smhds.comment;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * <pre>
 *	CommentService.java - 요청사항 게시판 댓글 서비스
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

@Service
public class CommentService {

    /*
     * 요청사항 댓글 매퍼(Mapper) 클래스
     */
    @Autowired
    CommentMapper commentMapper;

    /*
     * 요청사항 게시판 댓글 갯수
     * @param
     * @return commentMapper.commentCount()
     * @exception Exception - 조회시 발생한 예외
     */
    public int commentCountService() throws Exception{
        return commentMapper.commentCount();
    }

    /*
     * 요청사항 게시판 댓글 갯수
     * @param
     * @return commentMapper.commentCount()
     * @exception Exception - 조회시 발생한 예외
     */
    public String commentSelectIdxxService() throws Exception{
        return commentMapper.commentSelectIdxx();
    }

    /*
     * 요청사항 게시판 댓글 목록
     * @param
     * @return commentMapper.commentList()
     * @exception Exception - 조회시 발생한 예외
     */
    public List<CommentVO> commentListService(String idxx_numb) throws Exception{
        return commentMapper.commentList(idxx_numb);
    }

    /*
     * 요청사항 게시판 댓글 등록
     * @param CommentVO
     * @return commentMapper.commentInsert(comment)
     * @exception Exception - 조회시 발생한 예외
     */
    public int commentInsertService(CommentVO comment) throws Exception{
        return commentMapper.commentInsert(comment);
    }

    /*
     * 요청사항 게시판 댓글 수정
     * @param CommentVO
     * @return commentMapper.commentUpdate()
     * @exception Exception - 조회시 발생한 예외
     */
    public int commnetUpdateService(CommentVO comment) throws Exception{
        return commentMapper.commentUpdate(comment);
    }

    /*
     * 요청사항 게시판 댓글 삭제
     * @param comm_idxx
     * @return commentMapper.commentDelete()
     * @exception Exception - 조회시 발생한 예외
     */
    public int commentDeleteService(String comm_idxx) throws Exception{
        return commentMapper.commentDelete(comm_idxx);
    }
}
