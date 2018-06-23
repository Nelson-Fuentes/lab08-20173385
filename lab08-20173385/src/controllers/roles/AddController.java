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

public class AddController extends HttpServlet {
	public void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		if (AccessController.isPermited(req.getServletPath(), req, resp, this)){
			boolean isLogged = LogController.isLogged();
			req.setAttribute("isLogged", isLogged);
			req.setAttribute("url", req.getRequestURI());
			User log = LogController.getUser();
			req.setAttribute("log", log);
			RequestDispatcher rd = this.getServletContext().getRequestDispatcher("/WEB-INF/Views/Roles/add.jsp");
			rd.forward(req, resp);
		}
	}
	public void doPost(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException{
		PersistenceManager pm = PMF.get().getPersistenceManager();
		String query = "select from " + Role.class.getName()	+ " where name == '"+request.getParameter("name")+"'";
		List<Role> roles = (List<Role>)pm.newQuery(query).execute();
		if (roles.isEmpty()){
			Role role = new Role(request.getParameter("name"));
			pm.makePersistent(role);
		}
		pm.close();
		response.sendRedirect("/roles");
	}
}

