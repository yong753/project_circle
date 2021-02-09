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

public class BoardReadAction implements Action{
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//기본객체 생성
		HttpSession session = request.getSession();
		request.setCharacterEncoding("UTF-8");
		String id = (String)session.getAttribute("idKey");
		String url = "/circle_board_read.jsp";
		
		//로그인 여부 체크
		if (id == null) {
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter outs = response.getWriter();
			outs.println("<script>alert('로그인 해주세요.'); location.href='login_load.do';</script>");
			outs.flush();
		}else {
			//게시판 객체 생성
			int num = Integer.parseInt(request.getParameter("num"));
			BoardDAO boarddao = new BoardDAO();
			String boardtype = (String)session.getAttribute("boardtype");
			
			System.out.println(num);
			
			//조회 게시물 조회수 증가
			boarddao.upCount(num, boardtype);
			
			//게시물 가져오기
			Boardbean bean = boarddao.getBoard(num, boardtype);
			
			String name = bean.getName();
			String subject = bean.getSubject();
			String regdate = bean.getRegdate();
			String content = bean.getContent();
			String filename = bean.getFilename();
			int filesize = bean.getFilesize();
			String ip = bean.getIp();
			int count = bean.getCount();
			
			System.out.println(name);
			System.out.println(subject);
			System.out.println(regdate);
			System.out.println(content);
			
			//request 및 response 설정
			session.setAttribute("bean", bean);//게시물을 세션에 저장
			
			request.setAttribute("num", num);
			request.setAttribute("name", name);
			request.setAttribute("subject", subject);
			request.setAttribute("regdate", regdate);
			request.setAttribute("content", content);
			request.setAttribute("filename", filename);
			request.setAttribute("filesize", filesize);
			request.setAttribute("ip", ip);
			request.setAttribute("count", count);
			
			RequestDispatcher dispatcher = request.getRequestDispatcher(url);
			dispatcher.forward(request,response);
		}
	}
}
