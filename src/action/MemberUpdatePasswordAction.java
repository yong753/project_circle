package action;

import java.io.IOException;
import java.io.PrintWriter;
import java.lang.Exception;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.MemberDAO;

public class MemberUpdatePasswordAction implements Action{
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("UTF-8");
		String id = request.getParameter("id");
		String pw = request.getParameter("pw");
		String pw_re = request.getParameter("pw_re");
		MemberDAO mem = new MemberDAO();
		
		System.out.print(pw);
		System.out.print(pw_re);
		System.out.print(id);
		
		if(pw.equals(pw_re)){
			mem.updatePw(pw,id);
			response.sendRedirect("portfolio_update_pw_result.jsp");
			System.out.print("성공");
		}else {
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>alert('비밀번호가 다릅니다.'); location.href='portfolio_update_pw.jsp';</script>");
			out.flush();
		}
	}
}
