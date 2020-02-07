package web.member.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class MemberDAO {
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	private Connection getConnection() throws Exception{
		Context ctx = new InitialContext();
		Context env = (Context)ctx.lookup("java:comp/env");
		DataSource ds = (DataSource)env.lookup("jdbc/orcl"); 
		
		return ds.getConnection();
	}
	
	//회원가입 메소드
	public void signin(MemberDTO dto) {
		try {
			conn = getConnection();
			
			String sql = "insert into member values(?,?,?,?,?,sysdate)";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, dto.getId());
			pstmt.setString(2, dto.getPw());
			pstmt.setString(3, dto.getName());
			pstmt.setString(4, dto.getBirth());
			pstmt.setString(5, dto.getEmail());
			
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(pstmt != null) { try{ pstmt.close(); }catch(SQLException e) { e.printStackTrace(); } }
			if(conn != null) { try{ conn.close(); }catch(SQLException e) { e.printStackTrace(); } }
		}
	}
	
	//로그인 메소드
	public boolean login(String id, String pw) {
		boolean r = false;
		try {
			conn = getConnection();
			
			String sql = "select * from member where id=? and pw=?";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, id);
			pstmt.setString(2, pw);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				r = true;
			}		
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs != null) { try{ rs.close(); }catch(SQLException e) { e.printStackTrace(); } }
			if(pstmt != null) { try{ pstmt.close(); }catch(SQLException e) { e.printStackTrace(); } }
			if(conn != null) { try{ conn.close(); }catch(SQLException e) { e.printStackTrace(); } }
		}	
		return r;
	}
	

	//회원정보 가져오기
	public MemberDTO getMember(String id) {
			MemberDTO dto = null;
			try {
			conn = getConnection();
			
			String sql = "select * from member where id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				dto = new MemberDTO();
				dto.setId(id);
				dto.setPw(rs.getString("pw"));
				dto.setName(rs.getString("name"));
				dto.setBirth(rs.getString("birth"));
				dto.setEmail(rs.getString("email"));
				dto.setReg(rs.getTimestamp("reg"));
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs != null) { try{ rs.close(); }catch(SQLException e) { e.printStackTrace(); } }
			if(pstmt != null) { try{ pstmt.close(); }catch(SQLException e) { e.printStackTrace(); } }
			if(conn != null) { try{ conn.close(); }catch(SQLException e) { e.printStackTrace(); } }
		}	 
			return dto;
	}
	//회원 정보 수정
	public void modify(MemberDTO dto) {
		try {
			conn = getConnection();
			
			String sql = "update member set pw=?, birth=?, email=? where id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getPw());
			pstmt.setString(2, dto.getBirth());
			pstmt.setString(3, dto.getEmail());
			pstmt.setString(4, dto.getId());
			
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(pstmt != null) { try{ pstmt.close(); }catch(SQLException e) { e.printStackTrace(); } }
			if(conn != null) { try{ conn.close(); }catch(SQLException e) { e.printStackTrace(); } }
		}
	}
	
	public int delete(String id, String pw) {
		int a = -1;
		try {
			conn = getConnection();
			
			String sql = "select pw from member where id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				String dbpw = rs.getString("pw");
				if(dbpw.equals(pw)) {
					sql = "delete from member where id=?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, id);
					pstmt.executeUpdate();
					
					a = 1;
				}else {
					a = 0;
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs != null) { try{ rs.close(); }catch(SQLException e) { e.printStackTrace(); } }
			if(pstmt != null) { try{ pstmt.close(); }catch(SQLException e) { e.printStackTrace(); } }
			if(conn != null) { try{ conn.close(); }catch(SQLException e) { e.printStackTrace(); } }
		}	
		
		
		return a;
	}
	
	//아이디 중복검사
	public boolean confirmId(String id) {
		boolean b = false;
		try {
			conn = getConnection();
			
			String sql = "select id from member where id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				//이미 아이디가 있다면
				b = true;
			}		
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs != null) { try{ rs.close(); }catch(SQLException e) { e.printStackTrace(); } }
			if(pstmt != null) { try{ pstmt.close(); }catch(SQLException e) { e.printStackTrace(); } }
			if(conn != null) { try{ conn.close(); }catch(SQLException e) { e.printStackTrace(); } }
		}	
		return b;
	}
	
	
}
