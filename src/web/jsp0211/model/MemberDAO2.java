package web.jsp0211.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class MemberDAO2 {
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	// 싱글턴으로 변경
	private static MemberDAO2 instance = new MemberDAO2();
	private MemberDAO2() {}
	public static MemberDAO2 getInstance() {
		return instance;
	}
	
	private Connection getConnection() throws Exception {
		Context ctx = new InitialContext();
		Context env = (Context)ctx.lookup("java:comp/env");
		DataSource ds = (DataSource)env.lookup("jdbc/orcl");
		return ds.getConnection();
	}
	
	private void getClose(Connection conn, PreparedStatement pstmt, ResultSet rs) {
		if(rs != null) try {rs.close();}catch(SQLException e) {e.printStackTrace();}
		if(pstmt != null) try {pstmt.close();}catch(SQLException e) {e.printStackTrace();}
		if(conn != null) try {conn.close();}catch(SQLException e) {e.printStackTrace();}
	}
	
	public int executeUpdate(String sql, List list) {
		int result = 0;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			if(list != null) {
				for(int i = 0; i < list.size(); i++) {
					Object o = list.get(i);
					if(o instanceof String) {
						pstmt.setString(i+1, (String)o);
					}else if(o instanceof Integer) {
						pstmt.setInt(i+1, (Integer)o);
					}else if(o instanceof Timestamp) {
						pstmt.setTimestamp(i+1, (Timestamp)o);
					}
				}
			}
			result = pstmt.executeUpdate();
			
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			getClose(conn,pstmt,rs);
		}
		
		return result;
	}
	
	
	
}
