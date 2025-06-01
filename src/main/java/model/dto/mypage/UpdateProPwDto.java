package model.dto.mypage;

public class UpdateProPwDto {
	private String professorId;
	private String professorPassword;
	private String professorNewPassword;
	
	public String getProfessorId() {
		return professorId;
	}
	public void setProfessorId(String professorId) {
		this.professorId = professorId;
	}
	public String getProfessorPassword() {
		return professorPassword;
	}
	public void setProfessorPassword(String professorPassword) {
		this.professorPassword = professorPassword;
	}
	public String getProfessorNewPassword() {
		return professorNewPassword;
	}
	public void setProfessorNewPassword(String professorNewPassword) {
		this.professorNewPassword = professorNewPassword;
	}
	@Override
	public String toString() {
		return "UpdateProPwDto [professorId=" + professorId + ", professorPassword=" + professorPassword
				+ ", professorNewPassword=" + professorNewPassword + "]";
	}
	
	

}
