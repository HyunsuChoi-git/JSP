package web.jsp0211.model;

import java.io.IOException;
import java.rmi.ServerException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

//모든 Bean 클레스의 조상이 될. SuperBean 인터페이스
public interface SuperBean {
	
	public String actionBean(HttpServletRequest req, 
			HttpServletResponse resp) throws ServerException, IOException; 
}
