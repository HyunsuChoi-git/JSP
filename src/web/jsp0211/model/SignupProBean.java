package web.jsp0211.model;

import java.io.IOException;
import java.rmi.ServerException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class SignupProBean implements SuperBean {

	@Override
	public String actionBean(HttpServletRequest req, HttpServletResponse resp) throws ServerException, IOException {
		
		req.setCharacterEncoding("UTF-8");
		
		boolean check = false;
		HttpSession session = req.getSession();
		if(session.getAttribute("memId") == null) {
			check = true;
			// 파일업로드 MultipartRequest
			String path = req.getRealPath("save");
			int max = 1024*1024*5;
			String enc = "UTF-8";
			DefaultFileRenamePolicy dp = new DefaultFileRenamePolicy();
			MultipartRequest mr = new MultipartRequest(req, path, max, enc, dp);
			
			MemberDTO member = new MemberDTO();
			
			member.setId(mr.getParameter("id"));
			member.setPw(mr.getParameter("pw"));
			member.setName(mr.getParameter("name"));
			member.setBirth(mr.getParameter("birth"));
			member.setEmail(mr.getParameter("email"));
			// 사진 저장 이름 (이름이 중복되었으면 뒤에 숫자가 붙은 이름으로 DB에 저장) 
			member.setPhoto(mr.getFilesystemName("photo"));
			
			MemberDAO dao = MemberDAO.getInstance();
			dao.insertMember(member);
			
			
//			List list = new ArrayList();
//			list.add(mr.getParameter("id"));
//			list.add(mr.getParameter("pw"));
//			list.add(mr.getParameter("name"));
//			list.add(mr.getParameter("birth"));
//			list.add(mr.getParameter("email"));
//			list.add(mr.getFilesystemName("photo"));
//			
//			String sql = "insert into imagemember values(?,?,?,?,?,?,sysdate)";
//			
//			MemberDAO2 dao2 = MemberDAO2.getInstance();
//			result = dao2.executeUpdate(sql, list);
			
		}	
		
		req.setAttribute("check", check);
		
		return "/WEB-INF/member_views/signupPro.jsp";
	}

}
