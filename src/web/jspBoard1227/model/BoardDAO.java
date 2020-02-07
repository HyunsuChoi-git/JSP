package web.jspBoard1227.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class BoardDAO {
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	//DB접속 메소드
	private Connection getConnection() throws Exception {
		Context ctx = new InitialContext();
		Context env = (Context)ctx.lookup("java:comp/env");
		DataSource ds = (DataSource)env.lookup("jdbc/orcl");
		
		return ds.getConnection();
	}
	
	//게시판의 총 글의 갯수를 리턴해주는 메소드
	public int articleCount() {
		int n = 0;
		
		try {
			conn = getConnection();
			
			String sql = "select count(*) from board2";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				n = rs.getInt(1);
			}			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs!=null) {try{rs.close();}catch(SQLException e) {e.printStackTrace();}}
			if(pstmt!=null) {try{rs.close();}catch(SQLException e) {e.printStackTrace();}}
			if(conn!=null) {try{rs.close();}catch(SQLException e) {e.printStackTrace();}}
		} 	
		
		return n;
	}
	
	//원하는 범위의 게시판 글 리턴해주는 메소드
	public List articleList(int startRow, int endRow) {
		List articleList = null;

		try {
			conn = getConnection();
			
			String sql = "select num,writer,subject,email,content,pw,reg,readcount,ip,ref,re_step,re_level,r "
					+ "from (select num,writer,subject,email,content,pw,reg,readcount,ip,ref,re_step,re_level,rownum r "
					+ "from (select num,writer,subject,email,content,pw,reg,readcount,ip,ref,re_step,re_level "
					+ "from board2 order by ref desc, re_step asc) order by ref desc, re_step asc) "
					+ "where r >= ? and r <= ?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, endRow);			
			rs = pstmt.executeQuery();
			
			//원하는 범위만큼 뽑아온 게시글을 하나하나 dto에 담고 list에 저장하기
			articleList = new ArrayList();
			
			while(rs.next()) {
				BoardDTO article = new BoardDTO();
				
				article.setNum(rs.getInt("num"));
				article.setWriter(rs.getString("writer"));
				article.setSubject(rs.getString("subject"));
				article.setEmail(rs.getString("email"));
				article.setContent(rs.getString("content"));
				article.setPw(rs.getString("pw"));
				article.setReg(rs.getTimestamp("reg"));
				article.setReadcount(rs.getInt("readcount"));
				article.setIp(rs.getString("ip"));
				article.setRef(rs.getInt("ref"));
				article.setRe_step(rs.getInt("re_step"));
				article.setRe_level(rs.getInt("re_level"));
				
				articleList.add(article);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs!=null) {try{rs.close();}catch(SQLException e) {e.printStackTrace();}}
			if(pstmt!=null) {try{rs.close();}catch(SQLException e) {e.printStackTrace();}}
			if(conn!=null) {try{rs.close();}catch(SQLException e) {e.printStackTrace();}}
		} 	
		
		return articleList;
	}
	
	//글 저장하는 메소드
	public void insertArticle(BoardDTO article) {
		int num = article.getNum();
		int ref = article.getRef();
		int re_step = article.getRe_step();
		int re_level = article.getRe_level();
		int number = 0;
		String sql = null;
		
		try {
			conn = getConnection();
			
			//0. 가장 최근 글의 고유번호를 꺼내 +1 하여 number에 넣어주기
			sql = "select max(num) from board2";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) number = rs.getInt(1)+1;
			else number = 1;
			
			//1. 댓글일 때
			// num > 0, ref > 1, re_step > 0, re_level > 0
			// 댓글인 것들 (re_step > 0 , re_level > 0) 꺼내서 re_step +1 해주기 
			if(num > 0) {				
				sql = "update board2 set re_step=re_step+1 where ref=? and re_step>0";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, ref);
				pstmt.executeUpdate();
				
				re_step += 1;
				re_level += 1;
			}
			//2. 새 글일 때
			// num = 0, ref > 1, re_step = 0, re_level = 0
			else {
				ref = number;
				re_step = 0;
				re_level = 0;
			}
			
			//3. 세팅 끝, DB에 게시글 저장하기.
			sql = "insert into board2(num,writer,subject,email,content,pw,reg,ip,ref,re_step,re_level) values(board2_seq.nextVal,?,?,?,?,?,?,?,?,?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, article.getWriter());
			pstmt.setString(2, article.getSubject());
			pstmt.setString(3, article.getEmail());
			pstmt.setString(4, article.getContent());
			pstmt.setString(5, article.getPw());
			pstmt.setTimestamp(6, article.getReg());
			pstmt.setString(7, article.getIp());
			pstmt.setInt(8, article.getRef());
			pstmt.setInt(9, article.getRe_step());
			pstmt.setInt(10, article.getRe_level());
		
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs!=null) {try{rs.close();}catch(SQLException e) {e.printStackTrace();}}
			if(pstmt!=null) {try{rs.close();}catch(SQLException e) {e.printStackTrace();}}
			if(conn!=null) {try{rs.close();}catch(SQLException e) {e.printStackTrace();}}
		} 
		
	}
	
	//글넘버가져오는메소드
	public int articleNum(BoardDTO article) {
		int num= -1;
		try {
			conn = getConnection();
			
			String sql = "select num from board2 where writer=? and subject=? and pw=? and ip=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, article.getWriter());
			pstmt.setString(2, article.getSubject());
			pstmt.setString(3, article.getPw());
			pstmt.setString(4, article.getIp());
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				num = rs.getInt(1);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs!=null) {try{rs.close();}catch(SQLException e) {e.printStackTrace();}}
			if(pstmt!=null) {try{rs.close();}catch(SQLException e) {e.printStackTrace();}}
			if(conn!=null) {try{rs.close();}catch(SQLException e) {e.printStackTrace();}}
		} 
		
		return num;
	}
	
	//content글 꺼내오는 메소드
	public BoardDTO getArticle(int num) {
		BoardDTO article = null;
		try {
			conn = getConnection();
			//1. 글 꺼내서 조회수 올려주기
			String sql = "update board2 set readcount=readcount+1 where num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
			
			//2. 글 꺼내서 리턴하기
			sql = "select * from board2 where num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				article = new BoardDTO();
				
				article.setNum(rs.getInt("num"));
				article.setWriter(rs.getString("writer"));
				article.setSubject(rs.getString("subject"));
				article.setEmail(rs.getString("email"));
				article.setContent(rs.getString("content"));
				article.setPw(rs.getString("pw"));
				article.setReg(rs.getTimestamp("reg"));
				article.setReadcount(rs.getInt("readcount"));
				article.setIp(rs.getString("ip"));
				article.setRef(rs.getInt("ref"));
				article.setRe_step(rs.getInt("re_step"));
				article.setRe_level(rs.getInt("re_level"));
				
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs!=null) {try{rs.close();}catch(SQLException e) {e.printStackTrace();}}
			if(pstmt!=null) {try{rs.close();}catch(SQLException e) {e.printStackTrace();}}
			if(conn!=null) {try{rs.close();}catch(SQLException e) {e.printStackTrace();}}
		} 
		return article;
	}
	
	public int modify(BoardDTO article) {
		int x = 0;
		String dbpw = null;
		try {
			conn = getConnection();
			//디비의 비번과, dto비번과 확인 후 일치하면 글 수정,
			String sql = "select pw from board2 where num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, article.getNum());
			rs = pstmt.executeQuery();
			if(rs.next()) {
				dbpw = rs.getString("pw");
				if(dbpw.equals(article.getPw())) {
					
					sql = "update board2 set subject=?, email=?, content=? where num=?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, article.getSubject());
					pstmt.setString(2, article.getEmail());
					pstmt.setString(3, article.getContent());
					pstmt.setInt(4, article.getNum());
					
					pstmt.executeUpdate();
					
					x = 1;
				}else {
					x = -1;
				}
				
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs!=null) {try{rs.close();}catch(SQLException e) {e.printStackTrace();}}
			if(pstmt!=null) {try{rs.close();}catch(SQLException e) {e.printStackTrace();}}
			if(conn!=null) {try{rs.close();}catch(SQLException e) {e.printStackTrace();}}
		} 
		return x;
	}
	
	public int delete(int num, String pw) {
		int x = 0;
		String dbpw = null;
		try {
			conn = getConnection();
			
			String sql = "select pw from board2 where num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				dbpw = rs.getString(1);
				
				if(dbpw.equals(pw)) {
					sql = "delete from board2 where num=? and pw=?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setInt(1, num);
					pstmt.setString(2, pw);
					pstmt.executeUpdate();
					
					x = 1;
				}else {
				x = -1;
				}
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs!=null) {try{rs.close();}catch(SQLException e) {e.printStackTrace();}}
			if(pstmt!=null) {try{rs.close();}catch(SQLException e) {e.printStackTrace();}}
			if(conn!=null) {try{rs.close();}catch(SQLException e) {e.printStackTrace();}}
		} 
		return x;
	}
	
}
