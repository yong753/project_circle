package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Vector;
import basic.DBConnectionMgr;
import bean.MostRecommendedbean;
import bean.RecentAddedListbean;
import bean.WeatherListbean;

import java.util.List;

public class TagDAO {

	private DBConnectionMgr pool;

	public TagDAO() {
		try {
			pool = DBConnectionMgr.getInstance();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public String gettag1() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		String tag1 = null;

		try {
			con = pool.getConnection();
			sql = "select tag1 from manage";
			
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				System.out.println(rs.getString("tag1"));
				tag1 = rs.getString("tag1");
			}
		} catch (Exception e) {
			e.getMessage();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return tag1;
	}
	
	public String gettag2() {
			
			String tag2 = null;
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = null;
	
			try {
				con = pool.getConnection();
				sql = "select tag2 from manage";
				pstmt = con.prepareStatement(sql);
				rs = pstmt.executeQuery();
				if (rs.next()) {
					tag2 = rs.getString("tag2");
				}
			} catch (Exception e) {
				e.getMessage();
			} finally {
				pool.freeConnection(con, pstmt, rs);
			}
			return tag2;
		}
	
	public void settag(String tagno,String tag) {
	    Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		
		try {
			System.out.println("¡¯¿‘");
			con = pool.getConnection();
			if(tagno.equals("1")) {
				sql = "update manage set tag1=?";
			}else if(tagno.equals("2")){
				sql = "update manage set tag2=?";
			}
			
			System.out.println(sql);
			
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, tag);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
}
