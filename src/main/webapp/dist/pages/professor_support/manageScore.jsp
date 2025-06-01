<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="path" value="${pageContext.request.contextPath}" scope="application" />

<!DOCTYPE html>
<html lang="ko">
<head>
    <!-- 문자 인코딩 및 뷰포트 설정 -->
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- 페이지 제목 -->
    <title>교수지원(성적관리)</title>
    <!-- 스타일 정의 -->
    <style>
        /* 전체 페이지 스타일 */
        body {
            background-color: #f5f7fa; /* 배경색 설정 */
            font-family: 'Noto Sans KR', sans-serif; /* 폰트 설정 */
        }
        /* 컨테이너 스타일 */
        .container {
            max-width: 1200px; /* 최대 너비 */
            margin-top: 30px; /* 상단 여백 */
        }
        /* 카드 스타일 */
        .card {
            border-radius: 10px; /* 테두리 둥글게 */
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); /* 그림자 효과 */
            margin-bottom: 20px; /* 하단 여백 */
        }
        /* 카드 헤더 스타일 */
        .card-header {
            background-color: #007bff; /* 배경색 */
            color: white; /* 글자색 */
            border-radius: 10px 10px 0 0; /* 상단 테두리 둥글게 */
            padding: 15px; /* 내부 여백 */
        }
        /* 커스텀 버튼 스타일 */
        .btn-custom {
            background-color: #007bff; /* 배경색 */
            color: white; /* 글자색 */
            border-radius: 5px; /* 테두리 둥글게 */
            padding: 8px 15px; /* 내부 여백 */
            transition: background-color 0.3s; /* 배경색 전환 애니메이션 */
        }
        .btn-custom:hover {
            background-color: #0056b3; /* 호버 시 배경색 */
        }
        /* 커스텀 링크 버튼 스타일 */
        .btn-link-custom {
            color: #007bff; /* 글자색 */
            text-decoration: none; /* 밑줄 제거 */
        }
        .btn-link-custom:hover {
            color: #0056b3; /* 호버 시 글자색 */
            text-decoration: underline; /* 호버 시 밑줄 추가 */
        }
        /* 테이블 헤더 스타일 */
        .table-custom th {
            background-color: #e9ecef; /* 배경색 */
            font-weight: 600; /* 글자 두께 */
            cursor: pointer; /* 커서 포인터 */
        }
        .table-custom th:hover {
            background-color: #dee2e6; /* 호버 시 배경색 */
        }
        /* 성적 상세 섹션 스타일 */
        .grade-details {
            margin-top: 20px; /* 상단 여백 */
            opacity: 0; /* 초기 투명도 */
            transition: opacity 0.3s ease; /* 투명도 전환 애니메이션 */
        }
        .grade-details.show {
            opacity: 1; /* 표시 시 투명도 */
        }
        /* 로딩 스피너 스타일 */
        .loading-spinner {
            display: none; /* 초기 숨김 */
            text-align: center; /* 중앙 정렬 */
            padding: 20px; /* 내부 여백 */
        }
        .loading-spinner i {
            font-size: 24px; /* 아이콘 크기 */
            color: #007bff; /* 아이콘 색상 */
            animation: spin 1s linear infinite; /* 회전 애니메이션 */
        }
        @keyframes spin {
            100% { transform: rotate(360deg); } /* 360도 회전 */
        }
        /* 알림 메시지 스타일 */
        .alert-custom {
            display: none; /* 초기 숨김 */
            margin-top: 10px; /* 상단 여백 */
        }
        /* 점수 입력 필드 스타일 */
        .editable-score {
            width: 60px; /* 너비 */
            padding: 2px; /* 내부 여백 */
            border: 1px solid #ced4da; /* 테두리 */
            border-radius: 4px; /* 테두리 둥글게 */
        }
        .editable-score:focus {
            outline: none; /* 포커스 아웃라인 제거 */
            border-color: #007bff; /* 포커스 시 테두리 색상 */
            box-shadow: 0 0 5px rgba(0, 123, 255, 0.3); /* 포커스 시 그림자 */
        }
        /* 반응형 디자인 */
        @media (max-width: 768px) {
            .table-custom th, .table-custom td {
                font-size: 14px; /* 작은 화면에서 글자 크기 */
            }
            .btn-custom {
                padding: 6px 10px; /* 작은 화면에서 버튼 패딩 */
            }
        }
        /* "강의 등록" 제목 스타일 */
        .page-title {
            font-size: 1.75rem; /* 글씨 크기 조정 */
            font-weight: bold; /* 글씨 두께 */
        }
        .page-title i {
            font-size: 1.5rem; /* 아이콘 크기 조정 */
            vertical-align: middle; /* 수직 정렬 */
        }
        /* 교수 및 학과 정보 스타일 */
        .professor-info {
            background-color: #ffffff; /* 배경색 */
            border: 1px solid #e0e0e0; /* 테두리 */
            border-radius: 8px; /* 테두리 둥글게 */
            padding: 15px; /* 내부 여백 */
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05); /* 그림자 효과 */
            display: inline-block; /* 인라인 블록 */
        }
        .professor-info h4 {
            margin: 0; /* 기본 여백 제거 */
            font-size: 1.25rem; /* 글씨 크기 */
            color: #333; /* 글자색 */
            font-weight: 500; /* 글씨 두께 */
        }
        .professor-info h4 span {
            color: #007bff; /* 강조 색상 */
            font-weight: 600; /* 글씨 두께 */
        }
    </style>
