package com.smtown.smhds.faq;

import java.io.File;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FilenameUtils;
import org.apache.commons.lang3.RandomStringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.multipart.MultipartFile;

import com.smtown.smhds.account.Account;
import com.smtown.smhds.board.BoardService;
import com.smtown.smhds.faq.FaqService;
import com.smtown.smhds.faq.FaqVO;
import com.smtown.smhds.util.FileVO;
import com.smtown.smhds.util.PageMaker;
import com.smtown.smhds.util.PrintPage;

/**
 * <pre>
 *	faqController.java - FAQ 게시판 컨트롤러
 * </pre>
 *
 * @author	최해림
 * @since	2019.06.17
 * @version	1.0
 *
 * <pre>
 * == Modification Information ==
 * Date		Modifier		Comment
 * ====================================================
 * 2019.06.17	최해림		Initial Created.
 * ====================================================
 * </pre>
 *
 * Copyright SM Entertainment.(C) All right reserved.
 */

@Controller
public class FaqController {
    /*
     * faq 게시판 서비스(Service) 클래스
     */
    @Autowired
    FaqService faqService;

    /*
     * 요청사항 게시판 서비스(Service) 클래스
     */
    @Autowired
    BoardService boardService;

    /*
     * faq 목록
     * @param model - 게시글 정보,페이징 정보, 현재 페이지 ,
     *		  printPage - 조회하려는 페이징 정보 printPageteria에 파라미터 없을 시에 생성자에서 기본 값으로 셋팅(page = 1 , perPageNum=10)
     * @return "/faq/faqList"
     * @exception Exception - 조회시 발생한 예외
     */
    @RequestMapping(value="/faq_list", method=RequestMethod.GET)
    public String faqList(@ModelAttribute("printPage") PrintPage printPage, Model model) throws Exception{

        int listCnt = faqService.faqcount(printPage); 		//전체 게시글 수

        model.addAttribute("list",faqService.faqListService(printPage));	//전체 게시글 List

        PageMaker pageMaker = new PageMaker();	//페이징 처리 객체 생성
        pageMaker.setprintPage(printPage);		//현재 페이지 정보
        pageMaker.setTotalCount(listCnt);		//전체 게시글 수

        model.addAttribute("pageMaker",pageMaker);
        model.addAttribute("curpage",printPage.getPage());

        return "faq/FaqList";
    }

    /*
     * 자동완성
     * @param printPage - 출력할 페이지 정보
     * 		  model - 자동완성 리스트
     * @return "/common/AutoComplete"
     * @exception Exception - 조회시 발생한 예외
     */
    @RequestMapping(value="/faq/autoComplete")
    public String suggestion(@ModelAttribute("printPage") PrintPage printPage, Model model) throws Exception{

        List<String> autoComplete = faqService.faqSuggestionService(printPage);
        model.addAttribute("list", autoComplete);

        return "common/AutoComplete";

    }

    /*
     * faq 상세
     * @param idxx_numb - 글 번호
     * 		  model - 글 정보
     * @return "/faq/faqDetail"
     * @exception Exception - 조회시 발생한 예외
     */
    @RequestMapping("/faq_detail/{idxx_numb}")
    public String faqDetail(@PathVariable String idxx_numb, Model model) throws Exception{

        model.addAttribute("detail", faqService.faqDetailService(idxx_numb));
        model.addAttribute("files", boardService.fileDetailService(idxx_numb));

        return "faq/FaqDetail";
    }

    /*
     * faq 작성
     * @param
     * @return "/faq/faqInsert"
     * @exception Exception - 조회시 발생한 예외
     */
    @RequestMapping("/faq_insert")
    public String faqInsertForm() {
        return "faq/FaqInsert";
    }

