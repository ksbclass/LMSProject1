<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="path" value="${pageContext.request.contextPath}" scope="application" />

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>강의관리(교수지원)</title>
<style>
/* 모달 내부 스타일 */
.modal-body {
	font-family: 'Noto Sans KR', sans-serif;
	padding: 2rem;
}

.modal-body .form-group {
	margin-bottom: 1.5rem;
	display: flex;
	flex-direction: row;
	align-items: center;
	gap: 1rem;
}

.modal-body label {
	font-weight: bold;
	color: #333;
	width: 120px;
	flex-shrink: 0;
}

.modal-body input:not([disabled]), .modal-body select, .modal-body textarea
	{
	border: 2px solid #007bff;
	border-radius: 0.25rem;
	padding: 0.375rem 0.75rem;
	transition: border-color 0.3s ease, box-shadow 0.3s ease;
}

.modal-body input:not([disabled]):focus, .modal-body select:focus,
	.modal-body textarea:focus {
	border-color: #0056b3;
	box-shadow: 0 0 5px rgba(0, 123, 255, 0.3);
	outline: none;
}

.modal-body input[disabled] {
	background-color: #e9ecef;
	border: 1px solid #ced4da;
	color: #6c757d;
}

.modal-body .form-check-inline {
	margin-right: 0.5rem;
}

.modal-body .form-check-input:checked {
	background-color: #007bff;
	border-color: #007bff;
}

.modal-body .input-group {
	display: flex;
	align-items: center;
	gap: 0.5rem;
}

.modal-body select {
	width: 100px;
}

.modal-body input[type="text"] {
	width: 400px; /* 강의명 크기 증가 */
}

.modal-body input[type="number"] {
	width: 200px;
}

.modal-body textarea {
	width: 400px;
	resize: vertical;
}

.modal-footer {
	justify-content: flex-end;
	gap: 0.5rem;
	padding: 1rem 2rem;
}

.modal-footer .btn-custom {
	background-color: #dc3545;
	color: #ffffff;
	border: none;
}

.modal-footer .btn-custom:hover {
	background-color: #c82333;
}

