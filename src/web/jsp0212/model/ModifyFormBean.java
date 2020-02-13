package web.jsp0212.model;

import java.io.IOException;
import java.rmi.ServerException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class ModifyFormBean implements SuperBean {

	@Override
	public String actionBean(HttpServletRequest req, HttpServletResponse resp) throws ServerException, IOException {
		
		
		//세션처리
		HttpSession s = req.getSession();

		boolean wriCheck = false;
		try {
			int num = Integer.parseInt(req.getParameter("num"));
			String pageNum = req.getParameter("pageNum");	
	
			BoardDAO dao = BoardDAO.getInstance();
			BoardDTO article = dao.getArticle(num);
			
			req.setAttribute("num", num);
			req.setAttribute("pageNum", pageNum);
			req.setAttribute("article", article);
			
			wriCheck = true;
		}catch(Exception e) {
			wriCheck = false;
		}
		
		req.setAttribute("wriCheck", wriCheck);
		
		return "/WEB-INF/board_views/modifyForm.jsp";
	}

}
