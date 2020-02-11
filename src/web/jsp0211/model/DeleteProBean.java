package web.jsp0211.model;

import java.io.File;
import java.io.IOException;
import java.rmi.ServerException;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class DeleteProBean implements SuperBean {

	@Override
	public String actionBean(HttpServletRequest req, HttpServletResponse resp) throws ServerException, IOException {
		
		boolean check = false;
		int result = 0;
		HttpSession session = req.getSession();
		if(session.getAttribute("memId") != null) { 
			check = true;
			
			String id = (String)session.getAttribute("memId");
			String pw = req.getParameter("pw");
			
			String path = req.getRealPath("save");
			//D:\mysource\jsp\workspace\.metadata\.plugins
			//  \org.eclipse.wst.server.core\tmp0\wtpwebapps\web\save\사진명
			MemberDAO dao = MemberDAO.getInstance();
			String photoName = dao.getPhotoName(id);
			if(photoName != null){
				path += ("\\" + photoName);
				File f = new File(path);
				f.delete();
			}
			result = dao.deleteMember(id, pw);
			
			// result : -1 (아이디 이상함,세션생성부분확인), 0 (비번 오류), 1(탈퇴 정상처리)
			if(result == 1) {	// 탈퇴 처리가 됬다면,
				session.invalidate();
				Cookie[] cs = req.getCookies();	
				if(cs != null){	 
					for(Cookie coo : cs){ 
				
						if(coo.getName().equals("autoId") || coo.getName().equals("autoPw") || coo.getName().equals("autoCh") ){	 
							coo.setMaxAge(0);
							resp.addCookie(coo);
						}
						
					}
				}			
		
		
			}
		}
		
		req.setAttribute("result", result);
		req.setAttribute("check", check);
		System.out.println(result);
		return "/WEB-INF/member_views/deletePro.jsp";
	}

}
