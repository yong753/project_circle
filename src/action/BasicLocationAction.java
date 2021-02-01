package action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class BasicLocationAction implements Action {
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String lat = request.getParameter("lat");
		String lng = request.getParameter("lng");
		String url = "frame_load.do";
		/* String location = "main_load.do"; */
		
		System.out.print(lat);
		System.out.print(lng);
		
		if(lat!=null && lng!=null) {
			HttpSession session = request.getSession();
			session.setAttribute("lat", lat);
			session.setAttribute("lng", lng);
			/* request.setAttribute("location", location); */
			
			response.sendRedirect("frame_load.do");
		}else {
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>alert('날씨 정보를 수신하는 중입니다.'); location.href='circle_intro.jsp';</script>");
			out.flush();
		}
	}
}
