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
import models.Resource;
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
			String query = "SELECT FROM "+ Resource.class.getName();
			List<Resource> resource = (List<Resource>)pm.newQuery(query).execute();
			pm.close();
			req.setAttribute("resource", resource);
			RequestDispatcher rd = this.getServletContext().getRequestDispatcher("/WEB-INF/Views/Resources/index.jsp");
			rd.forward(req, resp);
		}
	}
}
