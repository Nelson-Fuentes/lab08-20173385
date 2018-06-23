package controllers.users;

import javax.jdo.PersistenceManager;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import models.Access;
import controllers.PMF;
import models.User;
import models.Resource;

import java.io.IOException;
import java.util.List;

public class AccessController {
	public static boolean  isPermited (String url, HttpServletRequest request, HttpServletResponse response, HttpServlet servlet) throws ServletException, IOException{
		String respuesta = "";
		PersistenceManager pm = PMF.get().getPersistenceManager();
		if (LogController.isLogged()){
			User usuario = LogController.getUser();
			String query = "select from " + Resource.class.getName()	+ " where url == '"+url+"'";
			List<Resource> resources = (List<Resource>)pm.newQuery(query).execute();
			if (!resources.isEmpty()){
				query = "select from " + Access.class.getName()	+ " where idRole == "+usuario.getIdRol()+ " && idResource == "+ resources.get(0).getId()+" && status == true";
				List<Access> access = (List<Access>)pm.newQuery(query).execute();
				if (!access.isEmpty()){
					pm.close();
					return true;
				} else {
					respuesta = "Usted no tiene los permisos suficientes para acceder a esta funcion<br>"
							+ "Para cambiar esto comunicarse con un usario con los <a href=\"/access\">accesos</a> de edicion de usuario";
				}
			} else {
				respuesta = "El recurso al que intenta acceder no existe por favor comuniquese con un usuario a cargo para solucionar este problema <br>"
						+ "<b>Para mas informacion</b> sobre los recursos activos visitar <a  href=\"/resources\">resources</a>";
			}
		} else {
			respuesta = "Por favor <a href=\"/users/login\">inicie sesion<a> para acceder a esta funcion ";
		}
		pm.close();
		request.setAttribute("respuesta", respuesta);
		boolean isLogged = LogController.isLogged();
		request.setAttribute("isLogged", isLogged);
		request.setAttribute("url", request.getRequestURI());
		User log = LogController.getUser();
		request.setAttribute("log", log);
		RequestDispatcher rd = servlet.getServletContext().getRequestDispatcher("/WEB-INF/Views/Users/loginMistake.jsp");
		rd.forward(request, response);
		return false;
	}
	public static boolean  isPermitedIndex (String url, HttpServletRequest request, HttpServletResponse response, HttpServlet servlet) throws ServletException, IOException{
		String respuesta = "";
		PersistenceManager pm = PMF.get().getPersistenceManager();
		User usuario = LogController.getUser();
		String query = "select from " + Resource.class.getName()	+ " where url == '"+url+"'";
		List<Resource> resources = (List<Resource>)pm.newQuery(query).execute();
		if (!resources.isEmpty()){
			query = "select from " + Access.class.getName()	+ " where idRole == "+usuario.getIdRol()+ " && idResource == "+ resources.get(0).getId()+" && status == true";
			List<Access> access = (List<Access>)pm.newQuery(query).execute();
			if (!access.isEmpty()){
				pm.close();
				return true;
			} else {
				respuesta = "Usted no tiene los permisos suficientes para acceder a esta funcion<br>"
						+ "Para cambiar esto comunicarse con un usario con los <a href=\"/access\">accesos</a> de edicion de usuario";
			}
		} else {
			respuesta = "El recurso al que intenta acceder no existe por favor comuniquese con un usuario a cargo para solucionar este problema <br>"
					+ "<b>Para mas informacion</b> sobre los recursos activos visitar <a  href=\"/resources\">resources</a>";
		}
		pm.close();
		request.setAttribute("respuesta", respuesta);
		boolean isLogged = LogController.isLogged();
		request.setAttribute("isLogged", isLogged);
		request.setAttribute("url", request.getRequestURI());
		User log = LogController.getUser();
		request.setAttribute("log", log);
		RequestDispatcher rd = servlet.getServletContext().getRequestDispatcher("/WEB-INF/Views/Users/loginMistake.jsp");
		rd.forward(request, response);
		return false;
	}
}
