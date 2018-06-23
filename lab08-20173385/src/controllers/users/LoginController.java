package controllers.users;

import java.io.IOException;

import javax.jdo.PersistenceManager;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.google.appengine.api.users.UserService;
import com.google.appengine.api.users.UserServiceFactory;
import controllers.PMF;
import java.util.List;
import models.User;

public class LoginController extends HttpServlet {
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		UserService us = UserServiceFactory.getUserService();
		com.google.appengine.api.users.User user = us.getCurrentUser();
		if (user==null){
			if (request.getParameter("p")==null)
				 response.sendRedirect(us.createLoginURL(request.getRequestURI()+"?url="+request.getParameter("url")));
			else {
				request.setAttribute("respuesta", "No existe el usuario que desea ingresar " + "<a href=\"/users/register?email?=+"+request.getParameter("email")+"\">Registrar</a>");
				boolean isLogged = LogController.isLogged();
				request.setAttribute("isLogged", isLogged);
				request.setAttribute("url", request.getRequestURI());
				User log = LogController.getUser();
				request.setAttribute("log", log);
				RequestDispatcher rd = this.getServletContext().getRequestDispatcher("/WEB-INF/Views/Users/loginMistake.jsp");
				rd.forward(request, response);
			}
		} else{
			String query = "select from " + User.class.getName()	+ " where correo == '"+user.getEmail()+"'";
			PersistenceManager pm = PMF.get().getPersistenceManager();
			List<User> list = (List<User>) pm.newQuery(query).execute();
			pm.close();
			if (list.isEmpty()){
				response.setContentType("text/html");
			//	response.getWriter().println("No existe el usuario que desea ingresar " + "<a href=\"/users/register?url?=+"+request.getParameter("url")+"\">Registrar</a>");
				response.sendRedirect(us.createLogoutURL(request.getRequestURI()+"?email="+user.getEmail()+"&&p=t"));
			} else{
				response.sendRedirect("/");
			}
		}
	}
}
