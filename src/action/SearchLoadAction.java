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


import dao.ListDAO;
import dao.TagDAO;
import basic.WeatherJsonParser;
import bean.Listbean;
import bean.MostRecommendedbean;
import bean.RecentAddedListbean;
import bean.TagListbean;
import bean.WeatherListbean;

public class SearchLoadAction implements Action{
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//기본객체 생성
		HttpSession session = request.getSession();
		request.setCharacterEncoding("UTF-8");
		
		String url = "/circle_search_result.jsp";
		String keyword = request.getParameter("keyword");
		System.out.println("액션 keyword"+keyword);
		
		//DAO객체 생성
		ListDAO lDao = new ListDAO();
		
		//searchlist 수신
		List<Listbean> searchlist = lDao.getTagList(keyword);
		
		//request 및 response 설정
		request.setAttribute("searchlist", searchlist);
		request.setAttribute("keyword", keyword);
		
		RequestDispatcher dispatcher = request.getRequestDispatcher(url);
		dispatcher.forward(request,response);
	}
}
