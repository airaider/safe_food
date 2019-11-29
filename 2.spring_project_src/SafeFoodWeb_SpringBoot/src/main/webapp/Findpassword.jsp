<%@ page language="java" contentType="text/html;charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<style type="text/css">
.errormsg {
	font-size: 14px;
	color: red;
}
</style>
<!-- meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0"/ -->
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>비밀번호 찾기</title>
<!-- Bootstrap -->
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
</head>
<body>
	<c:choose>
		<c:when test="${sessionScope.id != null }">
			return "Main.jsp";
		</c:when>
	</c:choose>
	<jsp:include page="nav.jsp" />

	<div class="container">
		<!-- 좌우측의 공간 확보 -->
		<!-- 헤더 들어가는 부분 -->
		<div class="row">
			<br /> <br /> <br /> <br />
			<h1 class="text-center">비밀번호 찾기</h1>
		</div>
		<!--// 헤더 들어가는 부분 -->

		<!-- 모달창 -->
		<div class="modal fade" id="defaultModal">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-hidden="true">×</button>
						<h4 class="modal-title">알림</h4>
					</div>
					<div class="modal-body">
						<p class="modal-contents"></p>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
					</div>
				</div>
				<!-- /.modal-content -->
			</div>
			<!-- /.modal-dialog -->
		</div>
		<!-- /.modal -->
		<!--// 모달창 -->
		<hr />
		<!-- 본문 들어가는 부분 -->
		<form class="form-horizontal" role="form" method="post"
			action="Findpassword.do" name="frm">
			<table align="center" border="0">
				<c:if test="${msg != null }">
					<tr>
						<td colspan="2" class='errormsg'>${msg}</td>
					</tr>
				</c:if>
			</table>
			<div class="form-group" id="divId">
				<label for="inputId" class="col-lg-2 control-label">아이디</label>
				<div class="col-lg-10">
					<input type="text" class="form-control onlyAlphabetAndNumber"
						id="id" data-rule-required="true"
						placeholder="30자이내의 알파벳, 언더스코어(_), 숫자만 입력 가능합니다." maxlength="30"
						name="id" value="${member.id}">
				</div>
			</div>
		
			<div class="form-group" id="divName">
				<label for="inputName" class="col-lg-2 control-label">이름</label>
				<div class="col-lg-10">
					<input type="text" class="form-control onlyHangul" id="name"
						data-rule-required="true" placeholder="한글만 입력 가능합니다."
						maxlength="15" name="name" value ="${member.name}">
				</div>
			</div>

			<div class="form-group" id="divPhoneNumber">
				<label for="inputPhoneNumber" class="col-lg-2 control-label">휴대폰
					번호</label>
				<div class="col-lg-10">
					<input type="tel" class="form-control onlyNumber" id="phoneNumber"
						data-rule-required="true" placeholder="-를 제외하고 숫자만 입력하세요."
						maxlength="11" name="phoneNumber" value ="${member.phone}">
				</div>
			</div>

			
			<div class="form-group">
				<div class="col-lg-offset-2 col-lg-10">
					<button type="submit" class="btn btn-info">비밀번호 찾기</button>
					비밀번호는 ${member.password}입니다
				</div>
				
			</div>
		</form>

		<!--// 본문 들어가는 부분 -->
		<hr />
		<!-- 푸터 들어가는 부분 -->

		<footer class="text-center">
			<div>
				<p>
					<span class="glyphicon glyphicon-map-marker"></span> (SSAFY) 서울시
					강남구 태헤란로 멀티스퀘어
				</p>
				<p>
					<span class="glyphicon glyphicon-phone"></span> 1544-9001
				</p>
				<p>
					<span class="glyphicon glyphicon-envelope"></span> admin@ssafy.com
				</p>
			</div>
		</footer>
		<!--// 푸터 들어가는 부분 -->
	</div>
</body>
</html>