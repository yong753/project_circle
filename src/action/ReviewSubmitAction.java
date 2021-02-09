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

public class ReviewSubmitAction implements Action{
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//기본객체 생성
		request.setCharacterEncoding("UTF-8");
		HttpSession session = request.getSession();
		String id = (String)session.getAttribute("idKey");
		String playlisturl = request.getParameter("playlisturl");
		
		System.out.println(playlisturl);
		
		//pDAO생성
		PlayerDAO pDAO = new PlayerDAO();
		
		//리뷰 등록
		if (request.getParameter("star-input") != null){
			int rrating = Integer.parseInt(request.getParameter("star-input"));
			String rcontent = request.getParameter("star-review");
			pDAO.setReviewInfo(rrating, id, rcontent, playlisturl);
		}
	}
}
