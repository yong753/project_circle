package action;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import basic.WeatherJsonParser;
import bean.Listbean;
import dao.ListDAO;

public class BasicLocationAction implements Action {
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//기본객체
		HttpSession session = request.getSession();
		String lat = request.getParameter("lat");
		String lng = request.getParameter("lng");
		String url = "frame_load.do";
		
		//DAO객체 생성
		ListDAO lDao = new ListDAO();
		
		//위치 및 날씨 입력
		String weather = null;
		WeatherJsonParser jparser = new WeatherJsonParser();
		
		try {
			weather = jparser.getJson("https://api.openweathermap.org/data/2.5/weather?lat="+lat+"&lon="+lng+"&appid=d0a998ccc694266743134194917c17f0");
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		//리스트 생성
		List<Listbean> mostrecommended = lDao.getmostrecommended(weather);
		String playlisturl = mostrecommended.get(1).getUrl();
		String playlisttitle = mostrecommended.get(1).getTitle();
		
		//request 및 response 설정
		if(lat!=null && lng!=null) {
			session.setAttribute("lat", lat);
			session.setAttribute("lng", lng);
			session.setAttribute("playlisturl", playlisturl);
			session.setAttribute("playlisttitle", playlisttitle);
			
			response.sendRedirect("frame_load.do");
		}else {
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>alert('날씨 정보를 수신하는 중입니다.'); location.href='circle_intro.jsp';</script>");
			out.flush();
		}
	}
}
