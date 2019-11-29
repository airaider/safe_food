<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<style>
table {
	width: 100%;
	border-top: 1px solid #444444;
	border-collapse: collapse;
}

th, td {
	border-bottom: 1px solid #444444;
	padding: 10px;
}
</style>
<head>
<title>메인 페이지</title>
<meta charset="UTF-8">
<!-- 합쳐지고 최소화된 최신 CSS -->
<script src="./js/jquery-3.3.1.js"></script>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<!-- 부가적인 테마 -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

<link rel="stylesheet" href="./css/food.css">
<link rel="stylesheet" href="./css/main.css">
<link rel="stylesheet" href="./font/cssFont/all.css">

<script type="text/javascript">
   		</script>
</head>
<body>
	<jsp:include page="nav.jsp" />
	<jsp:useBean id="bean" class="com.ssafy.model.dto.FoodPageBean"
		scope="request" />
	<!-- Container (중간 섹션) -->
	<div class="bg-1">
		<div>
			<br />
			<br />
			<br />
			<br />
			<br />
			<br />
		</div>
		<div id="band" class="container conta text-center">
			<h1>
				<em>WHAT WE PROVIDE</em>
			</h1>
			<P>건강한 삶을 위한 먹거리 프로젝트</P>
			<br>

		</div>
	</div>
	<div class="container conta">
		<section>
			<div>
				<h1 style="text-align: center">Only 국내산 원료</h1>
				<table>
					<thead>
						<tr style="text-align: center; background-color: #e1f5fe;">
							<th style="text-align: center">이미지</th>
							<th style="text-align: center">상품명</th>
							<th style="text-align: center">제조사</th>
							<th style="text-align: center">원산지</th>
						</tr>
					</thead>
					<c:forEach var="p" items="${nara}">
						<tr style="text-align: center">
							<c:choose>
								<c:when test="${empty p.value}">
									<td><a href="detailInfo.do?code=${p.key.code}"><img
											src="${p.key.img}" class="listimg"></img></a></td>
									<td><a href="detailInfo.do?code=${p.key.code}">${p.key.name}</a></td>
									<td>${p.key.maker}</td>
									<td>국내산</td>
								</c:when>
							</c:choose>
						</tr>
					</c:forEach>
				</table>
			</div>
			<br/>
			<br/>
			<br/>
			<div>
				<h1 style="text-align: center">원산지 목록</h1>
				<table>
					<thead>
						<tr style="text-align: center; background-color: #e1f5fe;">
							<th style="text-align: center">이미지</th>
							<th style="text-align: center">상품명</th>
							<th style="text-align: center">제조사</th>
							<th style="text-align: center">원산지</th>
						</tr>
					</thead>
					<c:forEach var="p" items="${nara}">
						<tr style="text-align: center">
							<c:choose>
								<c:when test="${not empty p.value}">
									<td><a href="detailInfo.do?code=${p.key.code}"><img
											src="${p.key.img}" class="listimg"></img></a></td>
									<td><a href="detailInfo.do?code=${p.key.code}">${p.key.name}</a></td>
									<td>${p.key.maker}</td>
									<td>${p.value }</td>
								</c:when>
							</c:choose>
						</tr>
					</c:forEach>
				</table>
			</div>
		</section>
	</div>
	<div class="bottom"></div>
	<footer class="text-center">
		<jsp:include page="copyright.jsp" />
	</footer>
</body>
</html>