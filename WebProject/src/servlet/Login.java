package servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.LoginLogic;
import model.LoginModel;
import model.User;


@WebServlet("/Login")
public class Login extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//フォワード
		HttpSession session=request.getSession();
		User user = (User) session.getAttribute("user");

		if(user!=null) {
			response.sendRedirect("/rideau/MyPage");
		}else {
			RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/login.jsp");
			dispatcher.forward(request, response);

		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//リクエストパラメーターの取得
		request.setCharacterEncoding("UTF-8");

		String email = request.getParameter("email");
		String password = request.getParameter("password");


		//ログイン処理の実行
		LoginModel login = new LoginModel(email, password);
		LoginLogic bo = new LoginLogic();
		boolean result = bo.execute(login);

		//ログイン処理の成否によって処理を分岐
		if(result) {//ログイン成功時
			//セッションスコープにuserを保存

			HttpSession session = request.getSession();
			session.setAttribute("user",bo.findUser(login) );
			session.removeAttribute("errorMsg");

			RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/myPage.jsp");
			dispatcher.forward(request, response);

		}else {//ログイン失敗時
			request.setAttribute("errorMsg","ユーザーIDもしくはパスワードが間違っています。");
			RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/login.jsp");
			dispatcher.forward(request, response);

		}
	}
}
