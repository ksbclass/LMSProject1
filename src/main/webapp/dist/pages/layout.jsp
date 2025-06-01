<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="path" value="${pageContext.request.contextPath}"
	scope="application" />

<!doctype html>
<html lang="en">
<!--begin::Head-->
<head>
<script
	src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.slim.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="https://cdn.tailwindcss.com"></script>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><sitemesh:write property="title" /></title>
<!--begin::Primary Meta Tags-->
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<meta name="title" content="AdminLTE v4 | Dashboard" />
<meta name="author" content="ColorlibHQ" />
<meta name="description"
	content="AdminLTE is a Free Bootstrap 5 Admin Dashboard, 30 example pages using Vanilla JS." />
<meta name="keywords"
	content="bootstrap 5, bootstrap, bootstrap 5 admin dashboard, bootstrap 5 dashboard, bootstrap 5 charts, bootstrap 5 calendar, bootstrap 5 datepicker, bootstrap 5 tables, bootstrap 5 datatable, vanilla js datatable, colorlibhq, colorlibhq dashboard, colorlibhq admin dashboard" />
<!--end::Primary Meta Tags-->
<!--begin::Fonts-->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/@fontsource/source-sans-3@5.0.12/index.css"
	integrity="sha256-tXJfXfp6Ewt1ilPzLDtQnJV4hclT9XuaZUKyUvmyr+Q="
	crossorigin="anonymous" />
<!--end::Fonts-->
<!--begin::Third Party Plugin(OverlayScrollbars)-->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/overlayscrollbars@2.10.1/styles/overlayscrollbars.min.css"
	integrity="sha256-tZHrRjVqNSRyWg2wbppGnT833E/Ys0DHWGwT04GiqQg="
	crossorigin="anonymous" />
<!--end::Third Party Plugin(OverlayScrollbars)-->
<!--begin::Third Party Plugin(Bootstrap Icons)-->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css"
	integrity="sha256-9kPW/n5nn53j4WMRYAxe9c1rCY96Oogo/MKSVdKzPmI="
	crossorigin="anonymous" />
<!--end::Third Party Plugin(Bootstrap Icons)-->
<!--begin::Required Plugin(AdminLTE)-->
<link rel="stylesheet" href="/LMSProject1/dist/css/adminlte.css" />
<!--end::Required Plugin(AdminLTE)-->
<style>
ul.timeline::before {
	content: none !important;
}

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

.user-header {
	display: flex;
	flex-direction: column;
	align-items: center;
	justify-content: center;
	text-align: center;
}

