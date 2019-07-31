package com.smtown.smhds.board;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FilenameUtils;
import org.apache.commons.lang3.RandomStringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import com.smtown.smhds.account.Account;
import com.smtown.smhds.faq.FaqService;
import com.smtown.smhds.notice.NoticeService;
import com.smtown.smhds.util.FileVO;
import com.smtown.smhds.util.PageMaker;
import com.smtown.smhds.util.PrintPage;


/**
 * <pre>
 *	BoardController.java - 요청사항 게시판 컨트롤러
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
@Controller
public class BoardController{
    // 요청사항 게시판 서비스(Service) 클래스
    private final BoardService boardService;

    //공지사항 게시판 서비스(Service) 클래스
    private final NoticeService noticeService;

    // faq 게시판 서비스(Service) 클래스
    private final FaqService faqService;


    @Autowired
    public BoardController(BoardService boardService, NoticeService noticeService, FaqService faqService){
        this.boardService = boardService;
        this.noticeService = noticeService;
        this.faqService = faqService;
    }

    /*
     * 최초 프로젝트 접근 시 목록페이지로 넘김
     * @param
     * @return "/main"
     * @exception Exception - 조회시 발생한 예외
     */
    @RequestMapping(value="/")
    public String root() {
        return "redirect:/main";
    }

    /*
     * 로그인 페이지
     * @param
     * @return "/main/login"
     * @exception Exception - 조회시 발생한 예외
     */
    @RequestMapping("/login")
    public String login() {
        return "main/login";
    }

    /*
     * 비밀번호 초기화 페이지
     * @param
     * @return "/main/login"
     * @exception Exception - 조회시 발생한 예외
     */
    @RequestMapping("/forgot")
    public String forgot() {
        return "main/forgot";
    }

    /*
     * 생일 인증
     * @param request : 입력된 ID, 생일
     * @return returnMap : 조회성공 여부(성공 1, 실패 0)
     * @exception Exception - 조회시 발생한 예외
     */
    @RequestMapping(value = "/forgotProc", method = RequestMethod.POST)
    @ResponseBody
    public Map<String,String> forgotProc(HttpServletRequest request) throws Exception{
        Map<String,String> returnMap = new HashMap<>();	//ID, 생일 추가할 맵 생성


        System.out.println("isItPermit==>" );
        String user_name = request.getParameter("user_name");	//입력된 ID 받아오기
        String birt_hday = request.getParameter("birt_hday");	//입력된 생일 받아오기

        System.out.println("user_name : "+user_name);


        Account account = new Account();								//account 객체 생성
        account.setUser_name(user_name);								//user_name 설정
        account.setBirt_hday(birt_hday);								//birt_hday 설정

        int isItPermit = boardService.boardCompareBirthService(account);		//user_name, birt_hday 비교 서비스


        System.out.println("isItPermit==>" + isItPermit);

        returnMap.put("isItPermit",String.valueOf(isItPermit));					//조회성공 1, 조회실패 0을 isItPermit값에 저장후 리턴

        return returnMap;
    }

    /*
     * 비밀번호 재설정
     * @param request : 입력된 ID, 비밀번호
     * @return 로그인 페이지로 이동
     * @exception Exception - 조회시 발생한 예외
     */
    @RequestMapping(value = "/resetPWProc", method = RequestMethod.POST)
    @ResponseBody
    public int resetPWProc(HttpServletRequest request) throws Exception{
        String pass_word="{noop}";	//평문 비밀번호 앞에 추가(암호화 예정)
        String user_name = request.getParameter("user_name");	//입력된 ID 받아오기
        pass_word += request.getParameter("pass_word");	//입력된 비밀번호 받아오기



        Account account = new Account();	//account 객체 생성
        account.setUser_name(user_name);	//user_name 설정
        account.setPass_word(pass_word);	//pass_word 설정

        return boardService.boardResetPasswordService(account);	//비밀번호 변경 서비스

    }
    /*
     * 게시판 목록
     * @param model - 게시글 정보,페이징 정보, 현재 페이지 ,
     *		  printPage - 조회하려는 페이징 정보 printPageteria에 파라미터 없을 시에 생성자에서 기본 값으로 셋팅(page = 1 , perPageNum=10)
     * @return "/board/BoardList"
     * @exception Exception - 조회시 발생한 예외
     */
    @RequestMapping(value="/list")
    public String boardList(HttpServletRequest request, @ModelAttribute("printPage") PrintPage printPage, Model model) throws Exception{

        String cate_gory = request.getParameter("cate_gory");	//카테고리받아옹기

        System.out.println("cate_gory : "+cate_gory);

        printPage.setCate_gory(cate_gory);
        int listCnt = boardService.boardcount(printPage); 		//전체 게시글 수


        model.addAttribute("list",boardService.boardListService(printPage));	//전체 게시글 List
        model.addAttribute("category_list",boardService.boardCateListService());//카테고리 이름 넘기기


        PageMaker pageMaker = new PageMaker();	//페이징 처리 객체 생성
        pageMaker.setprintPage(printPage);		//현재 페이지 정보
        pageMaker.setTotalCount(listCnt);		//전체 게시글 수

        model.addAttribute("pageMaker",pageMaker);
        model.addAttribute("curpage",printPage.getPage());
        model.addAttribute("cate_gory",cate_gory);

        return "board/BoardList";
    }

    /*
     * 게시판 상세
     * @param idxx_numb - 글 번호
     * 		  model - 글 정보
     * @return "/board/BoardDetail"
     * @exception Exception - 조회시 발생한 예외
     */
    @RequestMapping("/detail/{idxx_numb}")
    public String boardDetail(@PathVariable String idxx_numb, Model model) throws Exception{

        model.addAttribute("detail", boardService.boardDetailService(idxx_numb)); 	//글정보를 넘기기
        model.addAttribute("files", boardService.fileDetailService(idxx_numb));		//파일 정보 넘기기


//		if(fileinfo.equals(true)) {
//
//		}else {
//			model.addAttribute("files", "false");		// 파일 정보 가져오기
//		}


        //1. 파일이 존재 하는지 확인

        //2_1 존재할경우 파일 정보 , 파일 위치 , 확장자

        //2_2 존재하지 않을 경우 , return null


        return "board/BoardDetail";
    }

    /*
     * 파일 다운로드
     * @param idxx_numb - 글 번호
     * 		  request - 요청
     * 		  response - 응답
     * @return
     * @exception Exception - 조회시 발생한 예외
     */
    @RequestMapping(value="/fileDown/{idxx_numb}")
    public void fileDown(@PathVariable String idxx_numb, HttpServletRequest request, HttpServletResponse response) throws Exception{

        request.setCharacterEncoding("UTF-8");
        FileVO fileVO = boardService.fileDetailService(idxx_numb);

        try {
            //파일 업로드 된 경로
            //fileUrl : 업로드된 파일 경로
            //fileName : 파일 원본 이름

            String fileUrl = fileVO.getFile_urll();
            fileUrl += "/";
            String fileName = fileVO.getFile_name();

            //실제 내보낼 파일명
            //oriFileName : 원래 파일명
            //skip : 파일 읽지못하면 false
            //client : 웹 브라우저 확인
            String oriFileName = fileVO.getFile_orig();
            InputStream in = null;
            OutputStream os = null;
            File file = null;
            boolean skip = false;
            String browser = "";

            //파일을 읽어 스트림에 담기
            try {
                file = new File(fileUrl, fileName);
                in = new FileInputStream(file);
            }catch(FileNotFoundException fe) {
                skip = true;
            }
            browser = request.getHeader("User-Agent");

            //파일 다운로드 헤더 지정
            response.reset();
            response.setContentType("application/octet-stream");
            response.setHeader("Content-DesprintPageption", "JSP Generated Data");

            if(!skip) {
                //IE
                if(browser.contains("MSIE")) {
                    response.setHeader("Content-Disposition", "attachment; filename=\"" + java.net.URLEncoder.encode(oriFileName, "UTF-8").replaceAll("\\+", "\\ ")+"\"");

                }
                //IE 11 이상
                else if(browser.contains("Trident")) {
                    response.setHeader("Content-Disposition", "attachment; filename=\"" + java.net.URLEncoder.encode(oriFileName, "UTF-8").replaceAll("\\+", "\\ ")+"\"");
                }
                else {
                    response.setHeader("Content-Disposition", "attachment; filename=\""
                            + new String(oriFileName.getBytes("UTF-8"), "ISO8859_1") + "\"");
                    response.setHeader("Content-Type", "application/octet-stream; charset=utf-8");
                }
                response.setHeader("Content-Length", "" + file.length());
                os = response.getOutputStream();
                byte b[] = new byte[(int)file.length()];
                int leng = 0;
                while((leng = in.read(b)) > 0) {
                    os.write(b, 0 ,leng);
                }
            }else {
                response.setContentType("text/html;charset=UTF-8");

                PrintWriter out = response.getWriter();
                out.println("<script>alert('파일을 찾을 수 없습니다.');history.back();</script>");
                out.flush();
            }
            in.close();
            os.close();
        } catch (Exception e) {
            System.out.println("Error : " + e.getMessage());
        }
    }

    /*
     * 게시글 작성
     * @param
     * @return "/board/BoardInsert"
     * @exception Exception - 조회시 발생한 예외
     */
    @RequestMapping("/insert")
    public String boardInsertForm(Model model) throws Exception {
        model.addAttribute("category_list",boardService.boardCateListService());//카테고리 이름 넘기기

        return "board/BoardInsert";
    }

    /*
     * 게시글 DB에 등록
     * @param request - 요청
     * 		  files - 파일
     * @return "/list"
     * @exception Exception - 조회시 발생한 예외
     */
    @RequestMapping("/insertProc")
    public String boardInsertProc(HttpServletRequest request,HttpServletResponse response ,  @RequestPart MultipartFile files) throws Exception{
        BoardVO board = new BoardVO();
        FileVO file = new FileVO();
        String idxx_numb = boardService.boardSelectIdxxService(); //게시글 주키 생성

        Account account = (Account)SecurityContextHolder.getContext().getAuthentication().getPrincipal();


        board.setTitl_name(request.getParameter("titl_name"));	//게시글 제목
        board.setCont_ents(request.getParameter("cont_ents"));	//게시글 내용
        board.setUser_name(account.getUsername());				//작성자 이름
        board.setCrea_user(account.getUsername());				//작성자 이름
        board.setStat_flag("01");								//첫 글 작성시 신규상태로 초기화( 01 - 신규/ 02 - 담당자 접수/ 03 - 진행/ 04 - 완료)
        board.setIdxx_numb(idxx_numb);							//idxx_numg 생성
        board.setCate_gory(request.getParameter("cate_gory"));

        if(files.isEmpty()) {
            boardService.boardInsertService(board);
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
            if(!"jpg".equalsIgnoreCase(fileNameExtension) && !"png".equalsIgnoreCase(fileNameExtension)
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

                return "board/BoardInsert";
            }
            do {
                destinationFileName = RandomStringUtils.randomAlphanumeric(32) + "." + fileNameExtension;
                destinationFile = new File(fileUrl + destinationFileName);
            }while(destinationFile.exists());


            boolean isDirectoryCreated = destinationFile.getParentFile().exists() || destinationFile.getParentFile().mkdirs();
            System.out.println(isDirectoryCreated);
            files.transferTo(destinationFile);

            boardService.boardInsertService(board);

            file.setIdxx_numb(board.getIdxx_numb());
            file.setFile_name(destinationFileName);
            file.setFile_orig(fileName);
            file.setFile_urll(fileUrl);


            boardService.fileInsertService(file);
        }

        return "redirect:/list/";
    }

    /*
     * 게시글 수정
     * @param idxx_numb - 글 번호
     * 		  model - 게시글 정보
     * @return "/board/BoardUpdate"
     * @exception Exception - 조회시 발생한 예외
     */
    @RequestMapping("/update/{idxx_numb}")
    public String boardUpdateForm(@PathVariable String idxx_numb, Model model) throws Exception{
        model.addAttribute("category_list",boardService.boardCateListService());	//카테고리 이름 넘기기
        model.addAttribute("detail", boardService.boardDetailService(idxx_numb));	//idxx_numb를 가진 글 상세정보 넘기기
        if(boardService.fileDetailService(idxx_numb) != null) {									//idxx_numb를 가진 파일 상세정보 체크
            model.addAttribute("files",boardService.fileDetailService(idxx_numb));	//idxx_numb를 가진 파일 상세정보 넘기기
        }
        return "board/BoardUpdate";
    }

    /*
     * 게시글 DB 수정
     * @param request - idxx_numb 요청
     * @return "/detail/idxx_numb"
     * @exception Exception - 조회시 발생한 예외
     */
    @RequestMapping("/updateProc")
    public String boardUpdateProc(HttpServletRequest request) throws Exception{
        BoardVO board = new BoardVO();

        board.setTitl_name(request.getParameter("titl_name"));
        board.setCont_ents(request.getParameter("cont_ents"));
        board.setIdxx_numb(request.getParameter("idxx_numb"));


        boardService.boardUpdateService(board);

        return "redirect:/detail/"+request.getParameter("idxx_numb");
    }

    /*
     * 게시글 진행상황 DB 수정
     * @param request - idxx_numb, stat_flag
     * @return "/detail/idxx_numb"
     * @exception Exception - 조회시 발생한 예외
     */
    @RequestMapping("/updateStatProc")
    public String boardUpdateStatProc(HttpServletRequest request) throws Exception{
        BoardVO board = new BoardVO();

        board.setStat_flag(request.getParameter("stat_flag"));
        board.setIdxx_numb(request.getParameter("idxx_numb"));

        boardService.boardUpdateStatService(board);

        return "redirect:/detail/"+request.getParameter("idxx_numb");
    }

    /*
     * 게시글 삭제
     * @param
     * @return "/list/"
     * @exception Exception - 조회시 발생한 예외
     */
    @RequestMapping("/delete")
    public String boardDelete(HttpServletRequest request) throws Exception{
        String idxx_numb = request.getParameter("idxx_numb");
        boardService.boardDeleteService(idxx_numb);
        if(boardService.fileDetailService(idxx_numb) != null)
            boardService.fileDeleteService(idxx_numb);

        return "redirect:/list/";
    }

    /*
     * 자동완성
     * @param printPage - 출력할 페이지 정보
     * 		  model - 자동완성 리스트
     * @return "/common/AutoComplete"
     * @exception Exception - 조회시 발생한 예외
     */
    @RequestMapping(value="/board/autoComplete")
    public String suggestion(@ModelAttribute("printPage") PrintPage printPage, Model model) throws Exception{

        List<String> autoComplete = boardService.boardSuggestionService(printPage);
        model.addAttribute("list", autoComplete);

        return "common/AutoComplete";

    }

    /*
     * 메인화면
     * @param model - 공지사항 5개 출력 , FAQ 5개 출력
     * @return "/main/boardMain"
     * @exception Exception - 조회시 발생한 예외
     */
    @RequestMapping(value="/main")
    public String boardMain(Model model) throws Exception{

        model.addAttribute("list",noticeService.noticeListMainService(5));	//전체 게시글 List
        model.addAttribute("faq_list",faqService.faqListMainService(5));

        return "main/boardMain";
    }

    /*
     * 마이페이지
     * @param model - 최근 요청사항 진행 상태, 누적게시글
     * 		  printPage - 조회하려는 페이징 정보 printPageteria에 파라미터 없을 시에 생성자에서 기본 값으로 셋팅(page = 1 , perPageNum=10)
     * @return "/account/MyPage"
     * @exception Exception - 조회시 발생한 예외
     */
    @RequestMapping(value="/mypage", method=RequestMethod.GET)
    public String boardMypage(@ModelAttribute("printPage") PrintPage printPage, Model model) throws Exception{
        Account account = (Account)SecurityContextHolder.getContext().getAuthentication().getPrincipal();	//로그인한 계정 정보
        String user_name = account.getUsername();	//로그인한 계정의 user_name
        BoardVO board = boardService.boardCurrentService(user_name);	//로그인한 계정이 가장 최근에 작성한 글 정보

        String stat_flag ;

        if(board!=null) {
            stat_flag = board.getStat_flag();	//가장 최근에 작성한 글 상태 값 가져오기


            //상태에 따라 퍼센트로 전달
            switch(stat_flag) {
                case "0" :
                    stat_flag = "0";	//0%
                    break;
                case "01":
                    stat_flag = "10";	//10%
                    break;
                case "02":
                    stat_flag = "20";	//20%
                    break;
                case "03":
                    stat_flag = "50";	//50%
                    break;
                case "04":
                    stat_flag = "100";	//100%
                    break;
            }
            System.out.println("stat_flag : " + stat_flag);
        }else {
            stat_flag = "0";
        }
        model.addAttribute("detail",board);	//최근 작성한 게시글의 상세정보
        model.addAttribute("stat_flag",stat_flag);	//최근 작성한 게시글의 상태(%)

        int listCnt = boardService.boardCountByUserService(user_name);	//로그인한 계정이 작성한 전체 게시글 갯수
        System.out.println("listCnt : "+listCnt);

        model.addAttribute("list", boardService.boardListByUserService(printPage, user_name));	//로그인한 계정이 작성한 전체 게시글 List

        PageMaker pageMaker = new PageMaker();	//페이징 처리 객체 생성
        pageMaker.setprintPage(printPage);		//현재 페이지 정보
        pageMaker.setTotalCount(listCnt);		//전체 게시글 수

        model.addAttribute("pageMaker",pageMaker);
        model.addAttribute("curpage",printPage.getPage());


        return "account/MyPage";
    }

}