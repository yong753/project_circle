package action;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.lang.Exception;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.MemberDAO;

public class MemberCheckNumberAction implements Action{
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
			//id수신
			request.setCharacterEncoding("UTF-8");
		    String number = request.getParameter("number");
		    
		    //DAO객체 생성
		    MemberDAO mem = new MemberDAO();
		    
		    //id중복체크
		    boolean result = mem.checkNumber(number);
			
			//portfolio_numberCheck.jsp로 전송
		    String resultstring = null;
		    
		    if(result == true) {
		    	resultstring = "true";
		    }else if(result == false) {
		    	resultstring = "false";
		    }
		    
		    System.out.print(resultstring);
		    
		    //데이터전송
		    String url = "portfolio_numberCheck.jsp?result="+resultstring;
		    
	        RequestDispatcher dispatcher = request.getRequestDispatcher(url);
			dispatcher.forward(request,response);
	}
}
