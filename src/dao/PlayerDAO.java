package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import basic.DBConnectionMgr;
import bean.ReviewListbean;
	
public class PlayerDAO {

	private DBConnectionMgr pool;

	public PlayerDAO() {
		try {
			pool = DBConnectionMgr.getInstance();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public boolean getLikesInfo(String url, String id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;

		boolean click = false;

		try {

			con = pool.getConnection();
			sql = "select likes from favorite where url =? and userid =?";

			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, url);
			pstmt.setString(2, id);
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				if (rs.getInt(1)==1){
					click = true;
				}else{
				click = false;
			}
		} 
		}catch (Exception e) {
			e.printStackTrace();
			System.out.println("오류");
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return click; //false 이면 '좋아요' 누르지 않은 상태
	};
	
	public void setListenInfo(String url, String id,String title) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		
		try {
			con = pool.getConnection();
			sql = "insert into playlist_member(url,count,userid,adddate,title) values(?,1,?,sysdate,?)";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, url);
			pstmt.setString(2, id);
			pstmt.setString(3, title);
			pstmt.executeUpdate();
			con.commit();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	
	public List<ReviewListbean> getReviewList(String url) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		List<ReviewListbean> list = null;

		try {
			con = pool.getConnection();
			sql = "select rating,id,content from review where url=? order by adddate desc";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, url);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				list = new ArrayList<ReviewListbean>();
				do {
					ReviewListbean data = new ReviewListbean();
					data.setRating(rs.getInt("rating"));
					data.setId(rs.getString("id"));
					data.setContent(rs.getString("content"));
					list.add(data);
				} while (rs.next());
			}
			con.commit();
		} catch (Exception e) {
			System.out.println(e.getMessage());
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return list;
	}
	
	public void setReviewInfo(int rating,String id,String content,String url) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		
		try {
			con = pool.getConnection();
			sql = "insert into review(rating,id,content,url) values (?,?,?,?)";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, rating);
			pstmt.setString(2, id);
			pstmt.setString(3, content);
			pstmt.setString(4, url);
			pstmt.executeUpdate();
			con.commit();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	
	public boolean checkReview(String url,String id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		boolean check = false;
		System.out.println("진입");

		try {
			con = pool.getConnection();
			sql = "select content from review where url=? and id=? order by adddate desc";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, url);
			pstmt.setString(2, id);
			rs = pstmt.executeQuery();
			
				if(rs.next()) {
					check = true;
				}
			con.commit();
		} catch (Exception e) {
			System.out.println(e.getMessage());
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return check;
	}
		
	public int getTotalRating(String url) {
		int totalrating = 0;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		
		try {
			con = pool.getConnection();
			sql = "select avg(nvl(rating,0)) from review where url=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, url);
			rs = pstmt.executeQuery();
			
				if(rs.next()) {
					totalrating = rs.getInt("avg(nvl(rating,0))");
				}
			con.commit();
		} catch (Exception e) {
			System.out.println(e.getMessage());
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		
		return totalrating;
	}
	
	
	public void likeChange(String id, String url, String title) {

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;

		sql = "select likes from favorite where userid = ? and url=?";

		try {
			conn = pool.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, url);
			rs = pstmt.executeQuery();
			System.out.println("변경시작2");
			
			if (rs.next()) {
					if (rs.getInt(1) == 1) {
							sql = "update favorite set likes = 0,adddate = sysdate where userid=? and url=?";

							try {
								pstmt = conn.prepareStatement(sql);
								pstmt.setString(1, id);
								pstmt.setString(2, url);
								pstmt.executeUpdate();

								conn.commit();
								System.out.println("변경완료1");
							} catch (Exception e) {
								System.out.println(e.getMessage());
							}
						} else if(rs.getInt(1) == 0){
							sql = "update favorite set likes = 1,adddate = sysdate where userid=? and url=?";

							try {
								pstmt = conn.prepareStatement(sql);
								pstmt.setString(1, id);
								pstmt.setString(2, url);
								pstmt.executeUpdate();

								conn.commit();
								System.out.println("변경완료2");
							} catch (Exception e) {
								System.out.println(e.getMessage());
							}
						}
			}else{
				sql = "insert into favorite(userid,likes,adddate,url,listtitle) values(?,?,sysdate,?,?)";
				try {
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, id);
					pstmt.setInt(2, 1);
					pstmt.setString(3, url);
					pstmt.setString(4, title);
					pstmt.executeUpdate();

					conn.commit();
					System.out.println("변경완료3");
				} catch (Exception e) {
					System.out.println(e.getMessage());
				}
			}
		} catch (Exception e) {
			System.out.println(e.getMessage());
		} finally {
			pool.freeConnection(conn, pstmt, rs);
		}
	}
	
	
	
	

}
