package controllers.users;

import java.io.IOException;
import java.util.List;

import javax.jdo.PersistenceManager;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import controllers.PMF;
import models.User;

public class IndexController extends HttpServlet {
	public void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		if (AccessController.isPermitedIndex(req.getServletPath(), req, resp, this)){
			req.setAttribute("log", LogController.getUser());
			boolean isLogged = LogController.isLogged();
			req.setAttribute("isLogged", isLogged);
			req.setAttribute("url", req.getRequestURI());
			PersistenceManager pm = PMF.get().getPersistenceManager();
			String query = "SELECT FROM "+ User.class.getName();
			List<User> users = (List<User>)pm.newQuery(query).execute();
			pm.close();
			req.setAttribute("users", users);
			RequestDispatcher rd = this.getServletContext().getRequestDispatcher("/WEB-INF/Views/Users/index.jsp");
			rd.forward(req, resp);
		}
	}
}