</style>
<sitemesh:write property="head" />
</head>
<!--end::Head-->
<!--begin::Body-->
<body class="layout-fixed sidebar-expand-lg bg-body-tertiary">
	<!--begin::App Wrapper-->
	<div class="app-wrapper">
		<!--begin::Header-->
		<nav class="app-header navbar navbar-expand bg-body">
			<!--begin::Container-->
			<div class="container-fluid">
				<!--begin::Start Navbar Links-->
				<ul class="navbar-nav">
					<li class="nav-item"><a class="nav-link"
						data-lte-toggle="sidebar" href="#" role="button"> <i
							class="bi bi-list"></i>
					</a></li>
					<li class="nav-item d-none d-md-block"><a
						href="${path}/mypage/index" class="nav-link">Home</a></li>
				</ul>
				<!--end::Start Navbar Links-->
				<!--begin::End Navbar Links-->
				<ul class="navbar-nav ms-auto">
					<!--begin::Fullscreen Toggle-->
					<li class="nav-item"><a class="nav-link" href="#"
						data-lte-toggle="fullscreen"> <i data-lte-icon="maximize"
							class="bi bi-arrows-fullscreen"></i> <i data-lte-icon="minimize"
							class="bi bi-fullscreen-exit" style="display: none"></i>
					</a></li>
					<!--end::Fullscreen Toggle-->
					<!--begin::User Menu Dropdown-->
					<li class="nav-item dropdown user-menu"><a href="#"
						class="nav-link dropdown-toggle d-flex align-items-center"
						data-bs-toggle="dropdown"> <%-- 
						<c:set var="img" value="${fn:contains(sessionScope.login, 'S') ? m.studentImg : m.professorImg}" />
						--%> <img src="${path}/dist/assets/picture/${m.img}"
							class="user-image rounded-circle shadow" alt="User Image" style="width: 60px; height: 60px; margin-top: 3px"/> <span
							class="d-none d-md-inline">${sessionScope.login}님 반갑습니다</span>
					</a>
						<ul class="dropdown-menu dropdown-menu-lg dropdown-menu-end">
							<!--begin::User Image-->
							<c:set var="img"
								value="${fn:contains(sessionScope.login, 'S') ? m.studentImg : m.professorImg}" />
							<li class="user-header text-bg-primary"><img
								src="${path}/dist/assets/picture/${img}"
								class="rounded-circle shadow" alt="User Image" 
								style="width: 100px; height: 100px;"/> 
								<c:if test="${fn:contains(sessionScope.login, 'S')}">
									<fmt:formatDate value="${m.studentBirthday}"
										pattern="YYYY-MM-dd" var="birth" />
									<p>${m.studentName}<small>${birth}</small>
									</p>
								</c:if> <c:if test="${not fn:contains(sessionScope.login, 'S')}">
									<fmt:formatDate value="${m.professorBirthday}"
										pattern="YYYY-MM-dd" var="birth" />
									<p>${m.professorName}<small>${birth}</small>
									</p>
								</c:if>
								<p>${deptName}</p></li>
							<!--end::User Image-->

							<!--begin::Menu Footer-->
							<li class="user-footer"><a href="${path}/mypage/userInfo"
								class="btn btn-default btn-flat">Profile</a> <a
								href="${path}/mypage/logout"
								class="btn btn-default btn-flat float-end">Sign out</a></li>
							<!--end::Menu Footer-->
						</ul></li>
					<!--end::User Menu Dropdown-->
				</ul>
				<!--end::End Navbar Links-->
			</div>
			<!--end::Container-->
		</nav>
		<!--end::Header-->
		<!--begin::Sidebar-->
		<aside class="app-sidebar bg-body-secondary shadow"
			data-bs-theme="dark">
			<!--begin::Sidebar Brand-->
			<div class="sidebar-brand">
				<!--begin::Brand Link-->
				<a href="${path}/mypage/index" class="brand-link"> <!--begin::Brand Image-->
					<img src="/LMSProject1/dist/assets/img/AdminLTELogo.png"
					class="brand-image opacity-75 shadow" /> <!--end::Brand Image--> <!--begin::Brand Text-->
					<span class="brand-text fw-light">LDB학사관리시스템</span> <!--end::Brand Text-->
				</a>
				<!--end::Brand Link-->
			</div>
			<!--end::Sidebar Brand-->
			<!--begin::Sidebar Wrapper-->
			<div class="sidebar-wrapper">
				<nav class="mt-2">
					<!--begin::Sidebar Menu-->
					<ul class="nav sidebar-menu flex-column" data-lte-toggle="treeview"
						role="menu" data-accordion="false">
						<li class="nav-item menu-open"><a href="#"
							class="nav-link active"> <i
								class="nav-icon bi bi-speedometer"></i>
								<p>
									MyPage <i class="nav-arrow bi bi-chevron-right"></i>
								</p>
						</a>
							<ul class="nav nav-treeview">
								<li class="nav-item"><a href="${path}/mypage/userInfo"
									class="nav-link active"> <i class="nav-icon bi bi-circle"></i>
										<p>개인정보</p>
								</a></li>
								<li class="nav-item"><a
									href="${path}/mypage/getCourseScores" class="nav-link"> <i
										class="nav-icon bi bi-circle"></i>
										<p>성적확인</p>
								</a></li>
								<li class="nav-item"><a
									href="${path}/mypage/getCourseTimetable" class="nav-link">
										<i class="nav-icon bi bi-circle"></i>
										<p>시간표조회</p>
								</a></li>
							</ul></li>
						<c:if test="${fn:contains(sessionScope.login, 'S')}">
							<li class="nav-item"><a href="#" class="nav-link"> <i
									class="nav-icon bi bi-box-seam-fill"></i>
									<p>
										학습지원 <i class="nav-arrow bi bi-chevron-right"></i>
									</p>
							</a>
								<ul class="nav nav-treeview">
									<li class="nav-item"><a
										href="${path}/learning_support/registerCourse"
										class="nav-link"> <i class="nav-icon bi bi-circle"></i>
											<p>수강신청</p>
									</a></li>
									<li class="nav-item"><a
										href="${path}/learning_support/viewCourse/viewCourse"
										class="nav-link"> <i class="nav-icon bi bi-circle"></i>
											<p>수강신청 현황</p>
									</a></li>
									<li class="nav-item"><a href="#" class="nav-link"> <i
											class="nav-icon bi bi-circle"></i>
											<p>미정</p>
									</a></li>
								</ul></li>
						</c:if>

						<c:if test="${fn:contains(sessionScope.login, 'P')}">
							<li class="nav-item"><a href="#" class="nav-link"> <i
									class="nav-icon bi bi-clipboard-fill"></i>
									<p>
										교수지원
										<!-- <span class="nav-badge badge text-bg-secondary me-3">6</span> -->
										<i class="nav-arrow bi bi-chevron-right"></i>
									</p>
							</a>
								<ul class="nav nav-treeview">
									<li class="nav-item"><a
										href="${path}/professor_support/registCourse" class="nav-link">
											<i class="nav-icon bi bi-circle"></i>
											<p>강의등록</p>
									</a></li>
									<li class="nav-item"><a
										href="${path}/professor_support/manage/manageCourse"
										class="nav-link"> <i class="nav-icon bi bi-circle"></i>
											<p>강의관리</p>
									</a></li>
									<li class="nav-item"><a
										href="${path}/professor_support/score/scoreMng"
										class="nav-link"> <i class="nav-icon bi bi-circle"></i>
											<p>성적관리</p>
									</a></li>
									<li class="nav-item"><a
										href="${path}/professor_support/attendance/attendance"
										class="nav-link"> <i class="nav-icon bi bi-circle"></i>
											<p>출석관리</p>
									</a></li>
								</ul></li>
						</c:if>
						<!--  교수지원쪽부분을 교수가아니면 아예 뜨지않게 막아놓을거임-->

						<li class="nav-item"><a href="${path}/notice/getNotices"
							class="nav-link"> <i class="nav-icon bi bi-tree-fill"></i>
								<p>공지사항</p>
						</a></li>
						<li class="nav-item"><a href="${path}/post/getPosts"
							class="nav-link"> <i class="nav-icon bi bi-pencil-square"></i>
								<p>문의게시판</p>
						</a></li>
					</ul>
					<!--end::Sidebar Menu-->
				</nav>
			</div>
			<!--end::Sidebar Wrapper-->
		</aside>
		<!--end::Sidebar-->
		<!--begin::App Main-->

		<main class="app-main">

			<sitemesh:write property="body" />

		</main>
		<!--end::App Main-->
		<!--begin::Footer-->
		<footer class="app-footer">
			<!--begin::To the end-->
			<!-- <div class="float-end d-none d-sm-inline">Anything you want</div> -->
			<!--end::To the end-->
			<!--begin::Copyright-->
			<strong> Copyright &copy;2025-05-01&nbsp; <a href="#"
				class="text-decoration-none">LDB대학교</a>.
			</strong> All rights reserved.
			<!--end::Copyright-->
		</footer>
		<!--end::Footer-->
	</div>
	<!--end::App Wrapper-->
	<!--begin::Script-->
	<!--begin::Third Party Plugin(OverlayScrollbars)-->
	<script
		src="https://cdn.jsdelivr.net/npm/overlayscrollbars@2.10.1/browser/overlayscrollbars.browser.es6.min.js"
		integrity="sha256-dghWARbRe2eLlIJ56wNB+b760ywulqK3DzZYEpsg2fQ="
		crossorigin="anonymous"></script>
	<!--end::Third Party Plugin(OverlayScrollbars)-->
	<!--begin::Required Plugin(popperjs for Bootstrap 5)-->
	<script
		src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"
		integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r"
		crossorigin="anonymous"></script>
	<!--end::Required Plugin(popperjs for Bootstrap 5)-->
	<!--begin::Required Plugin(Bootstrap 5)-->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js"
		integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy"
		crossorigin="anonymous"></script>
	<!--end::Required Plugin(Bootstrap 5)-->
	<!--begin::Required Plugin(AdminLTE)-->
	<script src="/LMSProject1/dist/js/adminlte.js"></script>
	<!--end::Required Plugin(AdminLTE)-->
	<!--begin::OverlayScrollbars Configure-->
	<script>
      const SELECTOR_SIDEBAR_WRAPPER = '.sidebar-wrapper';
      const Default = {
        scrollbarTheme: 'os-theme-light',
        scrollbarAutoHide: 'leave',
        scrollbarClickScroll: true,
      };
      document.addEventListener('DOMContentLoaded', function () {
        const sidebarWrapper = document.querySelector(SELECTOR_SIDEBAR_WRAPPER);
        if (sidebarWrapper && typeof OverlayScrollbarsGlobal?.OverlayScrollbars !== 'undefined') {
          OverlayScrollbarsGlobal.OverlayScrollbars(sidebarWrapper, {
            scrollbars: {
              theme: Default.scrollbarTheme,
              autoHide: Default.scrollbarAutoHide,
              clickScroll: Default.scrollbarClickScroll,
            },
          });
        }
      });
      $(document).ready(function() {
    	    var currentUrl = window.location.pathname;
    	    console.log('Current URL:', currentUrl);
    	    $('.nav-item').removeClass('menu-open');
    	    $('.nav-link').removeClass('active');
    	    $('.sidebar-menu .nav-link').each(function() {
    	        var linkUrl = $(this).attr('href');
    	        if (!linkUrl || linkUrl === '#') return;
    	        if (currentUrl.includes(linkUrl)) {
    	            console.log('Match found:', linkUrl);
    	            $(this).addClass('active');
    	            var parentNavItem = $(this).closest('.nav-item');
    	            parentNavItem.addClass('menu-open');
    	            var topLevelNavItem = $(this).closest('.nav-treeview').closest('.nav-item');
    	            topLevelNavItem.addClass('menu-open');
    	        }
    	    });
    	});
      
    </script>

</body>
<!--end::Body-->
</html>
