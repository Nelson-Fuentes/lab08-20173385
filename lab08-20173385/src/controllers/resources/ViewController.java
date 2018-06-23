package controllers.resources;

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
import models.Resource;
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
			Resource resource = pm.getObjectById(Resource.class, Long.parseLong(req.getParameter("id")));
			String query = "SELECT FROM "+ Access.class.getName()+ " where idResource == " + req.getParameter("id");
			List<Access> access = (List<Access>)pm.newQuery(query).execute();
			pm.close();
			req.setAttribute("rsr", resource);
			req.setAttribute("acc", access);
			RequestDispatcher rd = this.getServletContext().getRequestDispatcher("/WEB-INF/Views/Resources/view.jsp");
			rd.forward(req, resp);

		}
	}
}