<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="path" value="${pageContext.request.contextPath}" scope="application" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>출석 관리</title>

<style>
    /* body에 직접적인 padding 제거 */
    body {
        margin: 0; /* 기본 margin 제거 */
    }
    /* content-wrapper 스타일 적용 */
    #content-wrapper {
    	padding-top: 20px;
        padding-left: 140px;
        padding-right: 0px;
         
        max-width: 1500px; /* 최대 너비 설정 (선택 사항) */
    }
    .card {
        margin-bottom: 20px; /* card의 하단 margin 유지 */
        width: 100%;
        
        /* margin: auto; */
 
    }
    .table { width: 100%; }
    .modal-body table { width: 100%; }
    .attendance-select { width: 120px; }
    .attendance-rate { font-weight: bold; color: #28a745; }
    .late-count { color: #ffca2c !important; font-weight: bold; }
    .absent-count { color: #dc3545 !important; font-weight: bold; }
    .modal-header .close {
        position: absolute;
        right: 25px; /* 약간 왼쪽으로 이동 */
        top: 25px; /* 약간 아래로 이동 */
        margin: -1rem -1rem -1rem auto;
    }
    @media (max-width: 768px) {
        #content-wrapper {
            padding-left: 10px; /* 작은 화면에서 여백 줄임 */
            padding-right: 10px; /* 작은 화면에서 여백 줄임 */
        }
        .table th, .table td { font-size: 14px; }
        .attendance-select { width: 100px; }
    }
</style>
</head>
<body>
<div id="content-wrapper">
	<h2 class="text-xl font-semibold mb-4">출석 관리</h2>
	<div class="card">
	    
	    <div class="flex items-center mb-4">
	        <input type="text" id="searchInput" class="border rounded p-2 mr-2" placeholder="강의명 또는 강의 ID 검색">
	        <button class="btn btn-primary" id="searchBtn">검색</button>
	        <div class="ml-4">
	            <label for="datePicker">날짜: </label>
	            <input type="date" id="datePicker" class="border rounded p-1" value="">
	        </div>
	    </div>
	    <table class="table">
	        <thead>
	            <tr>
	                <th>#</th>
	                <th>과목 ID</th>
	                <th>학기</th>
	                <th>학생수</th>
	                <th>강의명</th>
	                <th>관리</th>
	            </tr>
	        </thead>
	        <tbody id="courseList">
	            <c:forEach var="course" items="${courses}" varStatus="idx">
	            	<tr>
	            		<td>${idx.count}</td>
	            		<td>${course.course_id}</td>
	            		<td>${course.course_period}</td>
	            		<td>${course.course_current_enrollment}</td>
	            		<td>${course.course_name}</td>
	            		<td>
	           				<button class="btn btn-primary manage-btn" data-course-id="${course.course_id}">출석 관리</button>
	           			</td>
	           		</tr>
	            </c:forEach>
	        </tbody>
	    </table>
	</div>
	
	<!-- 모달 팝업 -->
	<div class="modal fade" id="attendanceModal" tabindex="-1" aria-labelledby="attendanceModalLabel" aria-hidden="true">
	    <div class="modal-dialog modal-lg">
	        <div class="modal-content">
	            <div class="modal-header">
	                <h5 class="modal-title" id="attendanceModalLabel">출석 관리</h5>
	                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	                    <span aria-hidden="true">×</span>
	                </button>
	            </div>
	            <div class="modal-body">
	                <p><strong>과목:</strong> <span id="modalCourseName"></span> (<span id="modalCourseId"></span>)</p>
	                <p><strong>날짜:</strong> <span id="modalDate"></span></p>
	                <p><strong>출석률:</strong> <span id="attendanceRate" class="attendance-rate">0%</span></p>
	                <table class="table">
	                    <thead>
	                        <tr>
	                            <th>#</th>
	                            <th>학번</th>
	                            <th>이름</th>
	                            <th>지각 횟수</th>
	                            <th>결석 횟수</th>
	                            <th>출석 상태</th>
	                        </tr>
	                    </thead>
	                    <tbody id="attendanceList">
	                        <!-- 동적 데이터 삽입 -->
	                    </tbody>
	                </table>
	            </div>
	            <div class="modal-footer">
	                <button class="btn btn-primary" id="bulkPresent">일괄 출석</button>
	                <button class="btn btn-primary" id="bulkAbsent">일괄 결석</button>
	                <button class="btn btn-primary" id="saveAttendance">저장</button>
	                <div id="saveMessage" class="text-success" style="display: none;">저장이 완료되었습니다. 강의목록으로 돌아갑니다.</div>
	            </div>
	        </div>
	    </div>
	</div>
</div>
<script>
	//강의당 수강생 목록
	var attendanceData = [];
	
	function createAttendanceRow(index, item) {  
	    return (
	        '<tr>' +
	        '<td data-attendance-id="'+ item.attendance_id +'">' + (index + 1) + '</td>' +
	        '<td>' + item.student_id + '</td>' +
	        '<td>' + item.student_name + '</td>' +
	        '<td class="late-count">' + item.attendance_late + '</td>' +
	        '<td class="absent-count">' + item.attendance_absent + '</td>' +
	        '<td>' +
	        '<select class="attendance-select form-control">' +
	        '<option value="present"' + (item.attendance_history_status === "출석" ? " selected" : "") + '>출석</option>' +
	        '<option value="absent"' + (item.attendance_history_status === "결석" ? " selected" : "") + '>결석</option>' +
	        '<option value="late"' + (item.attendance_history_status === "지각" ? " selected" : "") + '>지각</option>' +
	        '</select>' +
	        '</td>' +
	        '</tr>'
	    );
	}

	$(document).ready(function() {
		//오늘 날짜로 세팅
		var today = new Date();
		
	    var year = today.getFullYear();
	    var month = today.getMonth() + 1; 
	    var day = today.getDate();
	
	    month = month < 10 ? '0' + month : month;
	    day = day < 10 ? '0' + day : day;
	    
	    var formattedDate = year + '-' + month + '-' + day;
	
	    $('#datePicker').val(formattedDate);
		
	    // 검색 기능
	    $('#searchBtn').click(function() {
	        var searchTerm = $('#searchInput').val().toLowerCase();
	        $('#courseList tr').filter(function() {
	            $(this).toggle($(this).text().toLowerCase().indexOf(searchTerm) > -1);
	        });
	    });
	    
	 	// Enter 키로 검색 버튼 작동 추가
	    $('#searchInput').on('keypress', function(e) {
	        if (e.which === 13) {
	            e.preventDefault();
	            $('#searchBtn').click();
	        }
	    });
	
	    // 날짜 변경 시 모달 업데이트
	    $('#datePicker').change(function() {
	        var selectedDate = $(this).val();
	        $('#modalDate').text(selectedDate);
	    });
	
	    // 출석 관리 버튼 클릭
	    $('.manage-btn').click(function() {
	
	        var courseId = $(this).data('course-id');
	        var courseName = $(this).closest('tr').find('td:nth-child(3)').text();
	        $('#modalCourseId').text(courseId);
	        $('#modalCourseName').text(courseName);
	        $('#modalDate').text($('#datePicker').val());
	        $('#attendanceRate').text('0%');
	
	        var attendanceList = $('#attendanceList');
	        attendanceList.empty();
			var params = {
							courseId: courseId,
							attendanceDate: $("#datePicker").val(),
			}

	        $.ajax({
				url : "${path}/professor_support/attendance/getAttendance",
				type : "get",
				data : params,
				dataType : "json",
				success : function(data) {
					if (data.errorMsg) {
						alert(data.errorMsg);
						return;
					}
					attendanceData = data;
					// 서버에서 데이터를 받은 후 출석 목록을 생성
					$.each(attendanceData, function(index, item) {
					    attendanceList.append(createAttendanceRow(index, item));
					});
					updateAttendanceRate();
			        $('#attendanceModal').modal('show');
				},
				error : function(xhr, status, error) {
					console.error("Error:", xhr.responseText);
					alert("강의 상태변경 중 오류가 발생했습니다.");
				}
			});        
	    });
	
	    // 일괄 출석
	    $('#bulkPresent').click(function() {
	        $('#attendanceList .attendance-select').val('present').change();
	        updateAttendanceRate();
	    });
	
	    // 일괄 결석
	    $('#bulkAbsent').click(function() {
	        $('#attendanceList .attendance-select').val('absent').change();
	        updateAttendanceRate();
	    });
	
	    // 출석 상태 변경 시 출석률 업데이트
	    $('#attendanceList').on('change', '.attendance-select', function() {
	        updateAttendanceRate();
	    });
	
	    // 출석률 계산
	    function updateAttendanceRate() {
	        var total = $('#attendanceList tr').length;
	        var present = $('#attendanceList .attendance-select').filter(function() {
	            return $(this).val() === 'present';
	        }).length;
	        var rate = total > 0 ? ((present / total) * 100).toFixed(1) + '%' : '0%';
	        $('#attendanceRate').text(rate);
	    }
	
	    // 저장 버튼
	    $('#saveAttendance').click(function() {
	        var attendanceData = [];
	        
	        $('#attendanceList tr').each(function() {
	            var $row = $(this);
	            attendanceData.push({
					attendanceId: $row.find('td:eq(0)').data('attendance-id') || null,
	                studentId: $row.find('td:eq(1)').text(),
	                studentName: $row.find('td:eq(2)').text(),
	                attendanceStatus: $row.find('.attendance-select').val(),
	                courseId: $('#modalCourseId').text(),
	                attendanceDate: $('#modalDate').text()
	            });
	        });
	        console.log('attendanceData저장 데이터:', attendanceData);
	        
	        $.ajax({
				url : "${path}/professor_support/attendance/updateAttendance",
				type : "post",
				contentType: "application/json",
                data: JSON.stringify(attendanceData),
				dataType : "json",
				success : function(data) {
					if (data.errorMsg) {
						alert(data.errorMsg);
					} else {
						$('#saveMessage').show().delay(2000).fadeOut();
						setTimeout(function() {
						      location.reload(true);
						    }, 1000);
					}
				},
				error : function(xhr, status, error) {
					console.error("Error:", xhr.responseText);
					alert("출석부 수정 중 오류가 발생했습니다.");
				}
			});
	    });
	
	    // "X" 버튼 클릭 이벤트 강제 추가 (충돌 방지)
	    $('.close').on('click', function() {
	        $('#attendanceModal').modal('hide');
	    });
	});
</script>
</body>
</html>