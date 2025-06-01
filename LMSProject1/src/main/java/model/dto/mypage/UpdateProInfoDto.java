package model.dto.mypage;

public class UpdateProInfoDto {
	private String professorId;
	private String professorEmail; 
    private String professorPhone;
    private String professorImg;
	public String getProfessorId() {
		return professorId;
	}
	public void setProfessorId(String professorId) {
		this.professorId = professorId;
	}
	public String getProfessorEmail() {
		return professorEmail;
	}
	public void setProfessorEmail(String professorEmail) {
		this.professorEmail = professorEmail;
	}
	public String getProfessorPhone() {
		return professorPhone;
	}
	public void setProfessorPhone(String professorPhone) {
		this.professorPhone = professorPhone;
	}
	public String getProfessorImg() {
		return professorImg;
	}
	public void setProfessorImg(String professorImg) {
		this.professorImg = professorImg;
	}
	@Override
	public String toString() {
		return "UpdateProInfoDto [professorId=" + professorId + ", professorEmail=" + professorEmail
				+ ", professorPhone=" + professorPhone + ", professorImg=" + professorImg + "]";
	}
    
    
}