.modal-dialog {
	max-width: 800px;
}
</style>
</head>
<body>
	<div class="container">
		<!-- 제목 및 검색 영역 -->
		<div class="d-flex justify-content-between align-items-center mb-4">
			<h2>
				<i class="bi bi-book me-2"></i> <a href="#"
					onclick="window.location.href = window.location.origin + window.location.pathname;">강의관리</a>
			</h2>
			<div class="d-flex align-items-center gap-2">
				<!-- 검색 -->
				<div class="search-bar">
					<input type="text" class="form-control form-control-sm"
						id="searchInput" placeholder="강의명 검색..." style="width: 200px;">
				</div>
				<button class="btn btn-primary btn-sm" id="searchBtn">
					<i class="bi bi-search"></i>
				</button>
			</div>
		</div>

		<div class="card">
			<div class="mb-3 text-end">
				<a href="${path}/professor_support/registCourse"
					class="btn btn-primary">새 강의 등록</a>
			</div>
			<table class="table table-hover">
				<thead>
					<tr>
						<th>강의명 <a href="#" class="sort-link" data-sort="courseName">
								<i class="bi bi-arrow-down-up ms-1"></i>
						</a>
						</th>
						<th>강의기간</th>
						<th>강의실</th>
						<th>전공여부</th>
						<th>강의시간</th>
						<th>수강인원</th>
						<th>학점 <a href="#" class="sort-link" data-sort="courseScore">
								<i class="bi bi-arrow-down-up ms-1"></i>
						</a>
						</th>
						<th>상태</th>
						<th>조회 및 수정</th>
						<th>삭제</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="course" items="${courses}" varStatus="status">
						<tr>
							<td>
							<span data-bs-toggle="tooltip" title="${course.coursePlan}"> 
								<c:out value="${course.courseName}" />
							</span>
							</td>
							<td>${course.coursePeriod}</td>
							<td>${course.courseTimeLoc}</td>
							<td><c:choose>
									<c:when
										test="${fn:toUpperCase(course.creditCategory) == 'MAJORREQUIRED'}">
                                        전공필수
                                    </c:when>
									<c:when
										test="${fn:toUpperCase(course.creditCategory) == 'MAJORELECTIVE'}">
                                        전공선택
                                    </c:when>
									<c:when
										test="${fn:toUpperCase(course.creditCategory) == 'LIBERALARTS'}">
                                        교양
                                    </c:when>
									<c:otherwise>
										<c:out value="${course.creditCategory}" />
									</c:otherwise>
								</c:choose></td>
							<td>
								${course.courseTimeYoil}/ ${course.courseTimeStart} - ${course.courseTimeEnd}
							</td>
							<td>
								${course.courseCurrentEnrollment}/${course.courseMaxCnt}
							</td>
							<td>${course.courseScore}</td>
							<td><span
								class="badge ${fn:toUpperCase(course.courseStatus) == 'OPEN' ? 'text-bg-success' : 'text-bg-danger'}">
									${fn:toUpperCase(course.courseStatus) == 'OPEN' ? '개설됨' : '종료됨'}
							</span></td>
							<td>
								<button class="btn btn-primary btn-sm view-details"
									data-course-id="${course.courseId}" 
									data-courseTime-id="${course.courseTimeId}" 
									data-bs-toggle="modal"
									data-bs-target="#courseModal">
									<i class="bi bi-pencil"></i> 조회 및 수정
								</button>
							</td>
							<td>
								<a href="${path}/professor_support/manage/deleteCourseInfo
								?page=${pagination.currentPage}&search=${param.search}&courseId=${course.courseId}"
								class="btn btn-secondary btn-sm" onclick="return confirm('정말 삭제하시겠습니까?');"> 
								<i class="bi bi-trash"></i> 삭제
								</a> 
								<c:if test="${fn:toUpperCase(course.courseStatus) == 'OPEN'}">
									<button class="btn btn-danger btn-sm ms-1 chg-course"
										data-course-id="${course.courseId}"
										data-course-status="${fn:toUpperCase(course.courseStatus)}"
										data-course-enrollment="${course.courseCurrentEnrollment}">
										<i class="bi bi-x-circle"></i> 종료
									</button>
								</c:if> <c:if test="${fn:toUpperCase(course.courseStatus) == 'CLOSED'}">
									<button class="btn btn-success btn-sm ms-1 chg-course"
										data-course-id="${course.courseId}"
										data-course-status="${fn:toUpperCase(course.courseStatus)}"
										data-course-enrollment="${course.courseCurrentEnrollment}">
										<i class="bi bi-check-circle"></i> 개설
									</button>
								</c:if>
							</td>
						</tr>
					</c:forEach>
					<c:if test="${empty courses}">
						<tr>
							<td colspan="9" class="text-center">등록된 강의가 없습니다.</td>
						</tr>
					</c:if>
				</tbody>
			</table>

			<!-- Pagination -->
			<nav aria-label="Page navigation">
				<ul class="pagination">
					<c:if test="${pagination.currentPage > 1}">
						<li class="page-item"><a class="page-link"
							href="${path}/professor_support/manage/manageCourse?page=${pagination.currentPage - 1}&search=${param.search}">이전</a>
						</li>
					</c:if>
					<c:forEach begin="1" end="${pagination.totalPages}" var="page">
						<li
							class="page-item ${pagination.currentPage == page ? 'active' : ''}">
							<a class="page-link"
							href="${path}/professor_support/manage/manageCourse?page=${page}&search=${param.search}">${page}</a>
						</li>
					</c:forEach>
					<c:if test="${pagination.currentPage < pagination.totalPages}">
						<li class="page-item"><a class="page-link"
							href="${path}/professor_support/manage/manageCourse?page=${pagination.currentPage + 1}&search=${param.search}">다음</a>
						</li>
					</c:if>
				</ul>
			</nav>
		</div>
	</div>

	<!-- 상세 보기 및 수정 모달 -->
	<div class="modal fade" id="courseModal" tabindex="-1"
		aria-labelledby="courseModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="courseModalLabel">강의 상세 정보 및 수정</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<form id="updateCourseForm"
					action="${path}/professor_support/manage/updateCourseInfo" method="post">
					<div class="modal-body">
						<div class="form-group">
							<label for="modalCourseId">강의ID:</label> 
							<input type="text" id="modalCourseId" name="courseId" readonly>
							<input type="hidden" id="modalCourseTimeId" name="courseTimeId">
						</div>
						<div class="form-group">
							<label for="modalCourseName">강의명:</label> 
							<input type="text" id="modalCourseName" name="courseName">
						</div>
						<div class="form-group">
							<label>강의기간:</label>
							<div class="input-group">
								<div class="form-check form-check-inline">
									<input class="form-check-input" type="radio"
										name="coursePeriod" id="period1" value="1학기"> 
										<label class="form-check-label" for="period1">1학기</label>
								</div>
								<div class="form-check form-check-inline">
									<input class="form-check-input" type="radio"
										name="coursePeriod" id="period2" value="2학기"> 
										<label class="form-check-label" for="period2">2학기</label>
								</div>
							</div>
						</div>
						<div class="form-group">
							<label for="modalcourseTimeLoc">강의실:</label> <input type="text"
								id="modalcourseTimeLoc" name="courseTimeLoc">
						</div>
						<div class="form-group">
							<label>전공여부:</label>
							<div class="input-group">
								<div class="form-check form-check-inline">
									<input class="form-check-input" type="radio"
										name="creditCategory" id="majorRequired" value="MajorRequired">
									<label class="form-check-label" for="majorRequired">전공필수</label>
								</div>
								<div class="form-check form-check-inline">
									<input class="form-check-input" type="radio"
										name="creditCategory" id="majorElective" value="MajorElective">
									<label class="form-check-label" for="majorElective">전공선택</label>
								</div>
								<div class="form-check form-check-inline">
									<input class="form-check-input" type="radio"
										name="creditCategory" id="liberalArts" value="LiberalArts">
									<label class="form-check-label" for="liberalArts">교양</label>
								</div>
							</div>
						</div>
						<div class="form-group">
							<label>강의시간:</label>
							<div class="input-group">
								<select id="modalCourseDay" name="courseTimeYoil" class="form-select">
									<option value="월">월</option>
									<option value="화">화</option>
									<option value="수">수</option>
									<option value="목">목</option>
									<option value="금">금</option>
								</select> 
								<select id="modalStartHour" class="form-select">
									<c:forEach begin="9" end="17" var="h">
										<option value="${h}">${h}</option>
									</c:forEach>
								</select> <span>00분 ~</span> 
								<select id="modalEndHour" class="form-select">
									<c:forEach begin="9" end="17" var="h">
										<option value="${h}">${h}</option>
									</c:forEach>
								</select> <span>50분</span>
							</div>
						</div>
						<div class="form-group">
							<label for="modalMaxCnt">정원수:</label> 
							<input type="number" id="modalMaxCnt" name="courseMaxCnt">
						</div>
						<div class="form-group">
							<label for="modalCourseScore">학점:</label> 
							<input type="number" id="modalCourseScore" name="courseScore" min="1" max="6">
						</div>
						<div class="form-group">
							<label for="modalCoursePlan">강의 계획:</label>
							<textarea id="modalCoursePlan" name="coursePlan" rows="3"></textarea>
						</div>
					</div>
					<div class="modal-footer">
						<button type="submit" class="btn btn-custom">수정</button>
						<button type="button" class="btn btn-secondary"
							data-bs-dismiss="modal">닫기</button>
					</div>
				</form>
			</div>
		</div>
	</div>
	</div>

	<script>
		// 검색 관련 함수
		function handleSearch() {
			var keyword = $("#searchInput").val();
			var page = "${pagination.currentPage}";
			var baseUrl = "${path}/professor_support/manage/manageCourse";
			var searchUrl = keyword ? baseUrl + "?page=" + page + "&search="
					+ encodeURIComponent(keyword) : baseUrl + "?page=" + page;
			window.location.href = searchUrl;
		}

		// 정렬 관련 함수
		function handleSort(event) {
			event.preventDefault();
			var sortField = $(this).attr("data-sort"); // courseName or courseScore
			var currentUrl = new URL(window.location.href);
			var currentSort = currentUrl.searchParams.get("sortDirection") || "";
			var newSort = currentSort === sortField ? sortField + "-desc"
					: sortField;

			currentUrl.searchParams.set("sortDirection", newSort);
			currentUrl.searchParams.set("page", "${pagination.currentPage}");
			currentUrl.searchParams.set("search", "${param.search}");
			window.location.href = currentUrl.toString();
		}

		// 모달 데이터 채우기 함수
		function populateModal(event, courseId, courseTimeId) {
			var row = $(event.currentTarget).closest("tr");
			var courseName = row.find("td:eq(0)").text().trim();
			var coursePeriod = row.find("td:eq(1)").text().trim();
			var courseTimeLoc = row.find("td:eq(2)").text().trim();
			var creditCategory = row.find("td:eq(3)").text().trim();
			var courseTime = row.find("td:eq(4)").text().trim();
			var maxCnt = row.find("td:eq(5)").text().trim();
			var courseScore = row.find("td:eq(6)").text().trim();
			var coursePlan = row.find("td:eq(0) span")
				.attr("data-bs-original-title")|| "없음";

			// 전공여부 매핑
			var creditCategoryMap = {
				"전공필수" : "MajorRequired",
				"전공선택" : "MajorElective",
				"교양" : "LiberalArts"
			};
			creditCategory = creditCategoryMap[creditCategory]
					|| creditCategory;

			// 요일과 시간 분리 (예: "목 / 22:00:00 - 22:50:00")
			var parts = courseTime.split("/");
			var courseYoil = parts[0].trim(); // "목"
			var timeRange = parts[1].trim(); // "22:00:00 - 22:50:00"
			var timeParts = timeRange.split("-");
			var startHour = parseInt(timeParts[0].trim().split(":")[0]); // 22
			var endHour = parseInt(timeParts[1].trim().split(":")[0]); // 22

			// 수강인원에서 정원만 추출 (예: "20 / 30" -> "30")
			var maxCntIdx = maxCnt.indexOf("/");
			maxCnt = maxCnt.substring(maxCntIdx + 1).trim();

			// 모달 필드 채우기
			$("#modalCourseId").val(courseId);
			$("#modalCourseName").val(courseName);
			$("input[name='coursePeriod'][value='" + coursePeriod + "']")
					.prop("checked", true);
			$("#modalcourseTimeLoc").val(courseTimeLoc);
			$("input[name='creditCategory'][value='" + creditCategory + "']")
					.prop("checked", true);
			$("#modalCourseDay").val(courseYoil);
			$("#modalStartHour").val(startHour);
			$("#modalEndHour").val(endHour);
			$("#modalMaxCnt").val(maxCnt);
			$("#modalCourseScore").val(courseScore);
			$("#modalCoursePlan").val(coursePlan);
			$("#modalCourseTimeId").val(courseTimeId);
		}

		// 강의 상태 변경 처리 함수
		function handleCourseStatusChange(event) {

			var courseEnrollment = $(event.currentTarget).attr("data-course-enrollment");
			var courseId = $(event.currentTarget).attr("data-course-id");
			var courseStatus = $(event.currentTarget).attr("data-course-status");
			
			if (courseEnrollment > 0) {
				alert("수강생이 있는 강의는 종료 불가합니다.");
				return;
			} 
	
			if (confirm("강의를 개설or종료 하시겠습니까?")) {
				$.ajax({
					url : "${path}/professor_support/manage/changeCourse",
					type : "POST",
					data : {
						courseId : courseId,
						courseStatus : courseStatus
					},
					dataType : "json",
					success : function(response) {
						if (response.result === "success") {
							window.location.reload();
						} else if (response.result === "fail") {
							alert(response.errorMsg);
						}
					},
					error : function(xhr, status, error) {
						console.error("Error:", error);
						alert("강의 상태변경 중 오류가 발생했습니다.");
					}
				});
			}
		}

		// 폼 제출 전 데이터 처리 함수
		function handleFormSubmit() {
			var startHour = $("#modalStartHour").val();
			var endHour = $("#modalEndHour").val();

			// 2자리로 패딩 (예: "9" -> "09")
			startHour = ("0" + startHour).slice(-2);
			endHour = ("0" + endHour).slice(-2);

			// 폼에 hidden 필드로 시간 데이터 추가
			$("<input>").attr({
				type : "hidden",
				name : "courseTimeStart",
				value : startHour + ":00:00"
			}).appendTo("#updateCourseForm");
			$("<input>").attr({
				type : "hidden",
				name : "courseTimeEnd",
				value : endHour + ":50:00"
			}).appendTo("#updateCourseForm");
			
			// 현재페이지정보 전달
			$("<input>").attr({
				type : "hidden",
				name : "page",
				value : "${pagination.currentPage}"
			}).appendTo("#updateCourseForm");
			
			$("<input>").attr({
				type : "hidden",
				name : "search",
				value : "${param.search}"
			}).appendTo("#updateCourseForm");
		}

		// 이벤트 바인딩
		$(document).ready(function() {
			if ("${errorMsg}") {
				alert("강의수정실패");
			}
			
			// 검색 버튼 및 Enter 키 이벤트
			$("#searchBtn").click(handleSearch);
			$("#searchInput").keypress(function(e) {
				if (e.which === 13) { // Enter 키
					handleSearch();
				}
			});

			// 정렬 링크 이벤트
			$(".sort-link").click(handleSort);

			// 모달 데이터 채우기 이벤트
			$(".view-details").click(function(event) {
				var courseId = $(this).attr("data-course-id");
				var courseTimeId = $(this).attr("data-courseTime-id");
				populateModal(event, courseId, courseTimeId);
			});

			// 상태 변경 이벤트
			$(".chg-course").click(function(event) {
				handleCourseStatusChange(event);
			});

			// 폼 제출 이벤트
			$("#updateCourseForm").submit(handleFormSubmit);

			// 툴팁 활성화
			$("[data-bs-toggle='tooltip']").tooltip();
		});
	</script>
</body>
</html>