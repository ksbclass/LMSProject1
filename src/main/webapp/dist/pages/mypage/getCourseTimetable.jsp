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
<title>시간표조회</title>
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

/* 시간표 스타일 */
#timetable-container {
	margin-top: 20px;
}

#courseTime {
	width: 100%;
	border-collapse: collapse;
	background: #ffffff;
	box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
	border-radius: 8px;
	overflow: hidden;
}

#courseTime th, #courseTime td {
	border: 1px solid #e2e8f0;
	padding: 10px;
	text-align: center;
	vertical-align: middle;
	font-size: 14px;
}

#courseTime th {
	background: linear-gradient(135deg, #4a90e2, #357abd);
	color: white;
	font-weight: 600;
}

#courseTime th.time-slot {
	background: #edf2f7;
	color: #2d3748;
	width: 120px;
}

#courseTime td {
	background: #f9fafb;
	transition: background 0.3s ease;
	height: 80px;
	position: relative;
}

#courseTime td:hover {
	background: #edf2f7;
}

#courseTime td .course-info {
	background: #e6f0fa;
	border-radius: 6px;
	padding: 8px;
	box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
	font-size: 12px;
	line-height: 1.4;
	color: #2d3748;
}

#courseTime td .course-info span {
	display: block;
}
</style>
</head>
<body>
	<div id="timetable-container">
		<table id="courseTime">
			<thead>
				<tr>
					<th class="time-slot">시간</th>
					<th>월</th>
					<th>화</th>
					<th>수</th>
					<th>목</th>
					<th>금</th>
					<th>토</th>
					<th>일</th>
				</tr>
			</thead>
			<tbody id="timetable-body">
				<tr>
					<td class="time-slot">09:00 - 09:50</td>
					<td class="monday-0900"></td>
					<td class="tuesday-0900"></td>
					<td class="wednesday-0900"></td>
					<td class="thursday-0900"></td>
					<td class="friday-0900"></td>
					<td class="saturday-0900"></td>
					<td class="sunday-0900"></td>
				</tr>
				<tr>
					<td class="time-slot">10:00 - 10:50</td>
					<td class="monday-1000"></td>
					<td class="tuesday-1000"></td>
					<td class="wednesday-1000"></td>
					<td class="thursday-1000"></td>
					<td class="friday-1000"></td>
					<td class="saturday-1000"></td>
					<td class="sunday-1000"></td>
				</tr>
				<tr>
					<td class="time-slot">11:00 - 11:50</td>
					<td class="monday-1100"></td>
					<td class="tuesday-1100"></td>
					<td class="wednesday-1100"></td>
					<td class="thursday-1100"></td>
					<td class="friday-1100"></td>
					<td class="saturday-1100"></td>
					<td class="sunday-1100"></td>
				</tr>
				<tr>
					<td class="time-slot">12:00 - 12:50</td>
					<td class="monday-1200"></td>
					<td class="tuesday-1200"></td>
					<td class="wednesday-1200"></td>
					<td class="thursday-1200"></td>
					<td class="friday-1200"></td>
					<td class="saturday-1200"></td>
					<td class="sunday-1200"></td>
				</tr>
				<tr>
					<td class="time-slot">13:00 - 13:50</td>
					<td class="monday-1300"></td>
					<td class="tuesday-1300"></td>
					<td class="wednesday-1300"></td>
					<td class="thursday-1300"></td>
					<td class="friday-1300"></td>
					<td class="saturday-1300"></td>
					<td class="sunday-1300"></td>
				</tr>
				<tr>
					<td class="time-slot">14:00 - 14:50</td>
					<td class="monday-1400"></td>
					<td class="tuesday-1400"></td>
					<td class="wednesday-1400"></td>
					<td class="thursday-1400"></td>
					<td class="friday-1400"></td>
					<td class="saturday-1400"></td>
					<td class="sunday-1400"></td>
				</tr>
				<tr>
					<td class="time-slot">15:00 - 15:50</td>
					<td class="monday-1500"></td>
					<td class="tuesday-1500"></td>
					<td class="wednesday-1500"></td>
					<td class="thursday-1500"></td>
					<td class="friday-1500"></td>
					<td class="saturday-1500"></td>
					<td class="sunday-1500"></td>
				</tr>
				<tr>
					<td class="time-slot">16:00 - 16:50</td>
					<td class="monday-1600"></td>
					<td class="tuesday-1600"></td>
					<td class="wednesday-1600"></td>
					<td class="thursday-1600"></td>
					<td class="friday-1600"></td>
					<td class="saturday-1600"></td>
					<td class="sunday-1600"></td>
				</tr>
				<tr>
					<td class="time-slot">17:00 - 17:50</td>
					<td class="monday-1700"></td>
					<td class="tuesday-1700"></td>
					<td class="wednesday-1700"></td>
					<td class="thursday-1700"></td>
					<td class="friday-1700"></td>
					<td class="saturday-1700"></td>
					<td class="sunday-1700"></td>
				</tr>
			</tbody>
		</table>
	</div>
