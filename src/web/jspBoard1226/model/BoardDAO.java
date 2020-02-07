package web.jspBoard1226.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import oracle.net.ns.DataDescriptorPacket;

public class BoardDAO {
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	private Connection getConncetion() throws Exception{
		Context ctx = new InitialContext();
		Context env = (Context)ctx.lookup("java:comp/env");
		DataSource ds = (DataSource)env.lookup("jdbc/orcl");
		
		return ds.getConnection();
	}
	
	// 새글 저장 메소드
	public int insertArticle(BoardDTO article) {
		//조정, 확인이 필요한 값 꺼내보기
		int num = article.getNum();			//글 번호(새글일 땐0, 댓글이면 1 이상)
		int ref = article.getRef();			//글 그룹1
		int re_step = article.getRe_step();	//정렬 순서 0
		int re_level = article.getRe_level(); //답글 레벨 0 
		int number = 0;						//DB에 저장할 글 고유 번호
		
		int n = 0;
		String sql = null;
		
		try {
			conn = getConncetion();
			
			//db에 접근하여 가장 큰 글의 고유번호 가져오기(num컬럼->저장된 글들의 고유번호)
			pstmt = conn.prepareStatement("select max(num) from board");			
			rs = pstmt.executeQuery();
			
			//게시글이 존재하면, 가져온 컬럼의 수에 1을 더해 number에 저장. (즉, 가장최근 글 다음번호)
			if(rs.next()) number = rs.getInt(1)+1;
			else number = 1; 		//글이 없는 경우. 첫번째 게시글 번호 1로 지정
			
			//새글이 아닌 답글 작성인 경우
			if(num != 0) {
				//DB에 기존에 달린 답글(re_step 0보다 큰)이 있다면, 새 답글이 1이 되기 위해
				//해달 글의 ref(글그룹)의 모든 답글의 step을 +1 할 것.
				sql = "update board set re_step = re_step + 1 where ref=? and re_step > ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, ref);
				pstmt.setInt(2, re_step);
				
				pstmt.executeUpdate();
				//댓글은 DB에 저장하기 전에, 받아온 초기값 에서 1이 되게 더해줌.
				re_step += 1;
				re_level += 1;
				
			}else {		
				
				ref = number; 	// 글 그룹번호와 글 고유번호를 일치시켜주기
				re_step = 0;	
				re_level = 0;
			}
			
				sql = "insert into board(num, writer, subject, email, content, pw, reg,";
				sql += "ip, ref, re_step, re_level) values(board_seq.nextVal,?,?,?,?,?,?,?,?,?,?)";
				
				pstmt = conn.prepareStatement(sql);
				
				pstmt.setString(1, article.getWriter());
				pstmt.setString(2, article.getSubject());
				pstmt.setString(3, article.getEmail());
				pstmt.setString(4, article.getContent());
				pstmt.setString(5, article.getPw());
				pstmt.setTimestamp(6, article.getReg());
				pstmt.setString(7, article.getIp());
				pstmt.setInt(8, ref);
				pstmt.setInt(9, re_step);
				pstmt.setInt(10,re_level);
				
				pstmt.executeUpdate();
				
				//num 꺼내서 저장하기
				sql = "select num from board where ref=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, number);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					n = rs.getInt("num");
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
	
	//전체 글 갯수 가져오기
	public int getArticleCount() {
		int count = 0;
		try {
			conn = getConncetion();
			
			String sql = "select count(*) from board";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				count = rs.getInt(1);
			}			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs!=null) {try{rs.close();}catch(SQLException e) {e.printStackTrace();}}
			if(pstmt!=null) {try{rs.close();}catch(SQLException e) {e.printStackTrace();}}
			if(conn!=null) {try{rs.close();}catch(SQLException e) {e.printStackTrace();}}
		}
		
		return count;
	}
	
