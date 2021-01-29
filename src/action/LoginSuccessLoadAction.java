package action;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.Vector;
import java.lang.Exception;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.BoardDAO;
import dao.ListDAO;
import dao.TagDAO;
import basic.WeatherJsonParser;
import bean.Boardbean;
import bean.ChartListbean;
import bean.Listbean;
import bean.MostRecommendedbean;
import bean.RecentAddedListbean;
import bean.TagListbean;
import bean.WeatherListbean;

public class LoginSuccessLoadAction implements Action{
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//기본객체 생성
		request.setCharacterEncoding("UTF-8");
		String url = "/circle_login_success.jsp";
		
		RequestDispatcher dispatcher = request.getRequestDispatcher(url);
		dispatcher.forward(request,response);
	}
	
}
