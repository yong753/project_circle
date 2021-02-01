package action;

import java.io.IOException;
import java.lang.Exception;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import basic.WeatherJsonParser;
import bean.Listbean;
import dao.ListDAO;
import dao.MemberDAO;

public class MemberLogoutAction implements Action{
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//세션만료
		HttpSession session = request.getSession();
		session.removeAttribute("idKey");
		
		//기본객체 생성
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
		request.setAttribute("mostrecommended", mainsrc);
		
		RequestDispatcher dispatcher = request.getRequestDispatcher(url);
		dispatcher.forward(request,response);
	}
}
