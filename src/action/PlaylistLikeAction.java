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

public class PlaylistLikeAction implements Action{
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//기본객체 생성
		request.setCharacterEncoding("UTF-8");
		HttpSession session = request.getSession();
		String id = (String)session.getAttribute("idKey");
		String playlisturl = request.getParameter("playlisturl");
		String playlisttitle = request.getParameter("playlisttitle");
		
		//pDAO생성
		PlayerDAO pDAO = new PlayerDAO();
		
		//좋아요 변경
		pDAO.likeChange(id, playlisturl, playlisttitle);
	}
}
