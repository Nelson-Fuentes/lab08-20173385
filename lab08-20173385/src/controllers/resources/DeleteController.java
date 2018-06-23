package controllers.resources;
import java.io.IOException;
import javax.jdo.PersistenceManager;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import controllers.PMF;
import controllers.users.AccessController;
import controllers.users.LogController;
import models.Resource;
import models.Access;
import java.util.*;
public class DeleteController extends HttpServlet {
	public void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		if (AccessController.isPermited(req.getServletPath(), req, resp, this)){
			PersistenceManager pm = PMF.get().getPersistenceManager();
			Resource resource = pm.getObjectById(Resource.class, new Long(req.getParameter("id")).longValue());
			if (resource!=null){
				String query = "SELECT FROM "+ Access.class.getName()+ " where idResource == " + req.getParameter("id");
				List<Access> access = (List<Access>)pm.newQuery(query).execute();
				for (Access ac: access){
					pm.deletePersistent(ac);
				}
				pm.deletePersistent(resource);
			}
			pm.close();
			resp.sendRedirect("/resources");
		}
	}
}
