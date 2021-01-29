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
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		String url = "/circle_frame.jsp";
		String location = "login_success_load.do";
		
		//id,pw 수신
		String id = request.getParameter("id");
		String pw = request.getParameter("pw");
		
		//DAO객체 생성
		MemberDAO mem = new MemberDAO();
		
		//아이디 비밀번호 체크
		if(id!=null&&pw!=null) {
			if(mem.loginCheck(id,pw)) {
				HttpSession session = request.getSession();
				session.setAttribute("idKey", id);
				request.setAttribute("location", location);
				
				RequestDispatcher dispatcher = request.getRequestDispatcher(url);
				dispatcher.forward(request,response);
				 
			}else {
				response.setContentType("text/html; charset=UTF-8");
				PrintWriter out = response.getWriter();
				out.println("<script>alert('아이디와 비밀번호를 확인하세요.'); location.href='portfolio_login.jsp';</script>");
				out.flush();
			};
		}
	}
}
