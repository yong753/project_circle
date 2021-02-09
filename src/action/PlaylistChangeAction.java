package action;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import java.lang.Exception;
import java.net.URLDecoder;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.PlayerDAO;
import basic.ThumbJsonParser;
import bean.ReviewListbean;

public class PlaylistChangeAction implements Action{
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//기본객체 생성
		request.setCharacterEncoding("UTF-8");
		HttpSession session = request.getSession();
		
		System.out.println(request.getParameter("playlisturl"));
		System.out.println(request.getParameter("playlisttitle"));
		System.out.println("플레이리스트 목록 바꾸기");
		
		//세션에 새 플레이리스트 지정
		session.setAttribute("playlisturl",request.getParameter("playlisturl"));
		session.setAttribute("playlisttitle",request.getParameter("playlisttitle"));
	}
}
