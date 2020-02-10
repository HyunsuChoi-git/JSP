package JSP.jsp0210.mvc;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class M0101DAO {
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	private static M0101DAO instance = new M0101DAO();
	private M0101DAO() {}
	public static M0101DAO getInstance() {
		if(instance == null) {
			instance = new M0101DAO();
		}
		return instance;
	}
	
	private Connection getConnection() throws Exception{
		Context ctx = new InitialContext();
		Context env = (Context)ctx.lookup("java:comp/env");
		DataSource ds = (DataSource)env.lookup("jdbc/orcl");
		
		return ds.getConnection();
	}
	
	//회원가입메소드
	public void insertUser(M0101DTO user) {
		try {
			conn = getConnection();
			String sql = "insert into imageMember values(?,?,?,?,?,?,sysdate)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, user.getId());
			pstmt.setString(2, user.getPw());
			pstmt.setString(3, user.getName());
			pstmt.setString(4, user.getBirth());
			pstmt.setString(5, user.getEmail());
			pstmt.setString(6, user.getImg());
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(pstmt != null) { try{pstmt.close(); }catch(SQLException e) { e.printStackTrace(); }}
			if(conn != null) { try{pstmt.close(); }catch(SQLException e) { e.printStackTrace(); }}
		}
	}
	
	//로그인메소드
	public boolean login(String id, String pw) {
		boolean b = false;
		
		try {
			conn = getConnection();
			String sql = "select * from imageMember where id=? and pw=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, pw);
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				b = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs != null) { try{ rs.close(); }catch(SQLException e) { e.printStackTrace(); }}
			if(pstmt != null) { try{ pstmt.close(); }catch(SQLException e) { e.printStackTrace(); }}
			if(conn != null) { try{ pstmt.close(); }catch(SQLException e) { e.printStackTrace(); }}
		}
		return b;
	}
	
	//회원정보리턴메소드
	public M0101DTO getUser(String id) {
		M0101DTO user = null;
		try {
			conn = getConnection();
			
			String sql = "select * from imageMember where id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				user = new M0101DTO();
				
				user.setId(rs.getString("id"));
				user.setPw(rs.getString("pw"));
				user.setName(rs.getString("name"));
				user.setBirth(rs.getString("birth"));
				user.setEmail(rs.getString("email"));
				user.setImg(rs.getString("img"));
				user.setReg(rs.getTimestamp("reg"));
				
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs != null) { try{ rs.close(); }catch(SQLException e) { e.printStackTrace(); }}
			if(pstmt != null) { try{ pstmt.close(); }catch(SQLException e) { e.printStackTrace(); }}
			if(conn != null) { try{ pstmt.close(); }catch(SQLException e) { e.printStackTrace(); }}
		}
		return user;
	}
	//사진정보 리턴 메소드
	public String getImage(String id) {
		String img = null;
		try {
			conn = getConnection();
			String sql = "select img from imageMember where id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()) img = rs.getString(1);
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs != null) { try{ rs.close(); }catch(SQLException e) { e.printStackTrace(); }}
			if(pstmt != null) { try{ pstmt.close(); }catch(SQLException e) { e.printStackTrace(); }}
			if(conn != null) { try{ pstmt.close(); }catch(SQLException e) { e.printStackTrace(); }}
		}
		
		return img;
	}
	
	//회원정보 수정메소드
	public void modify(M0101DTO user) {
		try {
			conn = getConnection();
			String sql = "update imageMember set pw=?, birth=?, email=?, img=? where id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, user.getPw());
			pstmt.setString(2, user.getBirth());
			pstmt.setString(3, user.getEmail());
			pstmt.setString(4, user.getImg());
			pstmt.setString(5, user.getId());
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(pstmt != null) { try{ pstmt.close(); }catch(SQLException e) { e.printStackTrace(); }}
			if(conn != null) { try{ pstmt.close(); }catch(SQLException e) { e.printStackTrace(); }}
		}
		
	}
	
	//회원탈퇴 메소드
	public int delete(String id, String pw) {
		int x = -1;
		String dbpw = null;
		try {
			conn = getConnection();
			
			String sql = "select pw from imageMember where id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				dbpw = rs.getString(1);
			}
			
			if(dbpw.equals(pw)) {
				sql = "delete from imageMember where id=? and pw=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, id);
				pstmt.setString(2, pw);
				pstmt.executeUpdate();
				
				x = 1;
			}else {
				x = 0;
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs != null) { try{ rs.close(); }catch(SQLException e) { e.printStackTrace(); }}
			if(pstmt != null) { try{ pstmt.close(); }catch(SQLException e) { e.printStackTrace(); }}
			if(conn != null) { try{ pstmt.close(); }catch(SQLException e) { e.printStackTrace(); }}
		}	
		return x;
	}
	
	//아이디 중복검사 메소드
	public boolean checkId(String id) {
		boolean b = false;
		
		try {
			conn = getConnection();
			
			String sql = "select id from imageMember where id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				b = true;
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs != null) { try{ rs.close(); }catch(SQLException e) { e.printStackTrace(); }}
			if(pstmt != null) { try{ pstmt.close(); }catch(SQLException e) { e.printStackTrace(); }}
			if(conn != null) { try{ pstmt.close(); }catch(SQLException e) { e.printStackTrace(); }}
		}	
		return b;
	}
	
}
