package web.upload1230.model;

import java.io.File;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class ImageDAO {
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	private static ImageDAO instance = new ImageDAO();
	private ImageDAO() {}
	public static ImageDAO getImageDAO() {
		return instance;
	}
	
	private Connection getConnection() throws Exception{
		Context ctx = new InitialContext();
		Context env = (Context)ctx.lookup("java:comp/env");
		DataSource ds = (DataSource)env.lookup("jdbc/orcl");

		return ds.getConnection();
	}
	
	//회원가입메소드
	public void insertMember(ImageDTO dto) {
		try {
			conn = getConnection();
			
			String sql = "insert into imageMember values(?,?,?,?,?,?,sysdate)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getId());
			pstmt.setString(2, dto.getPw());
			pstmt.setString(3, dto.getName());
			pstmt.setString(4, dto.getBirth());
			pstmt.setString(5, dto.getEmail());
			pstmt.setString(6, dto.getImg());
			
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
			if(rs != null) { try{ rs.close(); }catch(SQLException e) { e.printStackTrace(); } }
			if(pstmt != null) { try{ pstmt.close(); }catch(SQLException e) { e.printStackTrace(); } }
			if(conn != null) { try{ conn.close(); }catch(SQLException e) { e.printStackTrace(); } }
		}	
		
		return b;
	}
	
	//회원정보 리턴메소드
	public ImageDTO getUser(String sId) {
		ImageDTO user = null;
		try {
			conn = getConnection();
			String sql = "select * from imageMember where id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, sId);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				
				user = new ImageDTO();
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
			if(rs != null) { try{ rs.close(); }catch(SQLException e) { e.printStackTrace(); } }
			if(pstmt != null) { try{ pstmt.close(); }catch(SQLException e) { e.printStackTrace(); } }
			if(conn != null) { try{ conn.close(); }catch(SQLException e) { e.printStackTrace(); } }
		}	
		return user;
	}
	
	//회원정보 수정 메소드
	public void modify(ImageDTO user) {		
		String dbImg = null;
		try {
			conn = getConnection();
			
			//DTO에 img가 null이 아니면 db에 있는 img 이름 폴더에서 삭제.
			String sql = "select img from imageMember where id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, user.getId());
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				dbImg = rs.getString("img");
				if(user.getImg() != null) {
					File f = new File("D:\\hyunsu\\classclass\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp1\\wtpwebapps\\web\\save\\"+dbImg);
					f.delete();
				}
			}
				
			//정보 수정
			sql = "update imageMember set pw=?, birth=?, email=?, img=? where id=?";
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
			if(pstmt != null) { try{ pstmt.close(); }catch(SQLException e) { e.printStackTrace(); } }
			if(conn != null) { try{ conn.close(); }catch(SQLException e) { e.printStackTrace(); } }
		}	
	}
	
	//회원탈퇴 메소드 (이미지이름 리턴)
	public String deleteUser(String id, String pw) {
		String img = null;
		String dbpw = null;
		try {
			conn = getConnection();
			//비번꺼내서 맞추기
			String sql = "select pw from imageMember where id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				dbpw = rs.getString("pw");
					
				if(dbpw.equals(pw)) {
					
					sql = "select img from imageMember where id=?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, id);		
					rs = pstmt.executeQuery();
					
					if(rs.next()) {
						if(!(rs.getString(1).equals("defaultimg.jpg"))){
							img = rs.getString(1);
						}
					}
					
					sql = "delete from imageMember where id=? and pw=?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, id);
					pstmt.setString(2, pw);
					
					pstmt.executeUpdate();
					
					
				}else {
					img = "pw";
				}
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs != null) { try{ rs.close(); }catch(SQLException e) { e.printStackTrace(); } }
			if(pstmt != null) { try{ pstmt.close(); }catch(SQLException e) { e.printStackTrace(); } }
			if(conn != null) { try{ conn.close(); }catch(SQLException e) { e.printStackTrace(); } }
		}	
		
		return img;
	}

}
