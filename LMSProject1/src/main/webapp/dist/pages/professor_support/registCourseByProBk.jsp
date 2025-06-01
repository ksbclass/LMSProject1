<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="path" value="${pageContext.request.contextPath}" scope="application" />

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>강의등록(교수지원)</title>
<style>
    body {
        font-family: 'Noto Sans KR', sans-serif;
        background-color: #f8f9fa;
    }
    .content {
        padding: 50px;
    }
    .card {
        border: none;
        box-shadow: 0 0.125rem 0.25rem rgba(0, 0, 0, 0.075);
        margin-bottom: 20px;
    }
    .btn-custom {
        background-color: #dc3545;
        color: #ffffff;
        border: none;
    }
    .btn-custom:hover {
        background-color: #c82333;
    }
    .table th {
        background-color: #f1f3f5;
    }
    .form-label-custom {
        font-weight: bold;
        margin-bottom: 0.3rem;
    }
    .input-group-text-custom {
        background-color: #e9ecef;
        border: 1px solid #ced4da;
    }
    .form-select-sm, .form-control-sm {
        padding: 0.375rem 0.75rem;
        font-size: 0.875rem;
        border-radius: 0.2rem;
        flex: 1;
        min-width: 0;
    }
    #courseTime .time-input-group {
        display: flex;
        align-items: center;
        flex-wrap: wrap;
    }
    #courseTime .time-input-group > * {
        margin-right: 0.5rem;
    }
    #courseTime .time-input-group > select {
        flex-basis: 30%;
    }
    #courseTime .time-input-group > .input-group {
        flex-basis: 30%;
    }
    #courseTime .time-input-group > .mx-2 {
        flex-basis: auto;
    }
    #courseTime .time-input-group > *:last-child {
        margin-right: 0;
    }
    .input-group-sm > .form-control,
    .input-group-sm > .form-select,
    .input-group-sm > .input-group-text {
        height: calc(1.5em + 0.5rem + 2px);
        padding: 0.25rem 0.5rem;
        font-size: 0.875rem;
        border-radius: 0.2rem;
    }
    .time-instruction {
        font-size: 0.875rem;
        color: #6c757d;
    }
    .mb-3.row .col-sm-10 .time-instruction.error { 
        color: red !important;
    }
    
    
    #errorMsg {
    display: none; /* 기본적으로 숨김 */
    font-size: 1.25rem;
    color: #dc3545; /* 에러 색상 */
    font-weight: bold;
    text-align: center;
    padding: 10px 20px;
    background-color: #fff3f3;
    border-radius: 5px;
    box-shadow: 0 0.125rem 0.25rem rgba(0, 0, 0, 0.1);
    z-index: 1000;
	}
	
	#errorMsg.error {
	    display: block; /* 에러 클래스 추가 시 표시 */
	}
	
	#errorMsg i {
	    margin-right: 8px;
	    vertical-align: middle;
	    color: #dc3545;
	}

    @media (max-width: 576px) {
        #courseTime .time-input-group {
            flex-direction: column;
            align-items: stretch;
        }
        #courseTime .time-input-group > * {
            margin-right: 0;
            margin-bottom: 0.5rem;
        }
        
        #errorMsg {
        font-size: 1rem;
        padding: 8px 15px;
    	}
    }
