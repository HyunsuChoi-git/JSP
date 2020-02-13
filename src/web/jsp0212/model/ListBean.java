package web.jsp0212.model;

import java.io.IOException;
import java.rmi.ServerException;
import java.text.SimpleDateFormat;
import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class ListBean implements SuperBean {

	@Override
	public String actionBean(HttpServletRequest req, HttpServletResponse resp) throws ServerException, IOException {
		
		//세션 확인
		
		HttpSession session = req.getSession();
		String id = null;
		String pw = null;
		String auto = null; // 자동로그인 파리미터 받기
		
		String admin = null;
		boolean check = false;
		if(session.getAttribute("memId") != null) {
			check = true;
			if(session.getAttribute("memId").equals("admin")) {
				admin = "admin";
				req.setAttribute("admin", admin);
			}
		}else {
			
			//#2. 쿠키 있으면 꺼내주기
			Cookie[] cs = req.getCookies();
			if(cs != null){
				for(Cookie coo : cs){
					if(coo.getName().equals("autoId")) id = coo.getValue();
					if(coo.getName().equals("autoPw")) pw = coo.getValue();
					if(coo.getName().equals("autoCh")) auto = coo.getValue();
				}
			}
			
			if(id != null && pw != null && auto != null) {
				session.setAttribute("memId", id);
				check = true;
			}
		}
		
		
		int pageSize = 10;
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd HH:mm");
		
		String pageNum = null;
		if(req.getParameter("pageNum") != null){
			pageNum = req.getParameter("pageNum");
		}else{
			pageNum = "1";
		}
		
		
		int currentPage = Integer.parseInt(pageNum);
		int startRow = (currentPage - 1) * pageSize + 1;
		int endRow = currentPage * pageSize;
		int count = 0;
		int number = 0;
		
		//#게시판 글 가져오기
		
		//검색으로 온 경우와 아닌경우 나누기
		
		String sel = null;
		String select = null;
		
		List articleList = null;
		BoardDAO dao = BoardDAO.getInstance();
		BoardDTO article = null;
		
		//검색으로 들어온 경우
		if(req.getParameter("sel") != null && req.getParameter("select") != null) {
			sel = req.getParameter("sel");
			select = req.getParameter("select");
			
			count = dao.getArticleCount(sel, select);
			if(count > 0){
				articleList = dao.getArticles(sel, select, startRow, endRow);
			}
			
		}else { //전체 개시글 인 경우
		
			count = dao.getArticleCount();
			if(count > 0){
				articleList = dao.getArticles(startRow, endRow);
			}
		
		}
		number = count - (currentPage - 1) * pageSize;

		
		
		
		req.setAttribute("count", count);
		req.setAttribute("pageSize", pageSize);
		req.setAttribute("number", number);
		req.setAttribute("article", article);
		req.setAttribute("articleList", articleList);
		req.setAttribute("currentPage", currentPage);
		req.setAttribute("sdf", sdf);
		req.setAttribute("check", check);

		return "/WEB-INF/board_views/list.jsp";
	}

}
