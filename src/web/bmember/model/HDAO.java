package web.bmember.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class HDAO {
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	private Connection getConnection() throws Exception{
		Context ctx = new InitialContext();
		Context env = (Context)ctx.lookup("java:comp/env");
		DataSource ds = (DataSource)env.lookup("jdbc/orcl");
		return ds.getConnection();
	}
	
	//회원가입메소드
	public void insert(HDTO dto) {
		try {
			conn = getConnection();
			
			String sql = "insert into hmember values(?,?,?,?,?,?,?,?,?,?,sysdate)";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, dto.getId());
			pstmt.setString(2, dto.getPw());
			pstmt.setString(3, dto.getName());
			pstmt.setString(4, dto.getGender());
			pstmt.setString(5, dto.getBirth());
			pstmt.setString(6, dto.getAddr());
			pstmt.setString(7, dto.getPhon());
			pstmt.setString(8, dto.getEmail());
			pstmt.setString(9, dto.getSns1());
			pstmt.setString(10, dto.getSns2());
			
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(pstmt != null) { try{ pstmt.close(); }catch(SQLException e) { e.printStackTrace(); } }
			if(conn != null) { try{ conn.close(); }catch(SQLException e) { e.printStackTrace(); } }
		} 
	}
	
	//아이디 중복검사 메소드
	public boolean checkId(String id) {
		boolean b = false;
		
		try {
			conn = getConnection();
			
			String sql = "select id from hmember where id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
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
	
	//로그인 메소드
	public boolean login(String id, String pw) {
		boolean b = false;
		try {
			conn = getConnection();
			
			String sql = "select * from hmember where id=? and pw=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,id);
			pstmt.setString(2,pw);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
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
	
	//회원정보 메소드
	public HDTO getUser(String id) {
		HDTO dto = null;
		try {
			conn = getConnection();
			
			String sql = "select * from hmember where id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				dto = new HDTO();
				dto.setId(rs.getString("id"));
				dto.setPw(rs.getString("pw"));
				dto.setName(rs.getString("name"));
				dto.setGender(rs.getString("gender"));
				dto.setBirth(rs.getString("birth"));
				dto.setAddr(rs.getString("addr"));
				dto.setPhon(rs.getString("phon"));
				dto.setEmail(rs.getString("email"));
				dto.setSns1(rs.getString("sns1"));
				dto.setSns2(rs.getString("sns2"));
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
	
	//정보수정 메소드
	public void modify(HDTO dto) {
		try {
			conn = getConnection();
			String sql = "update hmember set pw=?, birth=?, addr=?, phon=?, email=?, sns1=?, sns2=? where id=?";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, dto.getPw());
			pstmt.setString(2, dto.getBirth());
			pstmt.setString(3, dto.getAddr());
			pstmt.setString(4, dto.getPhon());
			pstmt.setString(5, dto.getEmail());
			pstmt.setString(6, dto.getSns1());
			pstmt.setString(7, dto.getSns2());
			pstmt.setString(8, dto.getId());
					
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(pstmt != null) { try{ pstmt.close(); }catch(SQLException e) { e.printStackTrace(); } }
			if(conn != null) { try{ conn.close(); }catch(SQLException e) { e.printStackTrace(); } }
		}
	}
	
	//회원탈퇴 메소드
	public boolean delete(String id, String pw) {
		boolean b = false;
		try {
			conn = getConnection();
			
			String sql = "select pw from hmember where id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				if(rs.getString("pw").equals(pw)) {
					sql = "delete from hmember where id=?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, id);
					pstmt.executeUpdate();
					
					b = true;
				}
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
