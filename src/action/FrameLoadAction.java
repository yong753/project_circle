package action;

import java.io.IOException;
import java.util.List;
import java.lang.Exception;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


import dao.ListDAO;
import dao.TagDAO;
import basic.WeatherJsonParser;
import bean.Listbean;
import bean.MostRecommendedbean;
import bean.RecentAddedListbean;
import bean.TagListbean;
import bean.WeatherListbean;

public class FrameLoadAction implements Action{
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//기본객체 생성
		HttpSession session = request.getSession();
		request.setCharacterEncoding("UTF-8");
		String id = (String)session.getAttribute("idKey");
		String url = "/circle_frame.jsp";
		
		//DAO객체 생성
		ListDAO lDao = new ListDAO();
		
		//위치 및 날씨 객체 생성
		String lat = (String)session.getAttribute("lat");
		String lng = (String)session.getAttribute("lng");
		WeatherJsonParser jparser = new WeatherJsonParser();
		String weather = null;
		
		//위치 및 날씨 입력
		try {
			weather = jparser.getJson("https://api.openweathermap.org/data/2.5/weather?lat="+lat+"&lon="+lng+"&appid=d0a998ccc694266743134194917c17f0");
		} catch (Exception e) {
			e.printStackTrace();
		}
	
		//리스트 생성
		List<Listbean> mostrecommended = lDao.getmostrecommended(weather);
		String mostrecommendedurl = mostrecommended.get(1).getUrl();
		String mainsrc = "https://www.youtube.com/embed/?autoplay=1&fs=0&list=" + mostrecommendedurl
		+ "&listType=playlist&controls=1&enablejsapi=1";
		
		System.out.print(mostrecommendedurl);
		
		//request 및 response 설정
		session.setAttribute("mostrecommendedurl", mostrecommendedurl);
		
		RequestDispatcher dispatcher = request.getRequestDispatcher(url);
		dispatcher.forward(request,response);
	}
}
