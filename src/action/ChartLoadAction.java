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

public class ChartLoadAction implements Action{
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//기본객체 생성
		HttpSession session = request.getSession();
		request.setCharacterEncoding("UTF-8");
		String id = (String)session.getAttribute("idKey");
		String url = "/circle_chart.jsp";
		
		//차트 관련 객체 생성
		String chartduration = request.getParameter("chartduration");
		Listbean data = new Listbean();
		List<Listbean> chartlist = new ArrayList<Listbean>();
		
		//ListDAO 객체 생성
		ListDAO lDAO = new ListDAO();
		
		//일간, 주간차트 결정 및 list 생성
		if(chartduration != null){
			if(chartduration.equals("weekly")){
				chartlist = lDAO.getweeklychartList(1, 20);
			}else{
				chartlist = lDAO.getdailychartList(1, 20);
			}
		}else{
			chartlist = lDAO.getdailychartList(1, 20);
		}
		
		//request 및 response 설정
		request.setAttribute("chartlist", chartlist);
		request.setAttribute("chartduration", chartduration);
		
		RequestDispatcher dispatcher = request.getRequestDispatcher(url);
		dispatcher.forward(request,response);
	}
	
}
