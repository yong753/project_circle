package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import action.BasicLocationAction;
import action.BoardDeleteAction;
import action.BoardLoadAction;
import action.BoardReadAction;
import action.BoardReplyAction;
import action.BoardUpdateAction;
import action.BoardWriteAction;
import action.BoardWriteLoadAction;
import action.ChartLoadAction;
import action.FrameLoadAction;
import action.GotoAction;
import action.LibraryLoadAction;
import action.LoginLoadAction;
import action.LoginSuccessLoadAction;
import action.MainLoadAction;
import action.MemberCheckIdAction;
import action.MemberCheckNumberAction;
import action.MemberLoginAction;
import action.MemberLogoutAction;
import action.MemberPasswordCheckAction;
import action.MemberUpdateAddressAction;
import action.MemberUpdatePasswordAction;
import action.PlayerLoadAction;
import action.PlaylistChangeAction;
import action.PlaylistLikeAction;
import action.ReviewSubmitAction;
import action.SearchAction;
import action.SearchLoadAction;

// *.do Ȯ���ڸ� ��� ó���ϰڴٰ� ���
	@WebServlet("*.do")
	public class FrontController extends HttpServlet {
		private static final long serialVersionUID = 1L;
	    
	    public FrontController() {
	        super();
	    }

		protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			System.out.println("doGet");
			actionDo(request, response);
		}

		protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			System.out.println("doPost");
			actionDo(request, response);
		}
		
		private void actionDo(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			System.out.println("actionDo");
			String uri = request.getRequestURI();
			System.out.println("uri : " + uri);
			String conPath = request.getContextPath();
			System.out.println("conPath : " + conPath);
			String command = uri.substring(conPath.length());
			System.out.println("command : " + command);
			
			Action action = null;
			
			//Frame Load 액션
			if(command.equals("/frame_load.do")){
				action = new FrameLoadAction();
			}
			//Load 액션
			else if(command.equals("/main_load.do")){
				action = new MainLoadAction();
			}else if(command.equals("/chart_load.do")) {
				action = new ChartLoadAction();
			}else if(command.equals("/library_load.do")) {
				action = new LibraryLoadAction();
			}else if(command.equals("/player_load.do")) {
				action = new PlayerLoadAction();
			}else if(command.equals("/board_load.do")) {
				action = new BoardLoadAction();
			}else if(command.equals("/login_load.do")) {
				action = new LoginLoadAction();
			}else if(command.equals("/login_success_load.do")) {
				action = new LoginSuccessLoadAction();
			}else if(command.equals("/mypage_load.do")) {
				//action = new MypageLoadAction();
			}
			//board 액션
			else if(command.equals("/board_read_load.do")) {
				action = new BoardReadAction();
			}else if(command.equals("/board_reply.do")) {
				action = new BoardReplyAction();
			}else if(command.equals("/board_write.do")) {
				action = new BoardWriteAction();
			}else if(command.equals("/board_write_load.do")) {
				action = new BoardWriteLoadAction();
			}else if(command.equals("/board_update.do")) {
				action = new BoardUpdateAction();
			}else if(command.equals("/board_delete.do")) {
				action = new BoardDeleteAction();
			}
			//member 액션
			else if(command.equals("/member_checkid.do")) {
				action = new MemberCheckIdAction();
			}else if(command.equals("/member_checknumber.do")) {
				action = new MemberCheckNumberAction();
			}else if(command.equals("/member_login.do")) {
				action = new MemberLoginAction();
			}else if(command.equals("/member_logout.do")) {
				action = new MemberLogoutAction();
			}else if(command.equals("/member_passwordcheck.do")) {
				action = new MemberPasswordCheckAction();
			}else if(command.equals("/member_updateaddress.do")) {
				action = new MemberUpdateAddressAction();
			}else if(command.equals("/member_updatepw.do")) {
				action = new MemberUpdatePasswordAction();
			}else if(command.equals("/member_findid.do")) {
				
			}else if(command.equals("/member_findpw.do")) {
				
			}
			
			//basic 액션
			else if(command.equals("/search_load.do")) {
				action = new SearchLoadAction();
			}else if(command.equals("/basic_location.do")) {
				action = new BasicLocationAction();
			}else if(command.equals("/search_action.do")) {
				action = new SearchAction();
			}else if(command.equals("/playlist_change_action.do")) {
				action = new PlaylistChangeAction();
			}else if(command.equals("/playlist_like.do")) {
				action = new PlaylistLikeAction();
			}else if(command.equals("/review_submit.do")) {
				action = new ReviewSubmitAction();
			}
			
			
			action.execute(request,response);
		}
	}
