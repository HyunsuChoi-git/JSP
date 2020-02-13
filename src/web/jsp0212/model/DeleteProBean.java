package web.jsp0212.model;

import java.io.IOException;
import java.rmi.ServerException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class DeleteProBean implements SuperBean {

	@Override
	public String actionBean(HttpServletRequest req, HttpServletResponse resp) throws ServerException, IOException {
		
		req.setCharacterEncoding("UTF-8");
		
		//세션처리

		boolean wriCheck = false;
		try {
			int num = Integer.parseInt(req.getParameter("num"));
			String pageNum = req.getParameter("pageNum");
			String pw = null;
			
			BoardDAO dao = BoardDAO.getInstance();
			int result = 0;
			if(req.getParameter("pw") != null) {
				pw = req.getParameter("pw");
				
				result = dao.deleteArticle(num, pw);
				
				wriCheck = true;
			}else { //관리자용 삭제
				result = dao.deleteArticle(num);
				wriCheck = true;
			}
			req.setAttribute("result", result);
			
		}catch(Exception e) {
			wriCheck = false;
		}
		
		req.setAttribute("wriCheck", wriCheck);
		
		return "/WEB-INF/board_views/deletePro.jsp";
	}

}