<script type="text/javascript">
$(document).ready(function() {
    $.ajax({
        url: "${path}/mypage/viewCourseTimetable",
        type: "get",
        dataType: "json",
        beforeSend: function() {
            $("#timetable-body td:not(.time-slot)").html(""); // 초기화
            $("#timetable-body").append(
                $("<tr>").append(
                    $("<td colspan='8' class='text-center text-gray-500'>").text("로딩 중...")
                )
            );
        },
        success: function(response) {
            console.log('AJAX success, response:', response);
            // 로딩 메시지 제거
            $("#timetable-body tr:last").remove();
            if (response.success) {
                var timetable = response.timetable;
                var tbody = $("#timetable-body");

                // 모든 셀 초기화
                $("#timetable-body td:not(.time-slot)").html("");
                console.log('Timetable data:', timetable);

                if (timetable && timetable.length > 0) {
                    $.each(timetable, function(idx, item) {
                        console.log('Processing item:', item);
                        // 요일과 시간대에 맞는 셀 선택
                        var dayClass = "";
                        switch (item.courseTimeYoil) {
                            case "월": dayClass = "monday"; break;
                            case "화": dayClass = "tuesday"; break;
                            case "수": dayClass = "wednesday"; break;
                            case "목": dayClass = "thursday"; break;
                            case "금": dayClass = "friday"; break;
                            case "토": dayClass = "saturday"; break;
                            case "일": dayClass = "sunday"; break;
                            default: console.log('Unknown day:', item.courseTimeYoil); dayClass = ""; break;
                        }
						console.log('dayClass: ' + dayClass);
                        // 시간대 클래스 (예: 09:00 -> 0900)
                        var startTime = item.courseTimeStartFormatted ? item.courseTimeStartFormatted.replace(":", "") : "0900";
                        console.log('startTime', startTime);                            
                        var cellClass = "." + dayClass + "-" + startTime;
                        
                        console.log('Targeting cell:', cellClass);

                        // 셀에 강의 정보 추가
                        if ($(cellClass).length > 0) {
                            var courseInfo = $("<div>").addClass("course-info").append(
                                $("<span>").text(item.courseName || "No Name"),
                                $("<span>").text(item.courseTimeLoc || "No Location"),
                                $("<span>").text(item.professorName || "No Professor")
                            );
                            $(cellClass).append(courseInfo);
                            console.log('Appended to:', cellClass);
                        } else {
                            console.log('Cell not found:', cellClass);
                        }
                    });
                } else {
                    console.log('No timetable data or empty');
                    $("#timetable-body").append(
                        $("<tr>").append(
                            $("<td colspan='8' class='text-center text-gray-500'>").text("등록된 강의가 없습니다.")
                        )
                    );
                }
            } else {
                console.log('Response success false, message:', response.message);
                alert("시간표 로드 실패: " + response.message);
            }
        },
        error: function(xhr) {
            console.log('AJAX error, xhr:', xhr);
            $("#timetable-body tr:last").remove();
            $("#timetable-body").append(
                $("<tr>").append(
                    $("<td colspan='8' class='text-center text-gray-500'>").text("오류 발생")
                )
            );
            alert("서버 오류: " + xhr.status + " - " + xhr.responseText);
        }
    });
});
</script>
</body>
</html>