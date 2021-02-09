package action;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.lang.Exception;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.MemberDAO;

public class MemberLoginAction implements Action{
	
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{

		request.setCharacterEncoding("UTF-8");
		HttpSession session = request.getSession();
		String url = "login_success_load.do";
		String failurl = "circle_login.jsp";
		
		//id,pw 수신
		String id = request.getParameter("id");
		String pw = request.getParameter("pw");
		
		//DAO객체 생성
		MemberDAO mem = new MemberDAO();
		
		//아이디 비밀번호 체크
		if(id!=null&&pw!=null) {
			if(mem.loginCheck(id,pw)) {
				session.setAttribute("idKey", id);
				
				response.sendRedirect(url);
			}else {
				PrintWriter out = response.getWriter();
				out.println("<script>alert('아이디와 비밀번호를 확인하세요.');</script>");
				
				response.sendRedirect(failurl);
			};
		}
	}
}
