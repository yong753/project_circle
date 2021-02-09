package action;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import java.lang.Exception;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.ListDAO;
import dao.MemberDAO;
import dao.TagDAO;
import basic.WeatherJsonParser;
import bean.ChartListbean;
import bean.Listbean;
import bean.MemberBean;
import bean.MostRecommendedbean;
import bean.RecentAddedListbean;
import bean.TagListbean;
import bean.WeatherListbean;

public class MypageLoadAction implements Action{
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//기본객체 생성
		HttpSession session = request.getSession();
		request.setCharacterEncoding("UTF-8");
		String id = (String)session.getAttribute("idKey");
		String url = "/circle_mypage.jsp";
		
		//로그인 여부 체크
		if (id == null) {
			String alert = "로그인 해주세요";
			request.setAttribute("alert", alert);
			
			RequestDispatcher dispatcher = request.getRequestDispatcher("/circle_login.jsp");
			dispatcher.forward(request,response);
		}else {
			//memberDAO 객체 생성
			MemberDAO mDAO = new MemberDAO();
			
			//db에서 회원정보 가져오기.
			MemberBean bean = mDAO.getMemberInfo(id);
			String name = bean.getName();
			String email = bean.getEmail();
			String address = bean.getAddress();
			
			//request 및 response 설정
			request.setAttribute("name", name);
			request.setAttribute("email", email);
			request.setAttribute("address", address);
			
			RequestDispatcher dispatcher = request.getRequestDispatcher(url);
			dispatcher.forward(request,response);
		}
		
	}
}
