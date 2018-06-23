package controllers.users;

import com.google.appengine.api.users.UserService;
import com.google.appengine.api.users.UserServiceFactory;

import controllers.PMF;
import javax.servlet.http.HttpServletResponse;
import javax.jdo.PersistenceManager;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import models.User;
import java.util.List;

public class LogController {
	private static final String INVITADO = "in@vita.do";
	public static boolean isLogged (){
		UserService us = UserServiceFactory.getUserService();
		com.google.appengine.api.users.User user = UserServiceFactory.getUserService().getCurrentUser();
		return !(user==null);
	}
	public static User getUser(){
		String email="";
		UserService us = UserServiceFactory.getUserService();
		com.google.appengine.api.users.User user = UserServiceFactory.getUserService().getCurrentUser();
		if (user==null){
			email = INVITADO;
		} else {
			email = user.getEmail();
		}
		String query = "select from " + User.class.getName()	+ " where correo == '"+email+"'";
		PersistenceManager pm = PMF.get().getPersistenceManager();
		List <User> users = (List<User>)pm.newQuery(query).execute();
		if (users.isEmpty()){
			query = "select from " + User.class.getName()	+ " where correo == '"+INVITADO+"'";
			users = (List<User>)pm.newQuery(query).execute();
			pm.close();
			return users.get(0);
		} else{
			pm.close();
			return users.get(0);
		}
	}
}