</head>
<body>
    <!-- 메인 컨테이너 -->
    <div class="container">
        <!-- 페이지 제목 -->
        <div class="d-flex justify-content-between align-items-center mb-4 position-relative">
            <h1 class="page-title"><i class="bi bi-bookmark-plus me-2"></i>성적관리</h1>
        </div>
        <!-- 교수 및 학과 정보 -->
        <div class="mb-4">
            <div class="professor-info">
                <h4>교수: <span>${professorName}</span> | 학과: <span>${deptName}</span></h4>
            </div>
        </div>

        <!-- 과목 목록 카드 -->
        <div class="card">
            <div class="card-header">
                <h5 class="mb-0">과목 목록</h5>
            </div>
            <div class="card-body">
                <!-- 과목 검색 입력 필드 -->
                <div class="mb-3">
                    <input type="text" id="courseSearch" class="form-control" placeholder="과목명 검색">
                </div>
                <!-- 과목 로딩 스피너 -->
                <div class="loading-spinner" id="courseLoading">
                    <i class="fas fa-spinner"></i> 로딩 중...
                </div>
                <!-- 과목 목록 테이블 -->
                <table class="table table-striped table-hover table-custom" id="courseTable">
                    <thead>
                        <tr>
                            <th data-sort="courseName">과목명 <i class="fas fa-sort"></i></th>
                            <th data-sort="courseId">과목 코드 <i class="fas fa-sort"></i></th>
                            <th data-sort="courseCurrentnrollment">수강생 수 <i class="fas fa-sort"></i></th>
                            <th>성적 관리</th>
                        </tr>
                    </thead>
                    <tbody id="courseList">
                        
                    </tbody>
                </table>
            </div>
        </div>

        <!-- 성적 관리 상세 섹션 -->
        <div class="card grade-details" id="gradeDetails">
            <div class="card-header">
                <h5 class="mb-0" id="courseTitle"></h5>
            </div>
            <div class="card-body">
                <!-- 성적 로딩 스피너 -->
                <div class="loading-spinner" id="gradeLoading">
                    <i class="fas fa-spinner"></i> 로딩 중...
                </div>
                <!-- 성적 목록 테이블 -->
                <table class="table table-striped table-hover table-custom" id="gradeTable">
                    <thead>
                        <tr>
                            <th data-sort="name">이름 <i class="fas fa-sort"></i></th>
                            <th data-sort="studentId">학번 <i class="fas fa-sort"></i></th>
                            <th data-sort="major">전공 <i class="fas fa-sort"></i></th>
                            <th data-sort="midterm">중간고사 <i class="fas fa-sort"></i></th>
                            <th data-sort="finalExam">기말고사 <i class="fas fa-sort"></i></th>
                            <th data-sort="total">총점 <i class="fas fa-sort"></i></th>
                            <th data-sort="grade">등급 <i class="fas fa-sort"></i></th>
                            <th>이의신청</th>
                        </tr>
                    </thead>
                    <tbody id="gradeList">
                    </tbody>
                </table>
                <!-- 알림 메시지 -->
                <div class="alert alert-custom" id="alertMessage"></div>
                <!-- 등록 버튼 -->
                <div class="d-flex justify-content-end mt-3">
                    <button class="btn btn-custom" id="saveGrades">등록</button>
                </div>
            </div>
        </div>
    </div>

    <script>
        $(document).ready(function() {
			// 과목 목록
            var coursesData = []; 
            // 페이지 로드시 해당교수의 과목 로드
            $.ajax({
                url: '${path}/professor_support/score/getCoursesInfo', 
                type: 'get',
                dataType: 'json',
                success: function (data) {
                	coursesData = data; 
                 	// 초기 과목 목록 렌더링
                    renderCourses(coursesData);
                },
                error: function (xhr, status, error) {
                    console.error('과목 목록 데이터를 가져오는 데 실패했습니다.', error);
                }
            }); 

            // 성적 데이터 배열
            var gradesData = [];
			
            // 해당과목 수강생들 데이터
            var gradeDetails = {};
            
            // 과목 목록 렌더링 함수
            function renderCourses(data) {
                var courseList = $('#courseList');
                courseList.empty();
                // 데이터 순회하며 테이블 행 추가
                $.each(data, function(index, course) {
                    courseList.append(
                        '<tr>' +
                        '<td>' + course.course_name + '</td>' +
                        '<td>' + course.course_id + '</td>' +
                        '<td>' + course.course_current_enrollment + '</td>' +
                        '<td> <a href="#" class="btn-link-custom manage-link" data-course-id="' 
                        + course.course_id + '" data-course-name="' + course.course_name + '">관리</a></td>' +
                        '</tr>'
                    );
                });
				
                // 관리 링크 클릭 이벤트 바인딩
                $('.manage-link').click(function(e) {
                    e.preventDefault();
                    var courseId = $(this).data('course-id');
                    var courseName = $(this).data('course-name');
                    
                    $.ajax({
                        url: '${path}/professor_support/score/getScoreInfo', 
                        type: 'get',
                        data: {
							   courseId: courseId,
                        	   courseName: courseName,
						},
                        dataType: 'json',
                        success: function (data) {
                        	gradeDetails = data; 
                        	loadGradeDetails(courseId); // 성적 상세 정보 로드
                        },
                        error: function (xhr, status, error) {
                            console.error('과목 목록 데이터를 가져오는 데 실패했습니다.', error);
                        }
                    });
                    
                });
            }

            // 과목 검색 기능
            $('#courseSearch').on('input', function() {
                var searchTerm = $(this).val().toLowerCase(); // 검색어 소문자 변환
                var filteredCourses = [];
                // 검색어와 일치하는 과목 필터링
                for (var i = 0; i < coursesData.length; i++) {
                    if (coursesData[i].course_name.toLowerCase().indexOf(searchTerm) !== -1) {
                        filteredCourses.push(coursesData[i]);
                    }
                }
                renderCourses(filteredCourses); // 필터링된 과목 렌dering
            })
           

            // 과목 목록 정렬 기능
            $('#courseTable th[data-sort]').click(function() {
                var sortKey = $(this).data('sort'); // 정렬 기준 키
                var isAscending = $(this).hasClass('sort-asc'); // 오름차순 여부
                // 데이터 정렬
                coursesData.sort(function(a, b) {
                    var valA = a[sortKey], valB = b[sortKey];
                    if (typeof valA === 'string') valA = valA.toLowerCase();
                    if (typeof valB === 'string') valB = valB.toLowerCase();
                    return isAscending ? (valA > valB ? -1 : 1) : (valA < valB ? -1 : 1);
                });
                $(this).toggleClass('sort-asc').siblings().removeClass('sort-asc');
                renderCourses(coursesData); // 정렬된 데이터 렌더링
            });

            // 성적 상세 정보 로드 함수
            function loadGradeDetails(courseId) {
				
                $('#gradeDetails').removeClass('show'); // 상세 섹션 숨김
                $('#gradeLoading').show(); // 로딩 스피너 표시
                $('#gradeList').empty(); // 기존 목록 비우기
                var data = gradeDetails[courseId]; // 과목 데이터 가져오기
                
                if (data) {
                    gradesData = data.grades; // 성적 데이터 저장
                    
                    // 과목 제목 업데이트
                    var currentYear = new Date().getFullYear();
					$('#courseTitle').text('과목: ' + data.courseName + ' (' + currentYear + '-' + (data.coursePeriod ? data.coursePeriod : '') + ') | 교수:' + "${professorName}");
                    var gradeList = $('#gradeList');
                    gradeList.empty();
                    
                    // 성적 데이터 순회하며 테이블 행 추가
                    for (var i = 0; i < gradesData.length; i++) {
                        var grade = gradesData[i];

                        gradeList.append(
                            '<tr data-student-id="' + grade.studentId + '" data-course-id="' + courseId + '">' +
                            '<td>' + grade.studentName + '</td>' +
                            '<td>' + grade.studentId + '</td>' +
                            '<td>' + grade.deptName + '</td>' +
                            '<td><input type="number" class="editable-score midterm-score" value="' + grade.scoreMid + '" data-index="' + i + '"></td>' +
                            '<td><input type="number" class="editable-score final-exam-score" value="' + grade.scoreFinal + '" data-index="' + i + '"></td>' +
                            '<td class="total-score" id="total-score">' + grade.scoreTotal + '</td>' +
                            '<td class="grade" id="grade">' + grade.scoreGrade + '</td>' +
                            '<td><a href="#" class="btn-link-custom">[보기]</a></td>' +
                            '</tr>'
                        );
                    }
                    $('#gradeLoading').hide(); // 로딩 스피너 숨김
                    $('#gradeDetails').addClass('show'); // 상세 섹션 표시
                    bindScoreEvents(); // 점수 입력 이벤트 바인딩
                } else {
                    $('#gradeLoading').hide();
                    $('#gradeList').html('<tr><td colspan="8" class="text-center">성적 데이터를 불러오지 못했습니다.</td></tr>');
                }
            }

            // 점수 입력 이벤트 바인딩 함수
            function bindScoreEvents() {
                $('.editable-score').on('input', function() {

                    var index = $(this).data('index'); // 데이터 인덱스
                    var midterm = parseInt($('.midterm-score[data-index="' + index + '"]').val()) || 0; // 중간고사 점수
                    var finalExam = parseInt($('.final-exam-score[data-index="' + index + '"]').val()) || 0; // 기말고사 점수
                    var total = midterm + finalExam; // 총점 계산
                    
                    $(this).closest('tr').find('.total-score').text(total); // 총점 업데이트
                    gradesData[index].midterm = midterm; // 데이터 업데이트
                    gradesData[index].finalExam = finalExam;
                    gradesData[index].total = total;
                    
                    // 등급 계산
                    var grade = 'F';
                    if (total >= 180) grade = 'A+';
                    else if (total >= 160) grade = 'A';
                    else if (total >= 140) grade = 'B+';
                    else if (total >= 120) grade = 'B';
                    else if (total >= 100) grade = 'C+';
                    else if (total >= 90) grade = 'C';
                    $(this).closest('tr').find('.grade').text(grade); // 등급 업데이트
                    gradesData[index].grade = grade;
                });
            }

            // 성적 목록 정렬 기능
            $('#gradeTable th[data-sort]').click(function() {
				
            	if (confirm('정렬시 등록안된 성적입력정보는 삭제됩니다. 실행하시겠습니까?')) {
	                var sortKey = $(this).data('sort'); // 정렬 기준 컬럼이름
	                var isAscending = $(this).hasClass('sort-asc'); // 오름차순 여부
	                
	                // 데이터 정렬
	                gradesData.sort(function(a, b) {
	                    var valA = a[sortKey]; 
	                    var valB = b[sortKey];
	                    
	                    if (typeof valA === 'string') valA = valA.toLowerCase();
	                    if (typeof valB === 'string') valB = valB.toLowerCase();
	                    
	                    return isAscending ? (valA > valB ? -1 : 1) : (valA < valB ? -1 : 1);
	                });
	                $(this).toggleClass('sort-asc').siblings().removeClass('sort-asc');
	                $('#gradeList').empty();
	                
	                // 정렬된 데이터 렌더링
	                for (var i = 0; i < gradesData.length; i++) {
	                    var grade = gradesData[i];
	                    
	                    $('#gradeList').append(
	                        '<tr data-student-id="' + grade.studentId + '" data-course-id="' + courseId + '">' +
	                        '<td>' + grade.studentName + '</td>' +
	                        '<td>' + grade.studentId + '</td>' +
	                        '<td>' + grade.deptName + '</td>' +
	                        '<td><input type="number" class="editable-score midterm-score" value="' + grade.scoreMid + '" data-index="' + i + '"></td>' +
	                        '<td><input type="number" class="editable-score final-exam-score" value="' + grade.scoreFinal + '" data-index="' + i + '"></td>' +
	                        '<td class="total-score">' + grade.scoreTotal + '</td>' +
	                        '<td class="grade">' + grade.scoreGrade + '</td>' +
	                        '<td><a href="#" class="btn-link-custom">[보기]</a></td>' +
	                        '</tr>'
	                    );
	                }
	                bindScoreEvents(); // 이벤트 재바인딩
            	} else {
					return false;
            	}
            });

            // 등록 버튼 클릭
            $('#saveGrades').click(function() {
                var alertMessage = $('#alertMessage');
                alertMessage.removeClass('alert-success alert-danger').hide();
                
             	// 각 학생들의 studentId,courseId 받아서 
                // score테이블에 scoreMid, scoreFinal,scoreTotal,scoreGrade 업데이트
                var params = [];
                
                $("#gradeList tr[data-student-id]").each(function() {
					console.log('this: ', $(this));
                	var studentId = $(this).attr("data-student-id");
                	var courseId = $(this).attr("data-course-id");
                	var scoreMid = $(this).find("td .midterm-score").val();
                	var scoreFinal = $(this).find("td .final-exam-score").val();
                	var scoreTotal = $(this).find("td.total-score").text();
                	var scoreGrade = $(this).find("td.grade").text();
                	
                	params.push({
						studentId: studentId,
						courseId: courseId,
						scoreMid: scoreMid,
						scoreFinal: scoreFinal,
						scoreTotal: scoreTotal,
						scoreGrade: scoreGrade,
                	});
                	
                });
				console.log('params: ', params);
                $.ajax({
            	url: '${path}/professor_support/score/updateScore', 
                type: 'post',
                contentType: "application/json",
                data: JSON.stringify(params),
                dataType: 'json',
                success: function (data) {
                	alertMessage.addClass('alert-success').text('성적이 성공적으로 등록되었습니다.').show();
                },
                error: function (xhr, status, error) {
                    alert('성적 수정작업에 실패했습니다.', error);
                }
            	});                
            });  
        });
        
    </script>
</body>
</html>