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

public class BoardDeleteAction implements Action{
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//기본객체 생성
		HttpSession session = request.getSession();
		request.setCharacterEncoding("UTF-8");
		String id = (String)session.getAttribute("idKey");
		String boardtype = (String)session.getAttribute("boardtype");
		Boardbean bean = (Boardbean) session.getAttribute("bean");
		
		String nowPage = request.getParameter("nowPage");
		int num = Integer.parseInt(request.getParameter("num"));
		
		//boardDAO 객체 생성
		BoardDAO boarddao = new BoardDAO();
		
		if (request.getParameter("pass") != null) {
			String inPass = request.getParameter("pass");
			String dbPass = bean.getPass();
			if (inPass.equals(dbPass)) {
				boarddao.deleteBoard(num,boardtype);
				String url = "board_load.do?nowPage=" + nowPage;
				response.sendRedirect(url);
			} else {
				response.setContentType("text/html; charset=UTF-8");
				PrintWriter outs = response.getWriter();
				outs.println("<script> alert('비밀번호가 틀립니다.'); history.back(); </script>");
				outs.flush();
			}
		}
	}
}
