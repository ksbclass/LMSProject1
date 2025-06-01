package model.dao.mypage;

import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import config.MyBatisConnection;
import model.dto.mypage.FindIdDto;
import model.dto.mypage.FindPwDto;
import model.dto.mypage.LoginDto;
import model.dto.mypage.UpdateProInfoDto;
import model.dto.mypage.UpdateProPwDto;
import model.dto.mypage.UpdateStuInfoDto;
import model.dto.mypage.UpdateStuPwDto;

public class ProStuDao {

	public Map<String,String> login(String id ) {
		SqlSession conn = MyBatisConnection.getConnection();
		LoginDto loginDto = new LoginDto();
		loginDto.setProfessorId(id.toUpperCase());
		loginDto.setStudentId(id.toUpperCase());

		try {
			Map<String,String>  map = conn.selectOne("prostu.loginChk",loginDto);
			return map;
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		finally {
			MyBatisConnection.close(conn);
		}
		return null;
	}


	public String findId(String name , String email) {
		SqlSession conn = MyBatisConnection.getConnection();
		FindIdDto dto = new FindIdDto();
		dto.setProfessorEmail(email);
		dto.setProfessorName(name);
		dto.setStudentEmail(email);
		dto.setStudentName(name);

		try {
			String id = conn.selectOne("prostu.findId",dto);
			return id;	
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		finally {
			MyBatisConnection.close(conn);
		}
		return null;

	}

	public String findPw(String id , String email) {
		SqlSession connection = MyBatisConnection.getConnection();
		FindPwDto dto = new FindPwDto();
		dto.setProfessorEmail(email);
		dto.setProfessorId(id);
		dto.setStudentEmail(email);
		dto.setStudentId(id);
		try {
			return connection.selectOne("prostu.findPw",dto);
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		finally {
			MyBatisConnection.close(connection);
		}
		return null;
	}


	public boolean updatePw(String id, String cPw) {
		SqlSession connection = MyBatisConnection.getConnection();
		UpdateProPwDto pDto = new UpdateProPwDto();
		UpdateStuPwDto sDto = new UpdateStuPwDto();

		try {
			if(id.contains("p")) {
				pDto.setProfessorId(id);
				pDto.setProfessorNewPassword(cPw);
				if(connection.update("prostu.updateProPw",pDto)>0) {
					connection.commit();
					return true;
				}
			}
			else {
				sDto.setStudentId(id);
				sDto.setStudentNewPassword(cPw);
				if(connection.update("prostu.updateStuPw",sDto)>0) {
					connection.commit();
					return true;
				}
			}

		}
		catch (Exception e) {
			e.printStackTrace();
		}
		finally {
			MyBatisConnection.close(connection);
		}
		return false;
	}





	public String selectDeptName(String id) {
		SqlSession connection = MyBatisConnection.getConnection();
		try {
			return connection.selectOne("prostu.selectDeptName",id);
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		finally {
			MyBatisConnection.close(connection);
		}
		return null;

	}


	public static boolean userUpdate(String id,String img, String phone, String email) {
		SqlSession conn = MyBatisConnection.getConnection();

		try {
			if(id.toLowerCase().contains("p")) {
				UpdateProInfoDto dto = new UpdateProInfoDto();
				dto.setProfessorId(id);
				dto.setProfessorEmail(email);
				dto.setProfessorImg(img);
				dto.setProfessorPhone(phone);
				if(conn.update("prostu.updateProInfo",dto)>0) {
					conn.commit();
					return true;
				}
			}
			else {
				UpdateStuInfoDto dto = new UpdateStuInfoDto();
				dto.setStudentEmail(email);
				dto.setStudentId(id);
				dto.setStudentImg(img);
				dto.setStudentPhone(phone);
				if(conn.update("prostu.updateStuInfo",dto)>0) {
					conn.commit();
					return true;
				}
			}
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		finally {
			MyBatisConnection.close(conn);
		}
		return false;


	}


	public boolean updateTempPw(String tempPw, String id) {
		SqlSession connection = MyBatisConnection.getConnection();
		try {
			if(id.toLowerCase().contains("p")) {
				UpdateProPwDto dto = new UpdateProPwDto();
				dto.setProfessorId(id);
				dto.setProfessorNewPassword(tempPw);
				if(connection.update("professor.tempPw",dto)>0) {
					connection.commit();
					return true;
				}
				
			}
			else if(id.toLowerCase().contains("s")){
				UpdateStuPwDto dto = new UpdateStuPwDto();
				dto.setStudentId(id);
				dto.setStudentNewPassword(tempPw);
				if(connection.update("student.tempPw",dto)>0) {
					connection.commit();
					return true;
				}
			}
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		finally {
			MyBatisConnection.close(connection);
		}
		return false;
	}




}
