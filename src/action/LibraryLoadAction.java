package action;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import java.lang.Exception;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.ListDAO;
import dao.TagDAO;
import basic.WeatherJsonParser;
import bean.ChartListbean;
import bean.Listbean;
import bean.MostRecommendedbean;
import bean.RecentAddedListbean;
import bean.TagListbean;
import bean.WeatherListbean;

public class LibraryLoadAction implements Action{
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//기본객체 생성
		HttpSession session = request.getSession();
		request.setCharacterEncoding("UTF-8");
		String id = (String)session.getAttribute("idKey");
		String url = "/circle_library.jsp";
		
		//로그인 여부 체크
		if (id == null) {
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter outs = response.getWriter();
			outs.println("<script>alert('로그인 해주세요.'); location.href='main_load.do';</script>");
			outs.flush();
		}
		
		//List 관련 객체 생성
		Listbean data = new Listbean();
		List<Listbean> recentlist = new ArrayList<Listbean>();
		List<Listbean> likedlist = new ArrayList<Listbean>();
		
		//ListDAO 객체 생성
		ListDAO lDAO = new ListDAO();
		
		//recentlist 및 likedlist 생성
		recentlist = lDAO.getrecentList(id, 1, 16);
		likedlist = lDAO.getfavoriteList(id, 1, 16);
		
		//request 및 response 설정
		request.setAttribute("recentlist", recentlist);
		request.setAttribute("likedlist", likedlist);
		
		RequestDispatcher dispatcher = request.getRequestDispatcher(url);
		dispatcher.forward(request,response);
	}
}
