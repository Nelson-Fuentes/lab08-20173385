package controllers.users;
import java.io.IOException;

import javax.jdo.PersistenceManager;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.*;

import com.google.appengine.api.users.UserService;
import com.google.appengine.api.users.UserServiceFactory;

import controllers.PMF;
import models.User;
public class DeleteController extends HttpServlet {
	public void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		if (AccessController.isPermited(req.getServletPath(), req, resp, this)){
			User log = LogController.getUser();
			PersistenceManager pm = PMF.get().getPersistenceManager();
			User user = pm.getObjectById(User.class, new Long(req.getParameter("id")).longValue());
		//	pm.close();
			if (user!=null){
				if (user.getCorreo().equalsIgnoreCase("in@vita.do")){
					req.setAttribute("respuesta", "Se produjo un error durante la eliminacion debido a que no se puede eliminar a un usuario con el rol Invitado");
					req.setAttribute("log", log);
					boolean isLogged = LogController.isLogged();
					req.setAttribute("isLogged", isLogged);
					req.setAttribute("url", req.getRequestURI());
					pm.close();
					RequestDispatcher rd = this.getServletContext().getRequestDispatcher("/WEB-INF/Views/Users/loginMistake.jsp");
					rd.forward(req, resp);
				} else {
					boolean isSame = log.getId().equals(user.getId());
					if (isSame && user.getRol().equalsIgnoreCase("Administrador")){
						req.setAttribute("respuesta", "Se produjo un error durante la eliminacion debido a que un usuario con el rol administrador no puede eliminarse asi mismo");
						req.setAttribute("log", log);
						boolean isLogged = LogController.isLogged();
						req.setAttribute("isLogged", isLogged);
						req.setAttribute("url", req.getRequestURI());
						pm.close();
						RequestDispatcher rd = this.getServletContext().getRequestDispatcher("/WEB-INF/Views/Users/loginMistake.jsp");
						rd.forward(req, resp);
					} else {
						pm.deletePersistent(user);
						String directory = "/users";
						if (isSame){
							UserService us = UserServiceFactory.getUserService();
							directory = us.createLogoutURL(directory);
						}
						pm.close();
						resp.sendRedirect(directory);
					}
				}
				/*if (!(log.getId().equals(user.getId()) && log.getRol().equalsIgnoreCase("Administrador"))|| !user.getRol().equalsIgnoreCase("Invitado")){
					boolean same = log.getId().equals(user.getId());
					pm.deletePersistent(user);
					if (same){
						UserService us = UserServiceFactory.getUserService();
						resp.sendRedirect(us.createLogoutURL("/users"));
					} else {
						resp.sendRedirect("/users");
					}
				} else {
					req.setAttribute("respuesta", "Se produjo un error durante la eliminacion esto puede deberse a que intento a un usuario con el rol de Inivitado o intento eliminarse asi mismo y usted ocupa el rol de Administrador");
					req.setAttribute("log", log);
					boolean isLogged = LogController.isLogged();
					req.setAttribute("isLogged", isLogged);
					req.setAttribute("url", req.getRequestURI());
					RequestDispatcher rd = this.getServletContext().getRequestDispatcher("/WEB-INF/Views/Users/loginMistake.jsp");
					rd.forward(req, resp);
				}*/
			} else {
				resp.sendRedirect("/users");
			}
		}
	}
}
