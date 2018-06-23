package models;

import java.util.Date;

import javax.jdo.PersistenceManager;
import javax.jdo.annotations.IdGeneratorStrategy;
import javax.jdo.annotations.IdentityType;
import javax.jdo.annotations.PersistenceCapable;
import javax.jdo.annotations.Persistent;
import javax.jdo.annotations.PrimaryKey;

import com.google.appengine.repackaged.org.joda.time.DateTimeZone;
import com.google.appengine.repackaged.org.joda.time.LocalDateTime;

import controllers.PMF;

@PersistenceCapable(identityType = IdentityType.APPLICATION)
public class Access {
	@PrimaryKey
	@Persistent(valueStrategy = IdGeneratorStrategy.IDENTITY) private Long id;
	@Persistent private long idRole;
	@Persistent private long idResource;
	@Persistent private boolean status;
	@Persistent private Date made;
	public Access(long idRole, long idResource, boolean status) {
		this.status=status;
		this.idRole = idRole;
		this.idResource = idResource;
		LocalDateTime ldt = LocalDateTime.now(DateTimeZone.forID("America/Lima"));
		made=ldt.toDate();
	}
	public boolean isStatus() {
		return status;
	}
	public void setStatus(boolean status) {
		this.status = status;
	}
	public Long getId() {
		return id;
	}
	public long getIdRole() {
		return idRole;
	}
	public long getIdResource() {
		return idResource;
	}
	public Date getMade() {
		return made;
	}
	public String getRol(){
		PersistenceManager pm = PMF.get().getPersistenceManager();
		Role role = pm.getObjectById(Role.class, idRole);
		pm.close();
		return role.getName();
	}
	public String getResource(){
		PersistenceManager pm = PMF.get().getPersistenceManager();
		Resource rscr = pm.getObjectById(Resource.class, idResource);
		pm.close();
		return rscr.getUrl();
	}
}
