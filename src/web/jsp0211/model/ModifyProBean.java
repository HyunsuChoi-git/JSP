package web.jsp0211.model;

import java.io.IOException;
import java.rmi.ServerException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class ModifyProBean implements SuperBean  {

	@Override
	public String actionBean(HttpServletRequest req, HttpServletResponse resp) throws ServerException, IOException {
		
		
		boolean check = false;
		HttpSession session = req.getSession();
		if(session.getAttribute("memId") != null) {
			check = true;
			req.setCharacterEncoding("UTF-8");
			 
			//파일업로드 MultipartRequest
			String path = req.getRealPath("save");
			int max = 1024*1024*5;
			String enc = "UTF-8";
			DefaultFileRenamePolicy dp = new DefaultFileRenamePolicy();
			MultipartRequest mr = new MultipartRequest(req, path, max, enc, dp);
	
			// 넘어오는 데이터 : 비밀번호, 생년월일, email
			// form에서 id 안넘옴 : id를 알기위해 session에서 id 꺼내기
			String id = (String)session.getAttribute("memId");

			MemberDTO member = new MemberDTO();
			member.setId(id);	// dto에 직접 id 세팅해서 
			member.setPw(mr.getParameter("pw"));
			member.setBirth(mr.getParameter("birth"));
			member.setEmail(mr.getParameter("email"));
			// DB 업데이트시, 기존의 사진 이름 정보 분실을 방지하기 위해 처리
			// 새로 파일 업로드를 하고 넘어 왔다면
			if(mr.getFilesystemName("photo") != null){
				member.setPhoto(mr.getFilesystemName("photo"));
			}else{ 
				member.setPhoto(mr.getParameter("exPhoto"));
			}
				
			MemberDAO dao = MemberDAO.getInstance();
			dao.updateMember(member);
		
		}
		
		req.setAttribute("check", check);
		
		return "/WEB-INF/member_views/modifyPro.jsp";
	}

}
