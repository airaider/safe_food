<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<style type="text/css">
.errormsg {
	font-size: 14px;
	color: red;
}
</style>
<script type="text/javascript" src="js/jquery-3.3.1.js"></script>
<script type="text/javascript">
	<c:if test="${loginMsg !=null }">
		$(function() {
		 $("#modalLoginForm").modal();
		})
	</c:if>
</script>

<nav class="navbar navbar-default navbar-fixed-top">

	<div class="navbar-header">
		<button type="button" class="navbar-toggle" data-toggle="collapse"
			data-target="#myNavbar">
			<span class="icon-bar"></span> <span class="icon-bar"></span> <span
				class="icon-bar"></span>
		</button>
		<a href="main.do"> <img class="navbar-brand2"
			src="img/header-logo.jpg">
		</a>
	</div>
	<div class="collapse navbar-collapse" id="myNavbar">
		<ul class="nav navbar-nav navbar-right">
			<li><a href="notice.jsp">공지 사항</a></li>
			<li><a href="qna.jsp">QnA</a></li>
			<li><a href="foodList.do">상품 정보</a></li>
			<li><a href="bestList.do">베스트 섭취 정보</a></li>
			<li><a href="EatInfo.jsp">요일별 섭취 정보</a></li>
			<c:choose>
				<c:when test="${sessionScope.id !=null }">
					<li><a href="foodadd.do">내 섭취 정보</a></li>
					<li><a href="steam.do">찜 목록</a></li>
					<li><a href="myInfo.do"><span
							class="glyphicon glyphicon-user"></span> My Page</a></li>
					<li><a href="logout.do" id="login"><span
							class="glyphicon glyphicon-log-in"> Logout</span></a></li>
				</c:when>
				<c:otherwise>
					<li><a href="signup.jsp"><span
							class="glyphicon glyphicon-user"></span> Sign Up</a></li>
					<li><a href="" data-toggle="modal"
						data-target="#modalLoginForm" id="login"><span
							class="glyphicon glyphicon-log-in"> Login</span></a></li>
				</c:otherwise>
			</c:choose>
		</ul>
		<div id='loginForm' style="display: none">
			<form method="post" action="logcheck.do?action=login.do">
				<table>
					<tr>
						<td>아 이 디</td>
						<td><input type='text' id='id' name='id' /></td>
					</tr>
					<tr>
						<td>비밀번호</td>
						<td><input type='password' id='password' name='password' /></td>
					</tr>
					<tr>
						<td colspan='2'><input type="submit" value='로그인' /> <input
							type="button" id='hideBt' value='닫기' /></td>
					</tr>
				</table>
			</form>
		</div>
	</div>
	<!-- 로그인 모달창 -->
	<div class="modal fade" id="modalLoginForm" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true"
		data-backdrop="static">
		<div class="modal-dialog" role="document">
			<form method="post" action="login.do">
				<div class="modal-content">
					<div class="modal-header text-center">
						<h4 class="modal-title w-100 font-weight-bold">로그인</h4>
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body mx-3">
						<div class="md-form mb-5">
							<c:if test="${loginMsg !=null }">
								<table align="center" border="0">
									<tr>
										<td colspan="2" class='errormsg'>${loginMsg}</td>
									</tr>
								</table>
							</c:if>
							<i class="fas fa-envelope prefix grey-text"></i> <input
								type="text" id="defaultForm-email" name="id"
								class="form-control validate"> <label data-error="wrong"
								data-success="right" for="defaultForm-email">Your ID</label>
						</div>

						<div class="md-form mb-4">
							<i class="fas fa-lock prefix grey-text"></i> <input
								type="password" id="defaultForm-pass" name="password"
								class="form-control validate"> <label data-error="wrong"
								data-success="right" for="defaultForm-pass">Your
								Password</label>
						</div>

					</div>
					<div class="modal-footer d-flex justify-content-center">
						<button type="submit" id="putlogin">Login</button>
					</div>
					<div class="modal-footer d-flex justify-content-center">
						<button ><a href="Findpassword.jsp" id="findpassword">비밀번호 찾기</a></button>
					</div>
					
				</div>
			</form>
		</div>
	</div>
</nav>
