package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import basic.DBConnectionMgr;
import bean.MemberBean;

public class MemberDAO {
	
	private DBConnectionMgr pool;
	
	//MemberDAO 생성자
	public MemberDAO() {
		try {
			pool = DBConnectionMgr.getInstance();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	//아이디 찾기
	public MemberBean findid(String name, String email) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		MemberBean bean = new MemberBean();
		
		try {
			con = pool.getConnection();
			sql = "select userid from memberinfo where name=? and email=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, name);
			pstmt.setString(2, email);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				bean.setId(rs.getString(1));
				System.out.println(bean.getId());
			};
		} catch (Exception e) {
			e.getMessage();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return bean;
	}
	
	//비밀번호 찾기
	public MemberBean findpw(String name, String email, String id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		MemberBean bean = new MemberBean();
		
		try {
			con = pool.getConnection();
			sql = "select userid,name,email from memberinfo where name=? and email=? and userid=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, name);
			pstmt.setString(2, email);
			pstmt.setString(3, id);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				bean.setId(rs.getString("userid"));
				bean.setName(rs.getString("name"));
				bean.setEmail(rs.getString("email"));
				System.out.println(bean.getPw());
			};
		} catch (Exception e) {
			e.getMessage();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return bean;
	}
	
	//회원가입 아이디 중복체크
	public boolean checkId(String id) {

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		boolean flag = false;

		try {
			con = pool.getConnection();
			sql = "select userid from memberinfo where userid= ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			flag = pstmt.executeQuery().next();
		} catch (Exception e) {
			e.getMessage();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}

		return flag;
	}

	//회원가입 핸드폰번호 중복체크
	public boolean checkNumber(String number) {

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		boolean flag = false;

		try {
			con = pool.getConnection();
			sql = "select phone from memberinfo where phone= ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, number);
			flag = pstmt.executeQuery().next();
		} catch (Exception e) {
			e.getMessage();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}

		return flag;
	}

	//로그인체크
	public boolean loginCheck(String id, String pw) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		boolean flag = false;
		
		try {
			con = pool.getConnection();
			sql = "select userid from memberinfo where userid = ? and pw = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, pw);
			rs = pstmt.executeQuery();
			flag = rs.next();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return flag;
	}
	
	//회원정보 가져오기
	public MemberBean getMemberInfo(String id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		MemberBean bean = new MemberBean();
		
		try {
			con = pool.getConnection();
			sql = "select * from memberinfo where userid = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				bean.setName(rs.getString("name"));
				bean.setId(rs.getString("userid"));
				bean.setEmail(rs.getString("email"));
				bean.setAddress(rs.getString("address"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return bean;
	}

	//비밀번호 변경
	public void updatePw(String pw,String id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "update memberinfo set pw=? where userid=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, pw);
			pstmt.setString(2, id);
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	
	//주소 변경
		public void updateAddress(String address,String id) {
			Connection con = null;
			PreparedStatement pstmt = null;
			String sql = null;
			try {
				con = pool.getConnection();
				sql = "update memberinfo set address=? where userid=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, address);
				pstmt.setString(2, id);
				pstmt.executeUpdate();
				
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt);
			}
		}
}
