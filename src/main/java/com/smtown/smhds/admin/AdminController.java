package com.smtown.smhds.admin;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * <pre>
 *	BoardController.java - 요청사항 게시판 컨트롤러
 * </pre>
 *
 * @author	최해림
 * @since	2019.06.04
 * @version	1.0
 *
 * <pre>
 * == Modification Information ==
 * Date		Modifier		Comment
 * ====================================================
 * 2019.06.04	최해림		Initial Created.
 * ====================================================
 * </pre>
 *
 * Copyright SM Entertainment.(C) All right reserved.
 */

@Controller
public class AdminController {

    /*
     * 관리자 페이지로 접근시 페이지 넘김
     * @param
     * @return "/main/admin"
     * @exception Exception - 조회시 발생한 예외
     */
    @RequestMapping("/admin")
    public String admin() {


        return "main/admin";
    }

}
