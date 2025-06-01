<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="path" value="${pageContext.request.contextPath}" scope="application" />

<!doctype html>
<html lang="ko">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>학습지원(수강신청)</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <style>
        /* Noto Sans KR 폰트 로드 */
        @import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700&display=swap');

        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }

        .card {
            background: white;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            padding: 50px;
            margin-bottom: 20px;
        }

        /* 테이블 스타일 */
        .table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
        }

        .table th, .table td {
            border: 1px solid #e2e8f0;
            padding: 10px;
            text-align: left;
        }

        .table th {
            background: #edf2f7;
            font-weight: 600;
        }

        /* 페이징 스타일 */
        .pagination button {
            padding: 8px 12px;
            margin: 0 4px;
            border: 1px solid #e2e8f0;
            border-radius: 4px;
            background: #fff;
            color: #3182ce;
            cursor: pointer;
        }

        .pagination button.active {
            background: #3182ce;
            color: white;
            border-color: #3182ce;
        }

        .pagination button:disabled {
            color: #a0aec0;
            cursor: not-allowed;
        }

        /* 모달 스타일 */
        .modal-content {
            border-radius: 8px;
            padding: 20px;
            font-family: 'Noto Sans KR', Arial, sans-serif !important;
            background: #fff;
        }

        .modal-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-bottom: 1px solid #e2e8f0;
            padding: 10px 20px;
        }

        .modal-title {
            font-size: 1.5rem;
            font-weight: 600;
            color: #333;
        }

        .modal-header .btn-close {
            padding: 0;
            margin: 0;
            font-size: 1.25rem;
            opacity: 0.7;
            background: none;
            border: none;
            cursor: pointer;
        }

        .modal-header .btn-close:hover {
            opacity: 1;
        }

        .modal-body {
            padding: 20px;
            max-height: 60vh;
            overflow-y: auto;
        }

        /* Summernote HTML 스타일 */
        .modal-body #modalCoursePlan {
            font-size: 0.9rem;
            line-height: 1.5;
            color: #333;
            background: #f8fafc;
            padding: 15px;
            border-radius: 4px;
        }

        .modal-body #modalCoursePlan p,
        .modal-body #modalCoursePlan div {
            margin-bottom: 1rem;
        }

        .modal-body #modalCoursePlan img {
            max-width: 100%;
            height: auto;
            border-radius: 4px;
        }

        .modal-footer {
            border-top: 1px solid #e2e8f0;
            padding: 10px 20px;
        }

        /* 반응형 모달 */
        @media (max-width: 768px) {
            .modal-content {
                margin: 10px;
                padding: 15px;
            }
            .modal-body {
                max-height: 50vh;
            }
            .modal-body #modalCoursePlan {
                font-size: 0.85rem;
                padding: 10px;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="card">
            <h2 class="mb-4 text-xl font-semibold">수강신청</h2>

            <!-- 검색 폼 -->
            <form id="searchForm" class="mb-4">
                <div class="row g-3">
                    <div class="col-md-6">
                        <label for="collegeSelect" class="form-label">대학구분</label>
                        <select name="college" id="collegeSelect" class="form-select" onchange="updateDepartments()">
                            <option value="">전체</option>
                        </select>
                    </div>
                    <div class="col-md-6">
                        <label for="deptSelect" class="form-label">학과</label>
                        <select name="deptId" id="deptSelect" class="form-select">
                            <option value="">소속대학을 먼저 선택해주세요.</option>
                        </select>
                    </div>
                    <div class="col-md-6">
                        <label for="courseId" class="form-label">교과목번호</label>
                        <input type="text" name="courseId" id="courseId" class="form-control" placeholder="교과목번호 입력">
                    </div>
                    <div class="col-md-6">
                        <label for="courseName" class="form-label">교과목명</label>
                        <input type="text" name="courseName" id="courseName" class="form-control" placeholder="교과목명 입력">
                    </div>
                    <div class="col-md-12">
                        <button type="button" id="searchButton" class="btn btn-primary mt-3">검색</button>
                    </div>
                </div>
            </form>

            <!-- 개설 과목 목록 -->
            <p>
                <strong>전체 개설과목:</strong> <span id="courseCount">0</span>건
            </p>
            <div class="table-responsive">
                <table class="table table-bordered" id="courseTable">
                    <thead>
                        <tr>
                            <th>상태</th>
                            <th>이수구분</th>
                            <th>교과목번호</th>
                            <th>교과목명</th>
                            <th>교수명</th>
                            <th>학점</th>
                            <th>시간</th>
                            <th>정원</th>
                            <th>강의계획서</th>
                        </tr>
                    </thead>
                    <tbody id="courseBody">
                        <!-- AJAX로 동적으로 채움 -->
                    </tbody>
                </table>
            </div>

            <!-- 페이징 네비게이션 -->
            <div class="pagination d-flex justify-content-center mt-4" id="pagination">
                <!-- 동적으로 페이지 버튼 생성 -->
            </div>

            <!-- 신청 내역 -->
            <h3 class="mt-4 text-lg font-semibold">신청내역</h3>
            <div class="table-responsive">
                <table class="table table-bordered" id="registrationTable">
                    <thead>
                        <tr>
                            <th>이수구분</th>
                            <th>교과목번호</th>
                            <th>교과목명</th>
                            <th>학점</th>
                            <th>담당교수</th>
                            <th>시간</th>
                            <th>삭제</th>
                        </tr>
                    </thead>
                    <tbody id="registrationBody">
                        <!-- AJAX로 동적으로 채움 -->
                    </tbody>
                </table>
            </div>

            <!-- 상세보기 모달 -->
            <div class="modal fade" id="coursePlanModal" tabindex="-1" aria-labelledby="coursePlanModalLabel" aria-hidden="true">
                <div class="modal-dialog modal-lg">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="coursePlanModalLabel">강의 상세</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <p><strong>교과목번호:</strong> <span id="modalCourseId"></span></p>
                            <p><strong>교과목명:</strong> <span id="modalCourseName"></span></p>
                            <p><strong>교수명:</strong> <span id="modalProfessorName"></span></p>
                            <p><strong>강의계획서 내용:</strong></p>
                            <div id="modalCoursePlan" class="border p-4 rounded bg-light"></div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        // 페이징 처리 준비
        var currentPage = 1;
        var pageSize = 10;
		
        // 로드되는 강의목록 시간 배열
        var timeSlots = [];
        
        $(document).ready(function() {
            // 대학 목록 로드
            $.ajax({
                url: "${path}/learning_support/colleges",
                type: "get",
                dataType: "json",
                success: function(data) {
                    var $collegeSelect = $("#collegeSelect");
                    $collegeSelect.empty();
                    $collegeSelect.append('<option value="">전체</option>');
                    $.each(data, function(i, item) {
                        $collegeSelect.append($("<option>").val(item).text(item));
                    });
                },
                error: function(e) {
                    console.error("College load error:", e);
                    alert("SERVER_ERROR: " + e.status);
                }
            });

            // 초기 강의 목록 및 신청 내역 로드
            loadCourses();
            loadRegistrations();

            // 검색 버튼 클릭 이벤트
            $("#searchButton").on("click", function() {
                currentPage = 1;
                loadCourses();
            });

            $("#courseName").on("keydown", function(e) {
                if (e.keyCode == 13) {
                    $("#searchButton").click();
                    e.preventDefault();
                }
            });

            // 추가 버튼 클릭 이벤트
            $(document).on("click", ".add-course", function() {
            	// 신청하는 강의시간과 신청한강의들의 시간 비교
            	var courseTimeSlot = $(this).closest("tr").find("td:eq(6)").text();
            	for(var i=0; i<timeSlots.length; i++) {
					if (timeSlots[i] == courseTimeSlot) {
						alert('기존수강내역에 같은요일,시간의 강의가 존재합니다.');
						return;
					}	
            	}
                var courseId = $(this).closest("form").find("input[name='courseId']").val();
                var professorId = $(this).closest("form").find("input[name='professorId']").val();
                addCourse(courseId, professorId);
            });

            // 삭제 버튼 클릭 이벤트
            $(document).on("click", ".delete-registration", function() {
                var registrationId = $(this).closest("form").find("input[name='registrationId']").val();
                var courseId = $(this).closest("tr").find("td:eq(1)").text();
                deleteCourse(registrationId, courseId);
            });

            // 상세보기 클릭 이벤트
            $(document).on("click", ".detail-course", function() {
                var courseId = $(this).data("course-id");
                var courseName = $(this).data("course-name");
                var professorName = $(this).data("professor-name");
                var coursePlan = $(this).data("course-plan");

                // 모달에 데이터 채우기
                $("#modalCourseId").text(courseId || "N/A");
                $("#modalCourseName").text(courseName || "N/A");
                $("#modalProfessorName").text(professorName || "N/A");
                $("#modalCoursePlan").html(coursePlan || "강의계획서 정보가 없습니다.");

                // 모달 열기
                var modal = new bootstrap.Modal(document.getElementById("coursePlanModal"));
                modal.show();
            });
        });

        // 학과 동적 업데이트 함수
        function updateDepartments() {
            var college = $('#collegeSelect').val();
            $.ajax({
                url: '${path}/learning_support/departments',
                method: 'GET',
                data: { college: college },
                dataType: "json",
                success: function(data) {
                    var $deptSelect = $('#deptSelect');
                    $deptSelect.empty();
                    $deptSelect.append('<option value="">전체</option>');
                    $.each(data, function(idx, dept) {
                        $deptSelect.append($("<option>").val(dept.deptId).text(dept.deptName));
                    });
                },
                error: function(xhr) {
                    console.error("Department load error:", xhr);
                    alert('학과 목록을 불러오지 못했습니다: ' + xhr.responseText);
                }
            });
        }

        // 강의 목록 로드
        function loadCourses() {
            var params = {
                college: $('#collegeSelect').val(),
                deptId: $("#deptSelect").val(),
                courseId: $("#courseId").val(),
                courseName: $("#courseName").val(),
                currentPage: currentPage,
                itemsPerPage: pageSize,
            };
            $.ajax({
                url: "${path}/learning_support/searchCourse",
                type: "get",
                data: params,
                dataType: "json",
                success: function(data) {
                    var courses = data.courses || [];
                    var pagination = data.pagination || { currentPage: 1, totalPages: 1 };
                    var $body = $("#courseBody");
                    $body.empty();
                    
                    $.each(courses, function(i, course) {
                        var row = $("<tr>").append(
                            $("<td>").append(
                                $("<form>").append(
                                    $("<input>").attr({type: "hidden", name: "courseId", value: course.courseId}),
                                    $("<input>").attr({type: "hidden", name: "professorId", value: course.professorId}),
                                    $("<button>").attr({type: "button"}).addClass("btn btn-primary add-course").text("추가")
                                )
                            ),
                            $("<td>").text(course.creditCategory || "-"),
                            $("<td>").text(course.courseId || "-"),
                            $("<td>").text(course.courseName || "-"),
                            $("<td>").text(course.professorName || "-"),
                            $("<td>").text(course.courseScore || "-"),
                            $("<td>").text(course.timeSlot || "-"),
                            $("<td>").text((course.courseCurrentEnrollment || 0) + ' / ' + (course.courseMaxCnt || 0)),
                            $("<td>").append(
                                course.coursePlan
                                    ? $("<button>")
                                        .attr({
                                            type: "button",
                                            "data-course-id": course.courseId,
                                            "data-course-name": course.courseName,
                                            "data-professor-name": course.professorName,
                                            "data-course-plan": course.coursePlan
                                        })
                                        .addClass("btn btn-secondary detail-course")
                                        .text("상세보기")
                                    : $("<span>").text("-")
                            )
                        );
                        $body.append(row);
                    });
                    $("#courseCount").text(pagination.totalRows);
                    renderPagination(pagination.currentPage, pagination.totalPages);
                    
                },
                error: function(xhr) {
                    console.error("Course load error:", xhr);
                    alert("강의 목록을 불러오지 못했습니다: " + xhr.responseText);
                }
            });
        }

        // 페이징 처리
        function renderPagination(current, total) {
            var paging = $("#pagination");
            paging.empty();
            paging.append(
                $('<button>').text('이전').prop('disabled', current == 1).on('click', function() {
                    if (current > 1) {
                        currentPage = current - 1;
                        loadCourses();
                    }
                })
            );
            for (var i = 1; i <= total; i++) {
                (function(page) {
                    paging.append(
                        $('<button>').text(page).toggleClass('active', page == current).on('click', function() {
                            currentPage = page;
                            loadCourses();
                        })
                    );
                })(i);
            }
            paging.append(
                $('<button>').text('다음').prop('disabled', current == total).on('click', function() {
                    if (current < total) {
                        currentPage = current + 1;
                        loadCourses();
                    }
                })
            );
        }

        // 과목 추가
        function addCourse(courseId, professorId) {
            $.ajax({
                url: "${path}/learning_support/addCourse",
                type: "get",
                data: { courseId: courseId, professorId: professorId },
                dataType: "json",
                success: function(data) {
                    if (data.errorMsg && data.errorMsg.indexOf('full') !== -1) {
                        alert('해당강의는 정원이 초과하였습니다.');
                    }
                    loadRegistrations();
                    loadCourses();
                },
                error: function(xhr) {
                    console.error("Add course error:", xhr);
                    alert("과목 추가에 실패했습니다: " + xhr.responseText);
                }
            });
        }

        // 신청 내역 로드
        function loadRegistrations() {
            $.ajax({
                url: "${path}/learning_support/searchRegistrationCourses",
                type: "get",
                dataType: "json",
                success: function(data) {
                	timeSlots = [];
                    var $body = $("#registrationBody");
                    $body.empty();
                    $.each(data, function(i, reg) {
                    	timeSlots.push(reg.timeSlot);
                        var row = $("<tr>").append(
                            $("<td>").text(reg.creditCategory || "-"),
                            $("<td>").text(reg.courseId || "-"),
                            $("<td>").text(reg.courseName || "-"),
                            $("<td>").text(reg.courseScore || "-"),
                            $("<td>").text(reg.professorName || "-"),
                            $("<td>").text(reg.timeSlot || "-"),
                            $("<td>").append(
                                $("<form>").append(
                                    $("<input>").attr({type: "hidden", name: "registrationId", value: reg.registrationId}),
                                    $("<button>").attr({type: "button"}).addClass("btn btn-secondary delete-registration text-danger").text("삭제")
                                )
                            )
                        );
                        $body.append(row);
                    });
                },
                error: function(xhr) {
                    console.error("Registration load error:", xhr);
                    alert("신청 내역을 불러오지 못했습니다: " + xhr.responseText);
                }
            });
        }

        // 신청 삭제
        function deleteCourse(registrationId, courseId) {
            $.ajax({
                url: "${path}/learning_support/deleteCourse",
                type: "get",
                data: { registrationId: registrationId, courseId: courseId },
                dataType: "json",
                success: function(data) {
                    loadRegistrations();
                    loadCourses();
                },
                error: function(xhr) {
                    console.error("Delete course error:", xhr);
                    alert("과목 삭제에 실패했습니다: " + xhr.responseText);
                }
            });
        }
    </script>
</body>
</html>