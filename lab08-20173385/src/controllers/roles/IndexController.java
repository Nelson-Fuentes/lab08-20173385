package controllers.roles;

import java.io.IOException;
import java.util.List;

import javax.jdo.PersistenceManager;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import controllers.PMF;
import controllers.users.AccessController;
import controllers.users.LogController;
import models.Role;
import models.User;

public class IndexController extends HttpServlet {
	public void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		if (AccessController.isPermitedIndex(req.getServletPath(), req, resp, this)){
			boolean isLogged = LogController.isLogged();
			req.setAttribute("isLogged", isLogged);
			req.setAttribute("url", req.getRequestURI());
			User log = LogController.getUser();
			req.setAttribute("log", log);
			PersistenceManager pm = PMF.get().getPersistenceManager();
			String query = "SELECT FROM "+ Role.class.getName();
			List<Role> roles = (List<Role>)pm.newQuery(query).execute();
			pm.close();
			req.setAttribute("roles", roles);
			RequestDispatcher rd = this.getServletContext().getRequestDispatcher("/WEB-INF/Views/Roles/index.jsp");
			rd.forward(req, resp);
		}
	}
}
