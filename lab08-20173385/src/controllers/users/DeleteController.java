package controllers.users;
import java.io.IOException;

import javax.jdo.PersistenceManager;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import controllers.PMF;
import models.User;
public class DeleteController extends HttpServlet {
	public void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		if (AccessController.isPermited(req.getServletPath(), req, resp, this)){
			PersistenceManager pm = PMF.get().getPersistenceManager();
			User user = pm.getObjectById(User.class, new Long(req.getParameter("id")).longValue());
			if (user!=null){
				pm.deletePersistent(user);
			}
			pm.close();
			resp.sendRedirect("/users");
		}
	}
}
