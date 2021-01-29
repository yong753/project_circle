package action;

import java.io.IOException;
import java.lang.Exception;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.MemberDAO;

public class MemberLogoutAction implements Action{
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//세션만료
		HttpSession session = request.getSession();
		session.removeAttribute("idKey");
		
		//MainLoadAction
    	response.sendRedirect("main_load.do");
	}
}