</style>
</head>
<body>
	<input type="hidden" id="paramError" value="${errorMsg}">
    <form action="${path}/professor_support/registCourseForm" method="post" id="registCourseForm">
        <div class="content">
            <div class="d-flex justify-content-between align-items-center mb-4 position-relative">
		        <h2><i class="bi bi-pencil-square me-2"></i> 강의 등록</h2>
		        <h2 id="errorMsg" class="position-absolute top-50 start-50 translate-middle"><i class="bi bi-exclamation-triangle-fill"></i> </h2>
    		</div>
            <div class="card p-4">
                <div class="mb-3 row">
                    <label for="majorName" class="col-sm-2 col-form-label-custom">전공명</label>
                    <div class="col-sm-10">
                        <select class="form-select form-select-sm" id="majorName" name="majorName">
                            <option value="" selected>전공을 선택하세요</option>
                            <c:forEach var="department" items="${departments}" varStatus="status">
                                <option value="${department.deptId}">${department.deptName}</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>
                <div class="mb-3 row">
                    <label for="courseName" class="col-sm-2 col-form-label-custom">강의명</label>
                    <div class="col-sm-10">
                        <input type="text" class="form-control form-control-sm" 
                               id="courseName" name="courseName" value="" placeholder="하나도넛 주문 방법(예)">
                    </div>
                </div>
                <div class="mb-3 row">
                    <label for="professorName" class="col-sm-2 col-form-label-custom">교수명</label>
                    <div class="col-sm-10">
                        <input type="text" class="form-control form-control-sm" 
                               id="professorName" name="professorName" value="" placeholder="피카츄(예)">
                    </div>
                </div>
                <div class="mb-3 row">
	                    <label for="professorEmail" class="col-sm-2 col-form-label-custom">이메일</label>
	                    <div class="col-sm-10">
	                        <input type="text" class="form-control form-control-sm" 
	                               id="professorEmail" name="professorEmail" value="" placeholder="john.doe@univ.edu(예)">
	                    </div>
               	</div>
                <div class="mb-3 row">
                    <label class="col-sm-2 col-form-label-custom">이수구분</label>
                    <div class="col-sm-10">
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" name="creditCategory" id="majorRequired" value="MajorRequired" checked>
                            <label class="form-check-label" for="majorRequired">전공필수</label>
                        </div>
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" name="creditCategory" id="MajorElective" value="MajorElective">
                            <label class="form-check-label" for="MajorElective">전공선택</label>
                        </div>
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" name="creditCategory" id="liberalArts" value="liberalArts">
                            <label class="form-check-label" for="liberalArts">교양</label>
                        </div>
                    </div>
                </div>
                
                <div class="mb-3 row">
                    <label for="coursePeriod" class="col-sm-2 col-form-label-custom">강의기간</label>
                    <div class="col-sm-10">
                        <select class="form-select form-select-sm" id="coursePeriod" name="coursePeriod">
                            <option value="1학기" selected>1학기</option>
                            <option value="2학기">2학기</option>
                        </select>
                    </div>
                </div>
                
                
                <div class="mb-3 row align-items-center" id="courseTime">
                    <label for="courseDay" class="col-sm-2 col-form-label-custom">강의시간</label>
                    <div class="col-sm-10">
                        <div class="d-flex align-items-center time-input-group">
                            <select class="form-select form-select-sm" id="courseDay" name="courseDay">
                                <option value="" selected>요일 선택</option>
                                <option value="월">월요일</option>
                                <option value="화">화요일</option>
                                <option value="수">수요일</option>
                                <option value="목">목요일</option>
                                <option value="금">금요일</option>
                            </select>
                            <div class="input-group input-group-sm">
                                <input type="number" class="form-control form-control-sm start-time-hour" 
                                       id="startTimeHour" name="startTimeHour" min="9" max="23" step="1" placeholder="시작시간 입력">
                                <div class="input-group-text">:00</div>
                            </div>
                            <span class="mx-2">~</span>
                            <div class="input-group input-group-sm">
                                <input type="number" class="form-control form-control-sm end-time-hour" 
                                       id="endTimeHour" name="endTimeHour" min="9" max="23" step="1" placeholder="종료시간 입력">
                                <div class="input-group-text">:50</div>
                            </div>
                        </div>
                        <small class="form-text text-muted time-instruction">요일과 시작/종료 시간을 선택하세요 (9~23시)</small>
                    </div>
                </div>
                <div class="mb-3 row">
                    <label for="courseMaxCnt" class="col-sm-2 col-form-label-custom">정원수</label>
                    <div class="col-sm-10">
                        <input type="text" class="form-control form-control-sm" 
                               id="courseMaxCnt" name="courseMaxCnt" value="" placeholder="최대정원 입력">
                    </div>
                </div>
                <div class="mb-3 row">
                    <label for="courseLoc" class="col-sm-2 col-form-label-custom">강의실</label>
                    <div class="col-sm-10">
                        <input type="text" class="form-control form-control-sm" 
                               id="courseLoc" name="courseLoc" value="" placeholder="강의실 입력(예:A302)">
                    </div>
                </div>
                <div class="mb-3 row">
                    <label for="score" class="col-sm-2 col-form-label-custom">학점</label>
                    <div class="col-sm-10">
                        <input type="number" class="form-control form-control-sm" id="score" name="score" min="1" max="6" value="">
                        <small class="form-text text-muted">1점에서 6점 사이의 학점을 입력하세요.</small>
                    </div>
                </div>
            </div>

            <div class="card p-4">
                <h5 class="mb-3">강의 설명</h5>
                <div class="mb-3">
                    <textarea class="form-control form-control-sm" name="description" rows="5"></textarea>
                    <small class="form-text text-muted">강의 내용을 설명해주세요.</small>
                </div>
                <div class="d-flex justify-content-end">
                    <button type="button" class="btn btn-secondary btn-sm me-2" id="btnReset">리셋 <i class="bi bi-arrow-counterclockwise"></i></button>
                    <button type="submit" class="btn btn-custom btn-sm" id="btnSubmit">등록 <i class="bi bi-check-circle"></i></button>
                </div>
            </div>
            
        </div>
    </form>

    <script>
        function validTimeInput() {
            var isValid = true;
            $('.start-time-hour, .end-time-hour').each(function() {
                var inputField = $(this);
                var instructionText = $(this).closest('.mb-3.row.align-items-center').find('.time-instruction');
                var timeValue = parseInt(inputField.val()) || 0;
                
                if (!/^\d+$/.test(inputField.val()) || timeValue < 9 || timeValue > 23) {
                    instructionText.text('시간은 9~23시 사이로 입력하세요.');
                    instructionText.addClass('error');
                    inputField.addClass('is-invalid');
                    isValid = false;
                } else {
                    instructionText.text('요일과 시작/종료 시간을 선택하세요 (9~23시)');
                    instructionText.removeClass('error');
                    inputField.removeClass('is-invalid');
                }
            });
            
            var startHour = parseInt($('#startTimeHour').val()) || 0;
            var endHour = parseInt($('#endTimeHour').val()) || 0;
            if (startHour > endHour) {
                $('.time-instruction').text('시작 시간이 종료 시간보다 빨라야 합니다.');
                $('.time-instruction').addClass('error');
                $('.start-time-hour, .end-time-hour').addClass('is-invalid');
                isValid = false;
            }
            
            return isValid;
        }

        function validateForm() {
            var isValid = true;

            // 전공명 검증
            var majorName = $('#majorName').val();
            if (majorName === "") {
                $('#errorMsg').text('전공을 선택해주세요.');
                $('#errorMsg').addClass('error');
                $('#majorName').addClass('is-invalid');
                isValid = false;
            } else {
                $('#majorName').removeClass('is-invalid');
            }

            // 강의명 검증
            var courseName = $('#courseName').val().trim();
            if (courseName === "") {
                $('#errorMsg').text('강의명을 입력해주세요.');
                $('#errorMsg').addClass('error');
                $('#courseName').addClass('is-invalid');
                isValid = false;
            } else {
                $('#courseName').removeClass('is-invalid');
            }

            // 교수명 검증
            var professorName = $('#professorName').val().trim();
            if (professorName === "") {
                $('#errorMsg').text('교수명을 입력해주세요.');
                $('#errorMsg').addClass('error');
                $('#professorName').addClass('is-invalid');
                isValid = false;
            } else {
                $('#professorName').removeClass('is-invalid');
            }
            
         	// 이메일 검증
            var professorEmail = $('#professorEmail').val().trim();
		    var emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
		
		    if (professorEmail === "") {
		        $('#errorMsg').text('이메일을 입력해주세요.');
		        $('#errorMsg').addClass('error');
		        $('#professorEmail').addClass('is-invalid');
		        isValid = false;
		    } else if (!emailPattern.test(professorEmail)) {
		        $('#errorMsg').text('유효한 이메일 형식이 아닙니다. (예: example@domain.com)');
		        $('#errorMsg').addClass('error');
		        $('#professorEmail').addClass('is-invalid');
		        isValid = false;
		    } else {
		        $('#professorEmail').removeClass('is-invalid');
		    }

            // 요일 검증
            var courseDay = $('#courseDay').val();
            if (courseDay === "") {
                $('#errorMsg').text('요일을 선택해주세요.');
                $('#errorMsg').addClass('error');
                $('#courseDay').addClass('is-invalid');
                isValid = false;
            } else {
                $('#courseDay').removeClass('is-invalid');
            }

            // 시간 검증
            if (!validTimeInput()) {
                isValid = false;
            }

            // 학점 검증
            var score = parseInt($('#score').val()) || 0;
            if (score < 1 || score > 6) {
                $('#errorMsg').text('1~6 사이의 학점을 입력하세요.');
                $('#errorMsg').addClass('error');
                $('#score').addClass('is-invalid');
                isValid = false;
            } else {
                $('#score').removeClass('is-invalid');
            }

            return isValid;
        }

        $(document).ready(function() {
        	var paramError = $("#paramError").val();
        	if (paramError == 'Duplicate') {
				alert('입력한 강의명이 기존에 존재합니다.');
        	} else if (paramError == 'DBERROR') {
        		alert('데이터 입력시 오류발생. 관리자에게 문의하세요.');
        	}

            $('#courseTimeList').empty();

            $('.start-time-hour, .end-time-hour').on('focusout', function() {
                validTimeInput();
            });

            $('form').on('submit', function(event) {
                if (!validateForm()) {
                    event.preventDefault();
                    alert('모든 필드를 올바르게 입력해주세요.');
                }
            });

            $('#btnReset').on('click', function() {
                $('#registCourseForm')[0].reset();
                $('.time-instruction').text('요일과 시작/종료 시간을 선택하세요 (9~23시)');
                $('.time-instruction').removeClass('error');
                $('#errorMsg').removeClass('error');
                $('#errorMsg').text('');
                $('.start-time-hour, .end-time-hour, #courseDay, #majorName, #courseName, #professorName, #professorEmail, #score').removeClass('is-invalid');
            });
        });
    </script>
</body>
</html>