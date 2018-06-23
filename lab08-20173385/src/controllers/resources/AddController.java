package controllers.resources;

import java.io.IOException;
import java.util.List;

import javax.jdo.PersistenceManager;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import controllers.PMF;
import controllers.users.AccessController;
import controllers.users.LogController;
import models.Resource;
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
			RequestDispatcher rd = this.getServletContext().getRequestDispatcher("/WEB-INF/Views/Resources/add.jsp");
			rd.forward(req, resp);
		}
	}
	public void doPost(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException{
		PersistenceManager pm = PMF.get().getPersistenceManager();
		String query = "select from " + Resource.class.getName()	+ " where url == '"+request.getParameter("url")+"'";
		List<Resource> resources = (List<Resource>)pm.newQuery(query).execute();
		if (resources.isEmpty()){
			Resource resource = new Resource(request.getParameter("url"));
			pm.makePersistent(resource);
		}
		pm.close();
		response.sendRedirect("/resources");
	}
}
