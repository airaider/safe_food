<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
    <head>
        <meta charset="utf-8">
        <!-- meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0"/ -->
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>회원 정보 조회</title>
        <!-- Bootstrap -->
        <script src="./js/jquery-3.3.1.js"></script>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">

        <!-- 부가적인 테마 -->
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">

        <!-- 합쳐지고 최소화된 최신 자바스크립트 -->
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
        <link rel="stylesheet" href="./css/food.css">
        <link rel="stylesheet" href="./css/main.css">
        <link rel="stylesheet" href="./font/cssFont/all.css">
<script type="text/javascript">
$(function () {
    var isLogin = false;
        user = getCookie("username");
        if (user != "") {
            $('#id').empty();
            $('#id').text(user);
            $('#sign').text(user + " 회원 정보");
            $('#login').text("로그아웃");
            $('#sign').attr("href", "myInfo.html");
            $('#login').attr("data-target", "#");
            isLogin = true;
        } else {
            $('#sign').attr("href", "signup.html");
            $('#login').attr("data-target", "#modalLoginForm");

        }
        $('#login').click(function () {
            if (isLogin) {
                document.cookie = 'username=;expires=Wed; 01 Jan 1970;path=/';
                alert('로그아웃 됐습니다.');
            }
        })
        $('#putlogin').click(function () {
            var user = $('#defaultForm-email').val()
            if (user != "" && user != null) {
                setCookie("username", user, 30);
            }
            alert('로그인 됐습니다.');
            location.reload();
        })
    });
	
    function setCookie(cname, cvalue, exdays) {
        var d = new Date();
        d.setTime(d.getTime() + (exdays * 24 * 60 * 60 * 1000));
        var expires = "expires=" + d.toGMTString();
        document.cookie = cname + "=" + cvalue + ";" + expires + ";path=/";
    }
    function getCookie(cname) {
        var name = cname + "=";
        var decodedCookie = decodeURIComponent(document.cookie);
        var ca = decodedCookie.split(';');
        for (var i = 0; i < ca.length; i++) {
            var c = ca[i];
            while (c.charAt(0) == ' ') {
                c = c.substring(1);
            }
            if (c.indexOf(name) == 0) {
                return c.substring(name.length, c.length);
            }
        }
        return "";
    }
</script>
    </head>
    <body>
		<jsp:include page = "nav.jsp" />
        <div class="container">
            <!-- 좌우측의 공간 확보 -->
            <!-- 헤더 들어가는 부분 -->
           <div class="row">
               <br /><br /><br /><br />
               <h1 class="text-center">회원 정보 조회</h1>
           </div>
           <!--// 헤더 들어가는 부분 -->
   
           <!-- 모달창 -->
           <div class="modal fade" id="defaultModal">
               <div class="modal-dialog">
                   <div class="modal-content">
                       <div class="modal-header">
                           <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                           <h4 class="modal-title">알림</h4>
                       </div>
                       <div class="modal-body">
                           <p class="modal-contents"></p>
                       </div>
                       <div class="modal-footer">
                           <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
                       </div>
                   </div><!-- /.modal-content -->
               </div><!-- /.modal-dialog -->
           </div><!-- /.modal -->
           <!--// 모달창 -->
           <hr />
           <!-- 본문 들어가는 부분 -->
   
           <form class="form-horizontal" role="form" 	method="post" action = "memberUpdateForm.do">
   
               <div class="form-group" id="divId">
                   <label for="inputId" class="col-lg-2 control-label">아이디</label>
                   <div class="col-lg-10">
                   	<span id="id">${member.id}</span>
                   </div>
               </div>
               <div class="form-group" id="divName">
                   <label for="inputName" class="col-lg-2 control-label">이름</label>
                   <div class="col-lg-10">
                   	<span id="name">${member.name}</span>
                   </div>
               </div>
   
               <div class="form-group" id="divPhoneNumber">
                   <label for="inputPhoneNumber" class="col-lg-2 control-label">휴대폰 번호</label>
                   <div class="col-lg-10">
                   	<span id="phoneNumber">${member.phone}</span>
                   </div>
               </div>
   
               <div class="form-group">
               	<label for="inputPhoneNumber" class="col-lg-2 control-label">알레르기</label>
                   <div class="col-lg-10">
                   	<span id = "alergy">${member.allergy}</span>
                   </div>
               </div>
               <div class="form-group">
                   <div class="col-lg-offset-2 col-lg-10">
                       <button type="submit" class="btn btn-info">수정</button>
                   </div>
               </div>
           </form>
   
           <!--// 본문 들어가는 부분 -->
           <hr />
           <!-- 푸터 들어가는 부분 -->
   
           <footer class="text-center">
               <div>
                   <p><span class="glyphicon glyphicon-map-marker"></span> (SSAFY) 서울시 강남구 태헤란로 멀티스퀘어</p>
                   <p><span class="glyphicon glyphicon-phone"></span> 1544-9001</p>
                   <p><span class="glyphicon glyphicon-envelope"></span> admin@ssafy.com</p>
               </div>
           </footer>
           <!--// 푸터 들어가는 부분 -->
       </div>
    </body>
</html>