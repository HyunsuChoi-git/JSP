package web.jsp0211.model;

import java.io.IOException;
import java.rmi.ServerException;
import java.text.SimpleDateFormat;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class Admin_memberBean implements SuperBean{

	@Override
	public String actionBean(HttpServletRequest req, HttpServletResponse resp) throws ServerException, IOException {
		
		//세션 쿠키 검사
		
		HttpSession session = req.getSession();
		
		boolean admCheck = false;
		if(session.getAttribute("memId").equals("admin")) {
			admCheck = true;
			
			String pageNum = "1";
			if(req.getParameter("pageNum") != null) pageNum = req.getParameter("pageNum");
			
			int pageSize = 10;
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd HH:mm");

			int currentPage = Integer.parseInt(pageNum);
			int startRow = (currentPage - 1) * pageSize + 1;
			int endRow = currentPage * pageSize;
			int count = 0;
			int number = 0;
			
			List allMembers = null;
			MemberDTO member = null;
			MemberDAO dao = MemberDAO.getInstance();
			
			//모든 멤버 정보 보내기
			String sel = null;
			String select = null;
			if(req.getParameter("sel") != null && req.getParameter("select") != null) {
				sel = req.getParameter("sel");
				select = req.getParameter("select");
				
				count = dao.getAllMemberCount(sel, select);
				if(count > 0) allMembers = dao.getAllMember(sel, select, startRow, endRow);
			}else {
				count = dao.getAllMemberCount();
				if(count > 0) allMembers = dao.getAllMember(startRow, endRow);
			}
			number = count - (currentPage - 1) * pageSize;
			
			req.setAttribute("pageSize", pageSize);
			req.setAttribute("count", count);
			req.setAttribute("number", number);
			req.setAttribute("pageNum", pageNum);
			req.setAttribute("allMembers", allMembers);
			req.setAttribute("member", member);
			req.setAttribute("sdf", sdf);
	
		}
		
		req.setAttribute("admCheck", admCheck);
		
		
		return "/WEB-INF/member_views/admin_member.jsp";
	}
	
}
