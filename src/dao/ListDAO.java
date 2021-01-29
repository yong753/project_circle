package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import basic.DBConnectionMgr;
import bean.ChartListbean;
import bean.FavoriteListbean;
import bean.Listbean;
import bean.MostRecommendedbean;
import bean.RecentAddedListbean;
import bean.RecentListbean;
import bean.TagListbean;
import bean.WeatherListbean;

public class ListDAO {
	
	private DBConnectionMgr pool;

	public ListDAO() {
		try {
			pool = DBConnectionMgr.getInstance();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public List<Listbean> getweatherList(String weather) {

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		List<Listbean> list = null;

		try {
			con = pool.getConnection();
			sql = "select * from (SELECT title,url FROM playlist_total WHERE weather LIKE ? order by dbms_random.value) where rownum <=4";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, "%"+weather+"%");
			rs = pstmt.executeQuery();

			if (rs.next()) {
				list = new ArrayList<Listbean>();
				do {
					Listbean data = new Listbean();
					data.setTitle(rs.getString("title"));
					data.setUrl(rs.getString("url"));
					list.add(data);
				} while (rs.next());
			}
		} catch (Exception e) {
			System.out.println(e.getMessage());
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return list;
	}
	
	public List<Listbean> getmostrecommended(String weather){
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		List<Listbean> list = null;
		System.out.println(weather);
		
	try {
		con = pool.getConnection();
		sql = "select url,title from (select url,title,rownum from (select url,title,count(*) from (select a.url,a.title,a.weather,b.count from playlist_total a, playlist_member b where a.url = b.url and a.weather like ? and to_char(b.adddate,'YYYYMMDD') >= to_char(sysdate,'YYYYMMDD')-7) group by url,title order by count(*) desc) where rownum<=4) order by dbms_random.random";
		pstmt = con.prepareStatement(sql);
		pstmt.setString(1,"'%"+weather+"%'");
		rs = pstmt.executeQuery();

		if (rs.next()) {
			list = new ArrayList<Listbean>();
			do {
				Listbean data = new Listbean();
				data.setTitle(rs.getString("title"));
				data.setUrl(rs.getString("url"));
				
				list.add(data);
			}while (rs.next());
		}else{
			sql = "select url,title from (select url,title,sum(count) from playlist_member group by url,title order by sum(count) desc) order by dbms_random.random";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				list = new ArrayList<Listbean>();
				do {
					Listbean data = new Listbean();
					data.setTitle(rs.getString("title"));
					data.setUrl(rs.getString("url"));
					list.add(data);
			}while (rs.next());
			}
		}
		}catch (Exception e) {
			System.out.println(e.getMessage());
		}finally {
			pool.freeConnection(con, pstmt, rs);
		}return list;
	}
	
	public List<Listbean> getTagList(String keyword) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		List<Listbean> list = null;

		try {
			con = pool.getConnection();
			sql = "select * from (SELECT title,url,rownum FROM playlist_total WHERE tag LIKE ? order by dbms_random.value) where rownum>=1 and rownum<=8";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, "%"+keyword+"%");
			rs = pstmt.executeQuery();

			if (rs.next()) {
				list = new ArrayList<Listbean>();
				do {
					Listbean data = new Listbean();
					data.setTitle(rs.getString("title"));
					data.setUrl(rs.getString("url"));
					list.add(data);
				} while (rs.next());
			}
		} catch (Exception e) {
			System.out.println(e.getMessage());
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return list;
	}
	
