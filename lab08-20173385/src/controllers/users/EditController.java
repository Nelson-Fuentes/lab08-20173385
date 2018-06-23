package controllers.users;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
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

public class EditController extends HttpServlet {
	public void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		if (AccessController.isPermited(req.getServletPath(), req, resp, this)){
			User log = LogController.getUser();
			req.setAttribute("log", log);
			boolean isLogged = LogController.isLogged();
			req.setAttribute("isLogged", isLogged);
			req.setAttribute("url", req.getRequestURI());
			PersistenceManager pm = PMF.get().getPersistenceManager();
			LocalDateTime ldt = LocalDateTime.now(DateTimeZone.forID("America/Lima"));
			req.setAttribute("date", ldt.toDate());
			String query = "select from " + Role.class.getName();
			List<Role> roles = (List<Role>)pm.newQuery(query).execute();
			req.setAttribute("roles", roles);
			User user = pm.getObjectById(User.class, Long.parseLong(req.getParameter("id")));
			pm.close();
			req.setAttribute("user", user);
			RequestDispatcher rd = this.getServletContext().getRequestDispatcher("/WEB-INF/Views/Users/edit.jsp");
			rd.forward(req, resp);
		}
	}
	public void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		PersistenceManager pm = PMF.get().getPersistenceManager();
		SimpleDateFormat date = new SimpleDateFormat("yyyy-MM-dd");
		User user = pm.getObjectById(User.class, Long.parseLong(req.getParameter("id")));
		user.setName(req.getParameter("name"));
		user.setApellido(req.getParameter("apellido"));
		try {
			user.setBirth(date.parse(req.getParameter("date")));
		} catch (ParseException e) {
			e.printStackTrace();
		}
		user.setIdRol(Long.parseLong(req.getParameter("role")));
		user.setGender(Boolean.parseBoolean(req.getParameter("gender")));
		pm.close();
		resp.sendRedirect("/users/view?id="+req.getParameter("id"));
	}
}
