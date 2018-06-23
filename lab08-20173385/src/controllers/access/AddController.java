package controllers.access;

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
import models.Role;
import models.User;
import models.Resource;
import models.Access;
public class AddController extends HttpServlet {
	public void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		if (AccessController.isPermited(req.getServletPath(), req, resp, this)){
			boolean isLogged = LogController.isLogged();
			req.setAttribute("isLogged", isLogged);
			req.setAttribute("url", req.getRequestURI());
			User log = LogController.getUser();
			req.setAttribute("log", log);
			RequestDispatcher rd = this.getServletContext().getRequestDispatcher("/WEB-INF/Views/Access/add.jsp");
			PersistenceManager pm = PMF.get().getPersistenceManager();
			String query = "SELECT FROM "+ Role.class.getName();
			List<Role> roles = (List<Role>)pm.newQuery(query).execute();
			query = "SELECT FROM "+ Resource.class.getName();
			List<Resource> resource = (List<Resource>)pm.newQuery(query).execute();
			pm.close();
			req.setAttribute("roles", roles);
			req.setAttribute("rsr", resource);
			rd.forward(req, resp);
		}
	}
	public void doPost(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException{
		PersistenceManager pm = PMF.get().getPersistenceManager();
		String query = "select from " + Access.class.getName()	+ " where idRole == "+request.getParameter("rol")+ " && idResource == "+ request.getParameter("url");
		List<Access> resources = (List<Access>)pm.newQuery(query).execute();
		if (resources.isEmpty()){
			Access access = new Access(Long.parseLong(request.getParameter("rol")), Long.parseLong(request.getParameter("url")), Boolean.parseBoolean(request.getParameter("is")));
			pm.makePersistent(access);
		}
		pm.close();
		response.sendRedirect("/access");
	}
}
