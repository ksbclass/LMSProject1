<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="path" value="${pageContext.request.contextPath}" scope="application" />

<%
int imageCount = 15;
int randomImageNumber = (int)(Math.random() * imageCount) + 1;
pageContext.setAttribute("randomImageNumber", randomImageNumber);
%>

<!doctype html>
<html lang="en">
<head>
<title>메인화면</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
<style>
/* 기본 배경 스타일 */
body {
    margin: 0;
    min-height: 100vh;
    background-color: #f0f0f0;
    position: relative;
}

body::before {
    content: '';
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background-image: url('${path}/dist/assets/picture/backWon${randomImageNumber}.jpg');
    /*background-image: url('${path}/dist/assets/picture/back.jpg');*/
    background-size: 510px 900px;
    background-position: 100% 25%;
    background-repeat: no-repeat;
    background-attachment: fixed;
    filter: brightness(0.7);
    z-index: -1;
}

/* .app-content 스타일 */
.app-wrapper .app-content {
    margin-top: 50px !important; /* 400px -> 350px로 줄여 더 위로 올림 */
    margin-left: 5px !important; /* 기존 50px -> 5px로 줄여 왼쪽으로 이동 */
}

.container {
    margin-top: 0px; /* 10px -> 0px로 줄여 더 위로 올림 */
    margin-left: -10px; /* 살짝 왼쪽으로 이동 */
}
/* 카드 크기 맞춤 */
.card.card-warning.card-outline {
    min-height: 380px; /* 최소 높이 설정으로 높이 맞춤 */
    
}
/* list-group-item 높이 조정 */
.card.card-warning.card-outline .list-group-item {
    padding: 15px 20px; /* 상하 15px, 좌우 20px로 패딩 증가 */
    min-height: 60px; /* 최소 높이 설정으로 항목 높이 키움 */
    display: flex; /* Flexbox로 내부 콘텐츠 정렬 */
    align-items: center; /* 수직 중앙 정렬 */
    justify-content: space-between; /* 제목과 날짜 사이 간격 조정 */
}
/* 반응형 설정 */
/* 
@media (max-width: 768px) {
    body {
        background-size: 600px auto;
        background-position: 55% 15%;
    }
    .app-wrapper .app-content {
        margin-top: 300px !important; 
        margin-left: 5px !important; 
    }
    .container {
        margin-top: 0px;
        margin-left: -5px; 
    }
}

@media (min-width: 769px) and (max-width: 1200px) {
    body {
        background-size: 700px auto;
        background-position: 55% 20%;
    }
    .app-wrapper .app-content {
        margin-top: 330px !important; 
        margin-left: 5px !important; 
    }
    .container {
        margin-top: 0px;
        margin-left: -8px;
    }
}

@media (min-width: 1201px) {
    body {
        background-size: 800px auto;
        background-position: 55% 25%;
    }
    .app-wrapper .app-content {
        margin-top: 350px !important;
        margin-left: 5px !important;
    }
    .container {
        margin-top: 0px;
        margin-left: -10px;
    }
} */ 
</style>
</head>
<body class="layout-fixed sidebar-expand-lg bg-body-tertiary">
    <div class="app-wrapper">
        <div class="app-content">
            <div class="container">
                <div class="row">
                    <div class="col-md-6">
                        <div class="card card-primary card-outline">
                            <div class="card-header d-flex justify-content-between align-items-center">
                                <h5 class="card-title m-0">
                                    환영합니다,
                                    <c:if test="${not empty sessionScope.m}">
                                        <c:set var="user" value="${sessionScope.m}" />
                                        <strong>
                                            <c:choose>
                                                <c:when test="${user['class'].simpleName eq 'Student' and not empty user.studentName}">
                                                    ${user.studentName}님
                                                </c:when>
                                                <c:when test="${user['class'].simpleName eq 'Professor' and not empty user.professorName}">
                                                    ${user.professorName}님
                                                </c:when>
                                            </c:choose>
                                        </strong>
                                    </c:if>
                                </h5>
                            </div>
                            <div class="card-body">
                                <p>
                                    <strong>역할:</strong>
                                    <c:if test="${not empty sessionScope.m}">
                                        <c:choose>
                                            <c:when test="${user['class'].simpleName eq 'Student' and not empty user.studentName}">
                                                학생
                                            </c:when>
                                            <c:when test="${user['class'].simpleName eq 'Professor' and not empty user.professorName}">
                                                교수
                                            </c:when>
                                        </c:choose>
                                    </c:if>
                                </p>
                                <p><strong>현재 학기:</strong> 2025년 1학기</p>
                                <p><c:if test="${not empty sessionScope.m}">
                                        <c:choose>
                                            <c:when test="${user['class'].simpleName eq 'Student' and not empty user.studentName}">
                                                LDB 학사관리시스템에서 수강신청, 성적확인, 공지사항 등을 편리하게 이용하세요.
                                            </c:when>
                                            <c:when test="${user['class'].simpleName eq 'Professor' and not empty user.professorName}">
                                                LDB 학사관리시스템에서 강의등록, 강의관리, 성적관리 등을 편리하게 이용하세요.
                                            </c:when>
                                        </c:choose>
                                    </c:if>
								</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="card card-info card-outline">
                            <div class="card-header">
                                <h5 class="card-title">빠른 액세스</h5>
                            </div>
                            <div class="card-body">
                                <div class="d-flex flex-wrap">
                                    <a href="${path}/learning_support/registerCourse" class="btn btn-primary m-1">수강신청</a>
                                    <a href="${path}/mypage/getCourseScores" class="btn btn-success m-1">성적확인</a>
                                    <a href="${path}/mypage/getCourseTimetable" class="btn btn-warning m-1">시간표조회</a>
                                    <a href="${path}/notice/getNotices" class="btn btn-info m-1">공지사항</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-6">
                        <div class="card card-warning card-outline">
                            <div class="card-header">
                                <h5 class="card-title">최신 공지사항</h5>
                                <div class="card-tools">
                                    <a href="${path}/notice/getNotices" class="btn btn-tool">전체보기</a>
                                </div>
                            </div>
                            <div class="card-body">
                                <ul class="list-group">
                                    <c:forEach var="notice" items="${recentNotices}" begin="0" end="2">
                                        <li class="list-group-item">
                                            <a href="${path}/notice/getNoticeDetail?noticeId=${notice.noticeId}">${fn:escapeXml(notice.noticeTitle)}</a>
                                            <span class="float-end text-muted">
                                                <fmt:formatDate value="${notice.noticeCreatedAt}" pattern="yyyy-MM-dd" />
                                            </span>
                                        </li>
                                    </c:forEach>
                                </ul>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="card card-success card-outline">
                            <div class="card-header">
                                <h5 class="card-title">학사 일정</h5>
                            </div>
                            <div class="card-body">
                                <ul class="timeline timeline-inverse" id="scheduleTimeline">
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
<script>
$(document).ready(function() {
    var path = "${pageContext.request.contextPath}";

    const iconClasses = [
        "bi bi-calendar-event",
        "bi bi-bell",
        "bi bi-bookmark",
        "bi bi-check-circle",
        "bi bi-star"
    ];
    
    const bgClasses = [
        "bg-primary",
        "bg-success",
        "bg-info",
        "bg-warning",
        "bg-danger"
    ];
    
    function getRandomIndex(arr) {
        return Math.floor(Math.random() * arr.length);
    }
    
    $.ajax({
        url: path + "/mypage/schedule",
        type: "GET",
        dataType: "json",
        cache: false,
        success: function(data) {
            
            let timeline = $("#scheduleTimeline");
            timeline.empty();
            
            if (!data.success || !data.schedules || data.schedules.length === 0) {
                console.log("No schedules found or success is false");
                timeline.append('<li><div class="timeline-item">스케줄 데이터가 없습니다.</div></li>');
                return;
            }
            
            $.each(data.schedules, function(index, schedule) {
                
                let formattedDate = schedule.scheduleDateFormatted || "날짜 없음";
                let randomIcon = iconClasses[getRandomIndex(iconClasses)];
                let randomBg = bgClasses[getRandomIndex(bgClasses)];
                
                let timelineItem = '<li>' +
                '<i class="' + randomIcon + ' ' + randomBg + '"></i>' +
                '<div class="timeline-item">' +
                    '<span class="time"><i class="bi bi-clock"></i> ' + formattedDate + '</span>' + 
                    '<h3 class="timeline-header">' + schedule.scheduleTitle + '</h3>' +
                    '<div class="timeline-body">' + schedule.scheduleDescription + '</div>' +
                '</div>' +
            '</li>';
                timeline.append(timelineItem);
            });
            timeline.append('<li><i class="fas fa-clock bg-gray"></i></li>');
        },
        error: function(xhr, status, error) {
            console.error("Error fetching schedule:", status, error);
            console.error("Response Status:", xhr.status);
            console.error("Full Response:", xhr.responseText);
            $("#scheduleTimeline").html('<li><div class="timeline-item">데이터를 불러오는데 실패했습니다: ' + error + ' (Status: ' + xhr.status + ')</div></li>');
        }
    });
});
</script>
</body>
</html>