	//게시글들 리턴해주는 메소드
	public List getArticlesList(int startRow, int endRow) {
		List articleList = null;
		try {
			conn = getConncetion();
			
			
			String sql = "select num,writer,subject,email,content,pw,reg,readcount,ip,ref,re_step,re_level,r "
		               + "from (select num,writer,subject,email,content,pw,reg,readcount,ip,ref,re_step,re_level,rownum r "
		               + "from (select num,writer,subject,email,content,pw,reg,readcount,ip,ref,re_step,re_level "
		               + "from board order by ref desc, re_step asc) order by ref desc, re_step asc) "
		               + "where r >= ? and r <= ?";
		
			// 전체를 ref 내림차순, re_step 오름차순으로 출력
			// 위에 것을 rownum r 로 (가상의번호를 부여하여) 출력
			// 위에 것에 r의 범위를 지정하여 출력
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, endRow);			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				//글 목록
				articleList = new ArrayList();
				do {
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
					
					articleList.add(article);  //한개의 글 정보를 articleList에 넣어준 것.
				}while(rs.next());
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
	
	// 작성글 하나 리턴하는 메소드
	public BoardDTO getArticle(int num) {
		BoardDTO article = null;
		try {
			conn = getConncetion();
			
			//1. 조회수를 올려서 저장해주기!!
			String sql = "update board set readcount = readcount + 1 where num = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			
			pstmt.executeUpdate();
			
			//2. 글꺼내기
			sql = "select * from board where num=?";
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
	
	//글 수정 메소드
	public int updateArticle(BoardDTO article) {
		int x = -1;
		String dbpw = "";
		
		try {
			conn = getConncetion();
			String sql = "select pw from board where num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, article.getNum());
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				dbpw = rs.getString("pw");
				
				if(dbpw.equals(article.getPw())) {
					sql = "update board set writer=?, subject=?, email=?, content=? where num=?" ;
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, article.getWriter());
					pstmt.setString(2, article.getSubject());
					pstmt.setString(3, article.getEmail());
					pstmt.setString(4, article.getContent());
					pstmt.setInt(5, article.getNum());
					
					pstmt.executeUpdate();
					
					x = 1;  //수정완료
				}else {
					x = 0;  //비번불일치
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
	
	//글 삭제 메소드
	public int deleteArticle(int num, String pw) {
		int x = -1;
		String dbpw = "";
		
		try {
			conn = getConncetion();
			
			String sql = "select pw from board where num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				dbpw = rs.getString("pw");
				
				if(dbpw.equals(pw)) {
					
					sql = "delete from board where num=?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setInt(1, num);
					pstmt.executeUpdate();
					
					x = 1;
				}else {
					x = 0;
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
	
	
	//검색어 관련 글의 갯수 리턴 메소드
	public int getSearchArtucleCount(String sel, String search) {
		int x = 0;
		try {
			conn=getConncetion();
			
			String sql = "select count(*) from board where "+sel+" like '%"+search+"%'";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, sel);
			pstmt.setString(2, search);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				x = rs.getInt(1);
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
	
	
	//검색어 관련 글 전체 리턴
	public List getSearchArticlesList(int start, int end, String sel, String search) {
		List articleList = null;
		try {
			conn = getConncetion();
			String sql = "select num,writer,subject,email,content,pw,reg,readcount,ip,ref,re_step,re_level,r "
		               + "from (select num,writer,subject,email,content,pw,reg,readcount,ip,ref,re_step,re_level,rownum r "
		               + "from (select num,writer,subject,email,content,pw,reg,readcount,ip,ref,re_step,re_level "
		               + "from board where "+sel+" like '%"+search+"%' order by ref desc, re_step asc) order by ref desc, re_step asc) "
		               + "where r >= ? and r <= ?";	// " where ? like '%?%' " 추가		 
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, start);			
			pstmt.setInt(2, end);			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				//글 목록
				articleList = new ArrayList();
				do {
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
					
				}while(rs.next());
			}			
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return articleList;
	}
	
}