	public List<Listbean> getrecentList(int startnum, int endnum) {

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		List<Listbean> list = null;

		try {
			con = pool.getConnection();
			sql = "select title,url from (select title,url,rownum from playlist_total order by adddate desc) where rownum>=? and rownum<=? order by dbms_random.value";

			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, startnum);
			pstmt.setInt(2, endnum);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				list = new ArrayList<Listbean>();
				do {
					Listbean data = new Listbean();
					data.setTitle(rs.getString("title"));
					data.setUrl(rs.getString("url"));
					list.add(data);
				} while (rs.next());
			}
		} catch (Exception e) {
			e.getMessage();
			System.out.println("오류");
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return list;
	}

	public List<Listbean> getrecentaddedList(int startnum, int endnum) {

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		List<Listbean> list = null;

		try {
			con = pool.getConnection();
			sql = "select title,url from (select title,url,rownum from playlist_total order by adddate desc) where rownum>=? and rownum<=?";

			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, startnum);
			pstmt.setInt(2, endnum);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				list = new ArrayList<Listbean>();
				do {
					Listbean data = new Listbean();
					data.setTitle(rs.getString("title"));
					data.setUrl(rs.getString("url"));
					list.add(data);
				} while (rs.next());
			}
		} catch (Exception e) {
			e.getMessage();
			System.out.println("오류");
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return list;

	}

	public List<Listbean> getdailychartList(int startnum, int endnum) {

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		List<Listbean> list = null;
		System.out.println("데일리차트 진입");

		try {
			con = pool.getConnection();
			sql = "select url,title from (select url,title,sum(count) from playlist_member where adddate>=sysdate-1 group by url,title order by sum(count) desc,title asc) where rownum >=1 and rownum<=20";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			System.out.println("데일리차트 진입2");
			
			if (rs.next()) {
				list = new ArrayList<Listbean>();
				do {
					Listbean data = new Listbean();
					data.setUrl(rs.getString("url"));
					data.setTitle(rs.getString("title"));
					list.add(data);
				} while (rs.next());
			}
		} catch (Exception e) {
			e.getMessage();
			System.out.println(e);
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return list;
	}
	
	public List<Listbean> getweeklychartList(int startnum, int endnum) {

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		List<Listbean> list = null;
		System.out.println("위클리차트 진입");

		try {
			con = pool.getConnection();
			sql = "select url,title from (select url,title,sum(count) from playlist_member where adddate>=sysdate-7 group by url,title order by sum(count) desc) where rownum>=1 and rownum<=20";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			System.out.println("위클리차트 진입2");
			
			if (rs.next()) {
				list = new ArrayList<Listbean>();
				do {
					Listbean data = new Listbean();
					data.setUrl(rs.getString("url"));
					data.setTitle(rs.getString("title"));
					list.add(data);
				} while (rs.next());
			}
		} catch (Exception e) {
			e.getMessage();
			System.out.println(e);
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return list;
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
	}
	
	public List<Listbean> getrecentList(String id, int startnum, int endnum) {

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		List<Listbean> list = null;
		System.out.println("recentlist 진입1");

		try {
			con = pool.getConnection();
			sql = "select title,url,adddate,rownum from (select title,url,adddate from playlist_member where userid=? and rowid in (select max(rowid) from playlist_member where userid=? group by url) order by adddate desc) where rownum>=? and rownum<=?";

			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, id);
			pstmt.setInt(3, startnum);
			pstmt.setInt(4, endnum);
			rs = pstmt.executeQuery();
			System.out.println("recentlist 진입2");

			if (rs.next()) {
				list = new ArrayList<Listbean>();
				do {
					Listbean data = new Listbean();
					data.setTitle(rs.getString("title"));
					data.setUrl(rs.getString("url"));
					list.add(data);
				} while (rs.next());
			}
		} catch (Exception e) {
			System.out.println(e.getMessage());
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return list;

	}
	
	public List<Listbean> getfavoriteList(String id, int startnum, int endnum) {

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		List<Listbean> list = null;
		System.out.println("listmgr진입");
		
		try {
			System.out.println("listmgr시작1");
			con = pool.getConnection();
			sql = "select listtitle,url from (select listtitle,url,adddate from favorite where userid=? and likes=1 order by adddate desc) where rownum>=? and rownum<=? order by rownum asc";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1,id);
			pstmt.setInt(2, startnum);
			pstmt.setInt(3, endnum);
			rs = pstmt.executeQuery();
			System.out.println("listmgr시작2");

			if (rs.next()) {
				list = new ArrayList<Listbean>();
				System.out.println("listmgr성공");
				do {
					Listbean data = new Listbean();
					data.setTitle(rs.getString("listtitle"));
					data.setUrl(rs.getString("url"));
					list.add(data);
				} while (rs.next());
			}
		} catch (Exception e) {
			System.out.println(e.getMessage());
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return list;
	}
	
}
