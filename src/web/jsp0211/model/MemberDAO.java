package web.jsp0211.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class MemberDAO {

	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	// 싱글턴으로 변경
	private static MemberDAO instance = new MemberDAO();
	private MemberDAO() {}
	public static MemberDAO getInstance() {
		return instance;
	}
	
	private Connection getConnection() throws Exception {
		Context ctx = new InitialContext();
		Context env = (Context)ctx.lookup("java:comp/env");
		DataSource ds = (DataSource)env.lookup("jdbc/orcl");
		return ds.getConnection();
	}
	
	// 회원 가입 메서드
	public void insertMember(MemberDTO member) {
		try {
			conn = getConnection();
			String sql = "insert into imagemember values(?,?,?,?,?,?,sysdate)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, member.getId());
			pstmt.setString(2, member.getPw());
			pstmt.setString(3, member.getName());
			pstmt.setString(4, member.getBirth());
			pstmt.setString(5, member.getEmail());
			pstmt.setString(6, member.getPhoto());
			pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(pstmt != null)try {pstmt.close();}catch(SQLException e) {}
			if(conn != null)try {conn.close();}catch(SQLException e) {}
		}
	}
	
	// 로그인 확인 메서드 : id-pw 일치하는지 확인
	public boolean loginCheck(String id, String pw) {
		boolean check = false;
		try {
			conn = getConnection();
			String sql = "select * from imagemember where id=? and pw=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, pw);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				check = true;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) try {rs.close();}catch(SQLException e) {e.printStackTrace();}
			if(pstmt != null) try {pstmt.close();}catch(SQLException e) {e.printStackTrace();}
			if(conn != null) try {conn.close();}catch(SQLException e) {e.printStackTrace();}
		}
		return check;
	}
	
	// 특정 회원 정보 가져오기
	public MemberDTO getMember(String id) {
		MemberDTO member = null;
		try {
			conn = getConnection();
			String sql = "select * from imagemember where id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				member = new MemberDTO();
				member.setId(rs.getString("id"));
				member.setPw(rs.getString("pw"));
				member.setName(rs.getString("name"));
				member.setBirth(rs.getString("birth"));
				member.setEmail(rs.getString("email"));
				member.setPhoto(rs.getString("img"));
				member.setReg(rs.getTimestamp("reg"));
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) try {rs.close();}catch(SQLException e) {e.printStackTrace();}
			if(pstmt != null) try {pstmt.close();}catch(SQLException e) {e.printStackTrace();}
			if(conn != null) try {conn.close();}catch(SQLException e) {e.printStackTrace();}
		}
		return member;
	}
	
	// 회원 정보 수정
	public void updateMember(MemberDTO member) {
		try {
			System.out.println("h2h2");
			System.out.println(member.getId());
			conn = getConnection();
			String sql = "update imagemember set pw=?, birth=?, email=?, img=? where id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, member.getPw());
			pstmt.setString(2, member.getBirth());
			pstmt.setString(3, member.getEmail());
			pstmt.setString(4, member.getPhoto());
			pstmt.setString(5, member.getId());
			pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(pstmt != null) try {pstmt.close();}catch(SQLException e) {e.printStackTrace();}
			if(conn != null) try {conn.close();}catch(SQLException e) {e.printStackTrace();}
		}
	}
	
	// 회원 탈퇴 메서드
	public int deleteMember(String id, String pw) {
		int x = -1;			// id가 일치 하지 않는 경우 
		String dbpw = "";
		try {
			conn = getConnection();
			// DB에서 해당 id의 비번 가져오기
			String sql = "select pw from imagemember where id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
			if(rs.next()) {		// db에서 꺼내온 pw가 있다면, 커서를 가르키고
				dbpw = rs.getString("pw");
				if(dbpw.equals(pw)) { // 비번이 서로 일치하면
					// 회원정보 삭제
					sql = "delete from imagemember where id=?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, id);
					pstmt.executeUpdate();
					x = 1;	// 회원 탈퇴 성공
				}else {  // 비번이 서로 일치하지 않을 경우
					System.out.println("비번 오류");
					x = 0;	// 비밀번호 오류
				}
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) try {rs.close();}catch(SQLException e) {e.printStackTrace();}
			if(pstmt != null) try {pstmt.close();}catch(SQLException e) {e.printStackTrace();}
			if(conn != null) try {conn.close();}catch(SQLException e) {e.printStackTrace();}
		}
		return x;
	}
	// 관리자용 회원 삭제 메소드
	public int deleteMember(String id) {
		int x = -1;			// id가 일치 하지 않는 경우 
		String dbpw = "";
		try {
			conn = getConnection();

			String sql = "delete from imagemember where id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			x = pstmt.executeUpdate();
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) try {rs.close();}catch(SQLException e) {e.printStackTrace();}
			if(pstmt != null) try {pstmt.close();}catch(SQLException e) {e.printStackTrace();}
			if(conn != null) try {conn.close();}catch(SQLException e) {e.printStackTrace();}
		}
		return x;
	}
	
	// id 존재여부 확인 메서드 (confirmId)
	public boolean confirmId(String id) {
		boolean check = false;
		try {
			conn = getConnection();
			String sql = "select id from imagemember where id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()) {	// 결과가 있으면, 
				// 이미 db에 동일한 id가 있다.
				check = true;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) try {rs.close();}catch(SQLException e) {e.printStackTrace();}
			if(pstmt != null) try {pstmt.close();}catch(SQLException e) {e.printStackTrace();}
			if(conn != null) try {conn.close();}catch(SQLException e) {e.printStackTrace();}
		}
		return check;
	}
	
	// 회원의 사진 이름 가져오는 메서드
	public String getPhotoName(String id) {
		String name = null;
		try {
			conn = getConnection();
			String sql = "select img from imagemember where id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				name = rs.getString("img");
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) try {rs.close();}catch(SQLException e) {e.printStackTrace();}
			if(pstmt != null) try {pstmt.close();}catch(SQLException e) {e.printStackTrace();}
			if(conn != null) try {conn.close();}catch(SQLException e) {e.printStackTrace();}
		}
		return name;
	}
	
	//모든 회원정보 수 리턴
	public int getAllMemberCount() {
		int count = 0;
		
		try {
			conn = getConnection();
			
			String sql = "select count(*) from imagemember";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) count = rs.getInt(1);
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs != null) try {rs.close();}catch(SQLException e) {e.printStackTrace();}
			if(pstmt != null) try {pstmt.close();}catch(SQLException e) {e.printStackTrace();}
			if(conn != null) try {conn.close();}catch(SQLException e) {e.printStackTrace();}
		}
		
		return count;
	}
	//검색 회원정보 수 리턴
	public int getAllMemberCount(String sel, String select) {
		int count = 0;
		
		try {
			conn = getConnection();
			
			String sql = "select count(*) from imagemember where "+sel+" like '%"+select+"%'";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) count = rs.getInt(1);
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs != null) try {rs.close();}catch(SQLException e) {e.printStackTrace();}
			if(pstmt != null) try {pstmt.close();}catch(SQLException e) {e.printStackTrace();}
			if(conn != null) try {conn.close();}catch(SQLException e) {e.printStackTrace();}
		}
		
		return count;
	}
	//모든 회원정보 리턴
	public List getAllMember(int startRow, int endRow) {
		List allMemberList = null;
		MemberDTO member = null;
		
		try {
			conn = getConnection();
			String sql = "select id, pw, name, birth, email, img, reg, r "
					+ "from (select id, pw, name, birth, email, img, reg, rownum r "
					+ "from (select id, pw, name, birth, email, img, reg "
					+ "from imagemember order by reg desc) order by reg desc) "
					+ "where r >= ? and r <= ?";
			pstmt= conn.prepareStatement(sql);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, endRow);
			rs = pstmt.executeQuery();
			
			allMemberList = new ArrayList();
			while(rs.next()) {
				member = new MemberDTO();
				
				member.setId(rs.getString("id"));
				member.setPw(rs.getString("pw"));
				member.setName(rs.getString("name"));
				member.setBirth(rs.getString("birth"));
				member.setEmail(rs.getString("email"));
				member.setPhoto(rs.getString("img"));
				member.setReg(rs.getTimestamp("reg"));
				
				allMemberList.add(member);
				
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs != null) try {rs.close();}catch(SQLException e) {e.printStackTrace();}
			if(pstmt != null) try {pstmt.close();}catch(SQLException e) {e.printStackTrace();}
			if(conn != null) try {conn.close();}catch(SQLException e) {e.printStackTrace();}
		}
		return allMemberList;
	}	
		//검색 회원정보 리턴
		public List getAllMember(String sel, String select, int startRow, int endRow) {
			List allMemberList = null;
			MemberDTO member = null;
			
			try {
				conn = getConnection();
				String sql = "select id, pw, name, birth, email, img, reg, r "
						+ "from (select id, pw, name, birth, email, img, reg, rownum r "
						+ "from (select id, pw, name, birth, email, img, reg "
						+ "from imagemember where "+sel+" like '%"+select+"%' order by reg desc) order by reg desc) "
						+ "where r >= ? and r <= ?";
				pstmt= conn.prepareStatement(sql);
				pstmt.setInt(1, startRow);
				pstmt.setInt(2, endRow);
				rs = pstmt.executeQuery();
				
				allMemberList = new ArrayList();
				while(rs.next()) {
					member = new MemberDTO();
					
					member.setId(rs.getString("id"));
					member.setPw(rs.getString("pw"));
					member.setName(rs.getString("name"));
					member.setBirth(rs.getString("birth"));
					member.setEmail(rs.getString("email"));
					member.setPhoto(rs.getString("img"));
					member.setReg(rs.getTimestamp("reg"));
					
					allMemberList.add(member);
					
				}
				
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				if(rs != null) try {rs.close();}catch(SQLException e) {e.printStackTrace();}
				if(pstmt != null) try {pstmt.close();}catch(SQLException e) {e.printStackTrace();}
				if(conn != null) try {conn.close();}catch(SQLException e) {e.printStackTrace();}
			}
		
		return allMemberList;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
}
