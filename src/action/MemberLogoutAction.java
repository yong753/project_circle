package action;

import java.io.IOException;
import java.lang.Exception;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import basic.WeatherJsonParser;
import bean.Listbean;
import dao.ListDAO;
import dao.MemberDAO;

public class MemberLogoutAction implements Action{
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//세션만료
		request.setCharacterEncoding("UTF-8");
		HttpSession session = request.getSession();
		session.removeAttribute("idKey");
		
		//기본객체 생성
		String url = "frame_load.do";
		
		//request 및 response 설정
		response.sendRedirect(url);
	}
}
