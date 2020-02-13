package web.jsp0211.model;

import java.io.File;
import java.io.IOException;
import java.rmi.ServerException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class Admin_deleteProBean implements SuperBean {

	@Override
	public String actionBean(HttpServletRequest req, HttpServletResponse resp) throws ServerException, IOException {
		
		boolean admCheck = false;
		
		HttpSession session = req.getSession();
		if(session.getAttribute("memId").equals("admin")) { 
			admCheck = true;
			
			String id = req.getParameter("id");
			MemberDAO dao = MemberDAO.getInstance();
			String photo = dao.getPhotoName(id);
			int result = dao.deleteMember(id);
			
			if(result > 0) {
				if(photo != null){
					String path = req.getRealPath("save");
					path += ("\\" + photo);
					File f = new File(path);
					f.delete();
				}
			}
			
			req.setAttribute("result", result);
			
		}
		
		req.setAttribute("admCheck", admCheck);
		
		
		return "/WEB-INF/member_views/admin_deletePro.jsp";
	}

}
