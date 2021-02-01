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

public class BoardLoadAction implements Action{
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//기본객체 생성
		HttpSession session = request.getSession();
		request.setCharacterEncoding("UTF-8");
		String id = (String)session.getAttribute("idKey");
		String url = "/circle_board.jsp";
		
		//개시판 객체 생성
		int totalRecord = 0; //전체레코드수
		
		int start = 1; //디비의 select 시작번호
		int end = 10; //시작번호로 부터 가져올 select 갯수
		
		int numPerPage = 10; // 페이지당 레코드 수 
		int pagePerBlock = 15; //블럭당 페이지수 
		
		int nowPage = 1; // 현재페이지
		int totalPage = 0; //전체 페이지 수
		
		int totalBlock = 0; //전체 블럭수 
		int nowBlock = 1; //현재블럭
		
		BoardDAO bDAO = new BoardDAO();
		
		//nowpage, numPerPage
		if(request.getParameter("nowPage") != null) {
			nowPage = Integer.parseInt(request.getParameter("nowPage"));
		}
		
		//start , end 결정
		start = (nowPage * numPerPage) - numPerPage;
		end = nowPage * numPerPage;
		
		//게시판 타입 결정
		Vector<Boardbean> vlist = null;
		String boardtype = request.getParameter("boardtype");
		
		if(boardtype == null){
			boardtype = "공지사항";
		}
		
		//검색 기능
		String keyWord = "", keyField = "";
		if (request.getParameter("keyWord") != null) {
			keyWord = request.getParameter("keyWord");
			keyField = request.getParameter("keyField");
		}
		if (request.getParameter("reload") != null) {
			if (request.getParameter("reload").equals("true")) {
				keyWord = "";
				keyField = "";
			}
		}
		
		//게시판 타입에 따라 total count 변경
		if(boardtype.equals("공지사항")){
			totalRecord = bDAO.getnoticeTotalCount(keyField, keyWord);
		}else{
			totalRecord = bDAO.getboardTotalCount(keyField, keyWord);
		}

		//게시판 data 받아오기
		if(boardtype.equals("공지사항")){
			vlist = bDAO.getNoticeList(keyField, keyWord, start, end);
		}else{
			vlist = bDAO.getBoardList(keyField, keyWord, start, end);
		}
		
		//페이지 출력기능
		if (request.getParameter("nowPage") != null) {
			nowPage = Integer.parseInt(request.getParameter("nowPage"));
		}
		
		totalPage = (int) Math.ceil((double) totalRecord / numPerPage); //전체페이지수
		nowBlock = (int) Math.ceil((double) nowPage / pagePerBlock); //현재블럭 계산
		totalBlock = (int) Math.ceil((double) totalPage / pagePerBlock); //전체블럭계산
		
		//검토
		System.out.print(boardtype);
		System.out.print(start);
		System.out.print(end);
		
		//request 및 response 설정
		request.setAttribute("pagePerBlock", pagePerBlock);
		request.setAttribute("totalRecord", totalRecord);
		request.setAttribute("vlist", vlist);
		request.setAttribute("totalPage", totalPage);
		request.setAttribute("nowPage", nowPage);
		request.setAttribute("nowBlock", nowBlock);
		request.setAttribute("totalBlock", totalBlock);
		request.setAttribute("numPerPage", numPerPage);
		request.setAttribute("keyWord", keyWord);
		request.setAttribute("keyField", keyField);
		
		session.setAttribute("boardtype", boardtype);
		
		RequestDispatcher dispatcher = request.getRequestDispatcher(url);
		dispatcher.forward(request,response);
	}
	
}
