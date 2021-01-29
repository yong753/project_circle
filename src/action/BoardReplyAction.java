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

public class BoardReplyAction implements Action{
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("UTF-8");
		HttpSession session = request.getSession();
		String boardtype = (String)session.getAttribute("boardtype");
		
		BoardDAO bDAO = new BoardDAO();
		Boardbean reBean = new Boardbean();
		reBean.setName(request.getParameter("name"));
		reBean.setSubject(request.getParameter("subject"));
		reBean.setContent(request.getParameter("content"));
		reBean.setRef(Integer.parseInt(request.getParameter("ref"))); 
		reBean.setPos(Integer.parseInt(request.getParameter("pos"))); 
		reBean.setDepth(Integer.parseInt(request.getParameter("depth"))); 
		reBean.setPass(request.getParameter("pass"));
		reBean.setIp(request.getParameter("ip"));

		bDAO.replyUpBoard(reBean.getRef(), reBean.getPos());
		bDAO.replyBoard(reBean,boardtype);
		
		String nowPage = request.getParameter("nowPage");
		response.sendRedirect("board_load.do?nowPage="+nowPage);
	}
	
}
