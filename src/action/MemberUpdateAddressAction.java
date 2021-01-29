package action;

import java.io.IOException;
import java.lang.Exception;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.MemberDAO;

public class MemberUpdateAddressAction implements Action{
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//객체 로드
		request.setCharacterEncoding("UTF-8");
		HttpSession session = request.getSession();
		String id = (String)session.getAttribute("idKey");
		String address1 = request.getParameter("address1");
		String address2 = request.getParameter("address2");
		String address = address1 + address2;
		
		//mDAO생성
		MemberDAO mDAO = new MemberDAO();
		
		//검토
		System.out.print(address1);
		System.out.print(address2);
		System.out.print(id);
		
		mDAO.updateAddress(address,id);
		response.sendRedirect("portfolio_mypage.jsp");
		System.out.print("성공");
	}
}
