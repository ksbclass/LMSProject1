<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="path" value="${pageContext.request.contextPath}"
	scope="application" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>성적조회</title>
<script src="https://cdn.tailwindcss.com"></script>
<style>
body {
	font-family: 'Noto Sans KR', sans-serif;
	background-color: #f7fafc;
}

.container {
	max-width: 1200px;
	margin: 0 auto;
	padding: 20px;
}

.card {
	background: white;
	border-radius: 8px;
	box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
	padding: 20px;
	margin-bottom: 20px;
}

.table {
	width: 100%;
	border-collapse: separate;
	border-spacing: 0;
	margin-top: 10px;
	border-radius: 8px;
	overflow: hidden;
}

.table th, .table td {
	border: 1px solid #e2e8f0;
	padding: 12px;
	text-align: left;
}

.table th {
	background: #edf2f7;
	font-weight: 600;
	color: #2d3748;
}

.table tbody tr {
	transition: background 0.2s ease, transform 0.2s ease;
}

.table tbody tr:nth-child(even) {
	background: #f7fafc;
}

.table tbody tr:hover {
	background: #e6f0fa;
	transform: translateY(-1px);
}

.table tbody td {
	font-size: 0.9rem;
	color: #4a5568;
}

.table tbody td.score-grade {
	font-weight: 600;
}

.table tbody td.score-grade.A-plus,
.table tbody td.score-grade.A {
	color: #38a169;
}

.table tbody td.score-grade.B-plus,
.table tbody td.score-grade.B {
	color: #3182ce;
}

.table tbody td.score-grade.C-plus,
.table tbody td.score-grade.C,
.table tbody td.score-grade.D-plus,
.table tbody td.score-grade.D,
.table tbody td.score-grade.F {
	color: #e53e3e;
}

.btn {
	padding: 8px 16px;
	border-radius: 4px;
	transition: background 0.2s;
}

.btn-primary {
	background: #3182ce;
	color: white;
}

.btn-primary:hover {
	background: #2b6cb0;
}

.btn-secondary {
	background: #e2e8f0;
	color: #4a5568;
}

.btn-secondary:hover {
	background: #cbd5e0;
}

.summary-card {
	background: linear-gradient(135deg, #ffffff 0%, #f7fafc 100%);
	border-radius: 12px;
	box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
	padding: 20px;
	margin-top: 20px;
	display: flex;
	justify-content: space-between;
	align-items: center;
	gap: 20px;
	transition: transform 0.2s ease;
}

.summary-card:hover {
	transform: translateY(-2px);
}

.summary-item {
	flex: 1;
	text-align: center;
}

.summary-label {
	font-size: 0.9rem;
	color: #718096;
	margin-bottom: 8px;
}

.summary-value {
	font-size: 1.5rem;
	font-weight: 700;
	color: #2d3748;
}

.summary-value.total-credits {
	color: #3182ce;
}

.summary-value.gpa {
	color: #38a169;
}

@media (max-width: 640px) {
	.summary-card {
		flex-direction: column;
	}
	.summary-item {
		width: 100%;
	}
	.table th, .table td {
		font-size: 0.85rem;
		padding: 8px;
	}
}
</style>
</head>
<body>
    <!-- 성적 확인 -->
    <div class="card">
        <h2 class="text-xl font-semibold mb-4">성적 확인</h2>
        <form method="get" action="">
            <div class="flex items-center mb-4">
                <select name="semester" class="border rounded p-2 mr-2" onchange="this.form.submit()">
                    <option value="all" ${param.semester == 'all' || empty param.semester ? 'selected' : ''}>전체</option>
                    <option value="1학기" ${param.semester == '1학기' ? 'selected' : ''}>1학기</option>
                    <option value="2학기" ${param.semester == '2학기' ? 'selected' : ''}>2학기</option>
                </select>
                <button type="submit" class="btn btn-primary">조회</button>
            </div>
        </form>
        <table class="table">
            <thead>
                <tr>
                    <th>#</th>
                    <th>학기(coursePeriod)</th>
                    <th>과목번호(courseId)</th>
                    <th>과목명(courseName)</th>
                    <th>담당교수(professorName)</th>
                    <th>학점(courseScore)</th>
                    <th>중간점수(scoreMid)</th>
                    <th>기말점수(scoreFinal)</th>
                    <th>취득 점수(scoreTotal)</th>
                    <th>평가(scoreGrade)</th>
                </tr>
            </thead>
            <tbody>
                <c:set var="totalCourseScore" value="0" />
                <c:set var="totalGradePoints" value="0" />
                <c:set var="courseCount" value="0" />
                <c:forEach items="${score}" var="sc" varStatus="a">
                    <!-- 학기 필터링 -->
                    <c:if test="${param.semester == 'all' || empty param.semester || sc.coursePeriod == param.semester}">
                        <tr>
                            <td>${a.count}</td>
                            <td>${sc.coursePeriod}</td>
                            <td>${sc.courseId}</td>
                            <td>${sc.courseName}</td>
                            <td>${sc.professorName}</td>
                            <td>${sc.courseScore}</td>
                            <td>${sc.scoreMid}</td>
                            <td>${sc.scoreFinal}</td>
                            <td>${sc.scoreTotal}</td>
                            <td class="score-grade ${fn:replace(sc.scoreGrade, '+', '-plus')}">${sc.scoreGrade}</td>
                        </tr>
                        <!-- 총 학점 합산 -->
                        <c:set var="totalCourseScore" value="${totalCourseScore + sc.courseScore}" />
                        <!-- 학점 등급을 숫자로 변환 -->
                        <c:choose>
                            <c:when test="${sc.scoreGrade == 'A+'}">
                                <c:set var="gradePoint" value="4.5" />
                            </c:when>
                            <c:when test="${sc.scoreGrade == 'A'}">
                                <c:set var="gradePoint" value="4.0" />
                            </c:when>
                            <c:when test="${sc.scoreGrade == 'B+'}">
                                <c:set var="gradePoint" value="3.5" />
                            </c:when>
                            <c:when test="${sc.scoreGrade == 'B'}">
                                <c:set var="gradePoint" value="3.0" />
                            </c:when>
                            <c:when test="${sc.scoreGrade == 'C+'}">
                                <c:set var="gradePoint" value="2.5" />
                            </c:when>
                            <c:when test="${sc.scoreGrade == 'C'}">
                                <c:set var="gradePoint" value="2.0" />
                            </c:when>                 
                            <c:when test="${sc.scoreGrade == 'F'}">
                                <c:set var="gradePoint" value="0.0" />
                            </c:when>
                            <c:otherwise>
                                <c:set var="gradePoint" value="0.0" />
                            </c:otherwise>
                        </c:choose>
                        <c:set var="totalGradePoints" value="${totalGradePoints + gradePoint}" />
                        <c:set var="courseCount" value="${courseCount + 1}" />
                    </c:if>
                </c:forEach>
            </tbody>
        </table>
        <!-- 요약 섹션 -->
        <div class="summary-card">
            <div class="summary-item">
                <div class="summary-label">총 이수 학점</div>
                <div class="summary-value total-credits">${totalCourseScore}</div>
            </div>
            <div class="summary-item">
                <div class="summary-label">평균 학점 (GPA)</div>
                <div class="summary-value gpa">
                    <fmt:formatNumber value="${courseCount > 0 ? totalGradePoints / courseCount : 0}" pattern="0.00" />
                </div>
            </div>
        </div>
    </div>
</body>
</html>