    /*
     * 게시글 DB에 등록
     * @param request - 요청
     * 		  files - 파일
     * @return "/list"
     * @exception Exception - 조회시 발생한 예외
     */
    @RequestMapping("/faqInsertProc")
    public String boardInsertProc(HttpServletRequest request,HttpServletResponse response ,  @RequestPart MultipartFile files) throws Exception{
        FaqVO board = new FaqVO();
        FileVO file = new FileVO();
        PrintWriter out = null;

        Account account = (Account)SecurityContextHolder.getContext().getAuthentication().getPrincipal();

        //idxx_numb 만들기
        String idxx_numb = "";

        idxx_numb = faqService.faqSelectIdxxService(); //게시글 주키 생성 로직


        board.setTitl_name(request.getParameter("titl_name"));
        board.setCont_ents(request.getParameter("cont_ents"));
        board.setUser_name(account.getUsername());
        board.setCrea_user(account.getUsername());
        board.setIdxx_numb(idxx_numb);

        if(files.isEmpty()) {
            faqService.faqInsertService(board);
        }else {
            //fileUrl : 업로드된 파일 경로
            //destinationFileName : rename파일명
            //fileName : 파일 원본 이름
            //fileNameExtension : 확장자

            String fileName = files.getOriginalFilename();
            String fileNameExtension = FilenameUtils.getExtension(fileName).toLowerCase();
            File destinationFile;
            String destinationFileName;

            //String uploadPath = request.getSession().getServletContext().getRealPath("/");
            //String attachPath = "WEB-INF\\uploadFiles\\";
            //String fileUrl = uploadPath+attachPath;

            //권한을 줄 수 있음(해야함)

            String fileUrl = "C:\\upload\\";


            // 파일 확장자 체크
            // 올릴 수 있는 파일 : jpg, png, jpeg, gif, bmp, avi, mpg, mpeg, mov, mp4, wmv, doc, docx, ppt, pptx, xls, xlsx, pdf, hwp
            if(
                    !"jpg".equalsIgnoreCase(fileNameExtension)
                            && !"png".equalsIgnoreCase(fileNameExtension)
                            && !"jpeg".equalsIgnoreCase(fileNameExtension)
                            && !"gif".equalsIgnoreCase(fileNameExtension)
                            && !"bmp".equalsIgnoreCase(fileNameExtension)
                            && !"avi".equalsIgnoreCase(fileNameExtension)
                            && !"mpg".equalsIgnoreCase(fileNameExtension)
                            && !"mpeg".equalsIgnoreCase(fileNameExtension)
                            && !"mov".equalsIgnoreCase(fileNameExtension)
                            && !"mp4".equalsIgnoreCase(fileNameExtension)
                            && !"wmv".equalsIgnoreCase(fileNameExtension)
                            && !"doc".equalsIgnoreCase(fileNameExtension)
                            && !"docx".equalsIgnoreCase(fileNameExtension)
                            && !"ppt".equalsIgnoreCase(fileNameExtension)
                            && !"pptx".equalsIgnoreCase(fileNameExtension)
                            && !"xls".equalsIgnoreCase(fileNameExtension)
                            && !"xlsx".equalsIgnoreCase(fileNameExtension)
                            && !"pdf".equalsIgnoreCase(fileNameExtension)
                            && !"hwp".equalsIgnoreCase(fileNameExtension)
            ){


                response.setContentType("text/html; charset=UTF-8");
                response.getWriter().println("<script>alert('파일 형식이 올바르지 않습니다.'); history.go(-1); </script>");
                response.getWriter().flush();

                return "faq/FaqInsert";
            }
            do {
                destinationFileName = RandomStringUtils.randomAlphanumeric(32) + "." + fileNameExtension;
                destinationFile = new File(fileUrl + destinationFileName);
            }while(destinationFile.exists());

            destinationFile.getParentFile().mkdirs();
            files.transferTo(destinationFile);

            faqService.faqInsertService(board);

            file.setIdxx_numb(board.getIdxx_numb());
            file.setFile_name(destinationFileName);
            file.setFile_orig(fileName);
            file.setFile_urll(fileUrl);


            boardService.fileInsertService(file);
        }

        return "redirect:/faq_list";
    }

    /*
     * 게시글 삭제
     * @param idxx_numb - 글 번호
     * @return "/list"
     * @exception Exception - 조회시 발생한 예외
     */
    @RequestMapping("/faq_delete/{idxx_numb}")
    public String faqDelete(@PathVariable String idxx_numb) throws Exception{
        faqService.faqDeleteService(idxx_numb);
        if(boardService.fileDetailService(idxx_numb) != null)
            boardService.fileDeleteService(idxx_numb);

        return "redirect:/faq_list";
    }

    /*
     * 게시글 수정
     * @param idxx_numb - 글 번호
     * 		  model - 게시글 정보
     * @return "/faq/faqUpdate"
     * @exception Exception - 조회시 발생한 예외
     */
    @RequestMapping("/faq_update/{idxx_numb}")
    public String boardUpdateForm(@PathVariable String idxx_numb, Model model) throws Exception{

        model.addAttribute("detail", faqService.faqDetailService(idxx_numb));
        if(boardService.fileDetailService(idxx_numb) != null) {
            model.addAttribute("files",boardService.fileDetailService(idxx_numb));
        }
        return "faq/FaqUpdate";
    }

    /*
     * 게시글 DB 수정
     * @param request - 요청
     * @return "/faq_detail/{idxx_numb}"
     * @exception Exception - 조회시 발생한 예외
     */
    @RequestMapping("/faq_updateProc")
    public String boardUpdateProc(HttpServletRequest request) throws Exception{
        FaqVO faq = new FaqVO();

        faq.setTitl_name(request.getParameter("titl_name"));
        faq.setCont_ents(request.getParameter("cont_ents"));
        faq.setIdxx_numb(request.getParameter("idxx_numb"));

        faqService.faqUpdateService(faq);

        return "redirect:/faq_detail/"+request.getParameter("idxx_numb");
    }
}
