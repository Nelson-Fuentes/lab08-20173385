package controllers.roles;
import java.io.IOException;
import javax.jdo.PersistenceManager;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import controllers.PMF;
import controllers.users.AccessController;
import controllers.users.LogController;
import models.Role;
import models.User;
import models.Access;
import java.util.*;
public class DeleteController extends HttpServlet {
	public void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		if (AccessController.isPermited(req.getServletPath(), req, resp, this)){
			PersistenceManager pm = PMF.get().getPersistenceManager();
			Role rol = pm.getObjectById(Role.class, Long.parseLong(req.getParameter("id")));
			if ((!rol.getName().equalsIgnoreCase("Invitado"))&&!(rol.getName().equalsIgnoreCase("Administrador"))){
				boolean isLogged = LogController.isLogged();
				req.setAttribute("isLogged", isLogged);
				req.setAttribute("url", req.getRequestURI());
				User log = LogController.getUser();
				req.setAttribute("log", log);
				Role role = pm.getObjectById(Role.class, new Long(req.getParameter("id")).longValue());
				String query = "SELECT FROM "+ Role.class.getName();
				List<Role> roles = (List<Role>)pm.newQuery(query).execute();
				req.setAttribute("role", role);
				req.setAttribute("roles", roles);
				pm.close();
				RequestDispatcher rd = this.getServletContext().getRequestDispatcher("/WEB-INF/Views/Roles/delete.jsp");
				rd.forward(req, resp);
			} else {
				req.setAttribute("respuesta", "Los roles Administrador e Invitado no pueden ser eliminados");
				boolean isLogged = LogController.isLogged();
				req.setAttribute("isLogged", isLogged);
				req.setAttribute("url", req.getRequestURI());
				User log = LogController.getUser();
				req.setAttribute("log", log);
				RequestDispatcher rd = this.getServletContext().getRequestDispatcher("/WEB-INF/Views/Users/loginMistake.jsp");
				rd.forward(req, resp);
			}
		}
	}
	public void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		PersistenceManager pm = PMF.get().getPersistenceManager();
		Role role = pm.getObjectById(Role.class, new Long(req.getParameter("id")).longValue());
		if (role!=null){
			String query = "SELECT FROM "+ Access.class.getName()+ " where idRole == " + req.getParameter("id");
			List<Access> access = (List<Access>)pm.newQuery(query).execute();
			query = "SELECT FROM "+ User.class.getName()+ " where idRol == " + req.getParameter("id");
			List<User> users = (List<User>)pm.newQuery(query).execute();
			for (User us: users){
				us.setIdRol(Long.parseLong(req.getParameter("rol")));
			}
			for (Access ac: access){
				pm.deletePersistent(ac);
			}
			pm.deletePersistent(role);
		}
		pm.close();
		resp.sendRedirect("/roles");
	}
}
