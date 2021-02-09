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

public class BoardWriteLoadAction implements Action{
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//기본객체
		HttpSession session = request.getSession();
		request.setCharacterEncoding("UTF-8");
		String id = (String)session.getAttribute("idKey");
		
		if (id == null) {
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter outs = response.getWriter();
			outs.println("<script>alert('로그인 해주세요.'); location.href='frame_load.do?location=login_load.do';</script>");
		}else {
			response.sendRedirect("circle_board_write.jsp");
		}
	}
}
