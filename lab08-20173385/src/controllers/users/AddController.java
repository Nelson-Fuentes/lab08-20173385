package controllers.users;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import javax.jdo.PersistenceManager;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import com.google.appengine.repackaged.org.joda.time.DateTimeZone;
import com.google.appengine.repackaged.org.joda.time.LocalDateTime;
import controllers.PMF;
import models.Role;
import models.User;

public class AddController extends HttpServlet {
	public void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		if (AccessController.isPermited(req.getServletPath(), req, resp, this)){
			User log = LogController.getUser();
			req.setAttribute("log", log);
			boolean isLogged = LogController.isLogged();
			req.setAttribute("isLogged", isLogged);
			req.setAttribute("url", req.getRequestURI());
			LocalDateTime ldt = LocalDateTime.now(DateTimeZone.forID("America/Lima"));
			PersistenceManager pm = PMF.get().getPersistenceManager();
			String query = "select from " + Role.class.getName();
			List<Role> roles = (List<Role>)pm.newQuery(query).execute();
			req.setAttribute("roles", roles);
			req.setAttribute("date", ldt.toDate());
			pm.close();
			RequestDispatcher rd = this.getServletContext().getRequestDispatcher("/WEB-INF/Views/Users/add.jsp");
			rd.forward(req, resp);
		}
	}
	public void doPost(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException{
		PersistenceManager pm = PMF.get().getPersistenceManager();
		SimpleDateFormat date = new SimpleDateFormat("yyyy-MM-dd");
		try {
			String query = "select from " + User.class.getName()	+ " where correo == '"+request.getParameter("email")+"'";
			List<User> users = (List<User>)pm.newQuery(query).execute();
			if (users.isEmpty()){
				User user = new User(request.getParameter("name"), request.getParameter("apellido"),request.getParameter("email"), date.parse(request.getParameter("date")), Boolean.parseBoolean(request.getParameter("gender")), Long.parseLong(request.getParameter("role")));
				pm.makePersistent(user);
			}
		} catch (ParseException e) {
			response.getWriter().println(e.getMessage());
		} finally {
			pm.close();
			response.sendRedirect("/users");
		}
	}
}
