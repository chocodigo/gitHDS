package com.smtown.smhds.comment;

import java.util.List;

/**
 * <pre>
 *	CommentMapper.java - 댓글 매퍼
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

public interface CommentMapper {
    public int commentCount() throws Exception;										//댓글 갯수

    public List<CommentVO> commentList(String idxx_numb) throws Exception;			//댓글 목록

    public int commentInsert(CommentVO comment) throws Exception;					//댓글 작성

    public int commentUpdate(CommentVO comment) throws Exception;					//댓글 수정

    public int commentDelete(String comm_idxx) throws Exception;					//댓글 삭제

    public String commentSelectIdxx() throws Exception;				//comm_idxx 생성
}
