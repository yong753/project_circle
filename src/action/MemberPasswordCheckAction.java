package action;

import java.io.IOException;
import java.io.PrintWriter;
import java.lang.Exception;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.MemberDAO;

public class MemberPasswordCheckAction implements Action{
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String id = request.getParameter("id");
		String pw = request.getParameter("pw");
		MemberDAO mDAO = new MemberDAO();
		
		System.out.print(id);
		System.out.print(pw);
		
		if(id!=null&&pw!=null) {
			if(mDAO.loginCheck(id,pw)) {
				response.sendRedirect("portfolio_update_pw.jsp");
			}else {
				response.setContentType("text/html; charset=UTF-8");
				PrintWriter out = response.getWriter();
				out.println("<script>alert('비밀번호가 틀립니다.'); location.href='portfolio_update_pw_prev.jsp';</script>");
				out.flush();
			}
		}
	}
}
