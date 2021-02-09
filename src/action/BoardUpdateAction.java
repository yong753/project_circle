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

public class BoardUpdateAction implements Action{
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("UTF-8");
		HttpSession session = request.getSession();
		String boardtype = (String)session.getAttribute("boardtype");
		response.setContentType("text/html; charset=UTF-8");

		PrintWriter out = response.getWriter(); 

		BoardDAO bDAO = new BoardDAO();
		Boardbean bean = (Boardbean) session.getAttribute("bean");
		String nowPage = request.getParameter("nowPage");
		
		Boardbean upBean = new Boardbean();
		upBean.setNum(Integer.parseInt(request.getParameter("num")));
		upBean.setName(request.getParameter("name"));
		upBean.setSubject(request.getParameter("subject"));
		upBean.setContent(request.getParameter("content"));
		upBean.setPass(request.getParameter("pass"));
		upBean.setIp(request.getParameter("ip"));

		String upPass = upBean.getPass();
		String inPass = bean.getPass();
		
		if (upPass.equals(inPass)) {
			bDAO.updateBoard(upBean,boardtype);
			String url = "board_load.do?nowPage=" + nowPage + "&num=" + upBean.getNum();
			response.sendRedirect(url);
		} else {
			String alert = "로그인 해주세요";
			request.setAttribute("alert", alert);
			
			String url = "circle_board_update.jsp?nowPage="+nowPage+"&num="+ upBean.getNum();
			response.sendRedirect(url);
		}
	}
	
}
