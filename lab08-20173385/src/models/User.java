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
public class User {
	@PrimaryKey
	@Persistent(valueStrategy = IdGeneratorStrategy.IDENTITY) private Long id;
	@Persistent private String name;
	@Persistent private String apellido;
	@Persistent private String correo;
	@Persistent private Date birth;
	@Persistent private boolean gender;
	@Persistent private boolean estatus;
	@Persistent private Date made;
	@Persistent private long idRol;
	public User(String name, String apellido, String correo, Date birth, boolean gender, long idRol) {
		this.name=name;
		this.apellido=apellido;
		this.correo = correo;
		this.birth = birth;
		this.gender = gender;
		this.estatus=true;
		LocalDateTime ldt = LocalDateTime.now(DateTimeZone.forID("America/Lima"));
		made=ldt.toDate();
		this.idRol=idRol;
	}
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public String getCorreo() {
		return correo;
	}
	public void setCorreo(String correo) {
		this.correo = correo;
	}
	public Date getBirth() {
		return birth;
	}
	public void setBirth(Date birth) {
		this.birth = birth;
	}
	public boolean isGender() {
		return gender;
	}
	public void setGender(boolean gender) {
		this.gender = gender;
	}
	public boolean isEstatus() {
		return estatus;
	}
	public void setEstatus(boolean estatus) {
		this.estatus = estatus;
	}
	public Date getMade() {
		return made;
	}
	public void setMade(Date made) {
		this.made = made;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getApellido() {
		return apellido;
	}
	public void setApellido(String apellido) {
		this.apellido = apellido;
	}
	public long getIdRol() {
		return idRol;
	}
	public void setIdRol(long idRol) {
		this.idRol = idRol;
	}
	public String getRol(){
		PersistenceManager pm = PMF.get().getPersistenceManager();
		Role role = pm.getObjectById(Role.class, idRol);
		pm.close();
		return role.getName();
	}
	public boolean isAdministrador(){
		return this.getRol().equalsIgnoreCase("Administrador");
	}
}
