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
import models.Access;
import models.Role;
import models.User;

public class ViewController extends HttpServlet {
	public void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		if (AccessController.isPermited(req.getServletPath(), req, resp, this)){
			boolean isLogged = LogController.isLogged();
			req.setAttribute("isLogged", isLogged);
			req.setAttribute("url", req.getRequestURI());
			User log = LogController.getUser();
			req.setAttribute("log", log);
			PersistenceManager pm = PMF.get().getPersistenceManager();
			Role rol = pm.getObjectById(Role.class, Long.parseLong(req.getParameter("id")));
			String query = "SELECT FROM "+ Access.class.getName()+ " where idRole == " + req.getParameter("id");
			List<Access> access = (List<Access>)pm.newQuery(query).execute();
			pm.close();
			req.setAttribute("role", rol);
			req.setAttribute("acc", access);
			RequestDispatcher rd = this.getServletContext().getRequestDispatcher("/WEB-INF/Views/Roles/view.jsp");
			rd.forward(req, resp);
		}
	}
}