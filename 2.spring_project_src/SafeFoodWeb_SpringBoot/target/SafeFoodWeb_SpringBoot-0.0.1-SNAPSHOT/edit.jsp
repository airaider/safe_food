<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
    <head>
    	<style type="text/css">
    		a:visited {
				color: white;	
			}
    	</style>
        <meta charset="utf-8">
        <!-- meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0"/ -->
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>회원 정보 수정</title>
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
	                
	                 $('#delete').click(function () {                 
	                    alert('탈퇴하였습니다.');
	                })
	            });
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
		<jsp:include page="nav.jsp"/>
        <div class="container">
            <!-- 좌우측의 공간 확보 -->
            <!-- 헤더 들어가는 부분 -->
            <div class="row">
                <br /><br /><br /><br />
                <h1 class="text-center">회원 정보 수정</h1>
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
    
            <form class="form-horizontal" role="form" method="post" action="updateMember.do">
    
                <div class="form-group" id="divId">
                    <label for="inputId" class="col-lg-2 control-label">아이디</label>
                    <div class="col-lg-10">
                        <input type="text" class="form-control onlyAlphabetAndNumber" id="id" data-rule-required="true"
                            placeholder="30자이내의 알파벳, 언더스코어(_), 숫자만 입력 가능합니다." maxlength="30" name ="id" value ="${member.id}" readonly>
                    </div>
                </div>
                <div class="form-group" id="divPassword">
                    <label for="inputPassword" class="col-lg-2 control-label">패스워드</label>
                    <div class="col-lg-10">
                        <input type="password" class="form-control" id="password"
                            data-rule-required="true" placeholder="패스워드" maxlength="30" name ="password" value='${member.password}'>
                    </div>
                </div>
                <div class="form-group" id="divPasswordCheck">
                    <label for="inputPasswordCheck" class="col-lg-2 control-label">패스워드 확인</label>
                    <div class="col-lg-10">
                        <input type="password" class="form-control" id="passwordCheck" data-rule-required="true"
                            placeholder="패스워드 확인" maxlength="30" name="passwordCheck" value='${member.password}'>
                    </div>
                </div>
                <div class="form-group" id="divName">
                    <label for="inputName" class="col-lg-2 control-label">이름</label>
                    <div class="col-lg-10">
                        <input type="text" class="form-control onlyHangul" id="name" data-rule-required="true"
                            placeholder="한글만 입력 가능합니다." maxlength="15" name ="name" value = "${member.name}">
                    </div>
                </div>
    
                <div class="form-group" id="divPhoneNumber">
                    <label for="inputPhoneNumber" class="col-lg-2 control-label">휴대폰 번호</label>
                    <div class="col-lg-10">
                        <input type="tel" class="form-control onlyNumber" id="phoneNumber" data-rule-required="true"
                            placeholder="-를 제외하고 숫자만 입력하세요." maxlength="11" name ="phone" value = "${member.phone}">
                    </div>
                </div>
   				<div>
   				${allergys}
   				</div>
                <div class="form-group">
                    <label for="inputEmailReceiveYn" class="col-lg-2 control-label">알레르기</label>
                    <fieldset id="checkbox-group">
                        <legend>Check</legend>
                        <label class="checkbox-inline">
                            <input type="checkbox" name ="allergy" value="대두"  
                            <c:if test="${fn:contains(member.allergy,'대두')}">
                            checked
                            </c:if>
                            >대두
                        </label> 
                        <label class="checkbox-inline">
                            <input type="checkbox" name ="allergy" value="땅콩"
                            <c:if test="${fn:contains(member.allergy,'땅콩')}">
                            checked
                            </c:if>>땅콩
                        </label>
                        <label class="checkbox-inline">
                            <input type="checkbox" name ="allergy" value="우유" 
                            <c:if test="${fn:contains(member.allergy,'우유')}">
                            checked
                            </c:if>>우유
                        </label>
                        <label class="checkbox-inline">
                            <input type="checkbox" name ="allergy" value="게"
                            <c:if test="${fn:contains(member.allergy,'게')}">
                            checked
                            </c:if>>게
                        </label>
                        <label class="checkbox-inline">
                            <input type="checkbox" name ="allergy" value="새우"
                            <c:if test="${fn:contains(member.allergy,'새우')}">
                            checked
                            </c:if>>새우
                        </label>
                        <label class="checkbox-inline">
                            <input type="checkbox" name ="allergy" value="참치"
                            <c:if test="${fn:contains(member.allergy,'참치')}">
                            checked
                            </c:if>>참치
                        </label>
                        <label class="checkbox-inline">
                            <input type="checkbox" name ="allergy" value="연어"
                            <c:if test="${fn:contains(member.allergy,'연어')}">
                            checked
                            </c:if>>연어
                        </label>
                        <label class="checkbox-inline checkbox-">
                            <input type="checkbox" name ="allergy" value="쑥"
                            <c:if test="${fn:contains(member.allergy,'쑥')}">
                            checked
                            </c:if>>쑥
                        </label>
                        <label class="checkbox-inline">
                            <input type="checkbox" name ="allergy" value="소고기"
                            <c:if test="${fn:contains(member.allergy,'소고기')}">
                            checked
                            </c:if>>소고기
                        </label>
                        <label class="checkbox-inline">
                            <input type="checkbox" name ="allergy" value="닭고기"
                            <c:if test="${fn:contains(member.allergy,'닭고기')}">
                            checked
                            </c:if>>닭고기
                        </label>
                        <label class="checkbox-inline">
                            <input type="checkbox" name ="allergy" value="돼지고기"
                            <c:if test="${fn:contains(member.allergy,'돼지고기')}">
                            checked
                            </c:if>>돼지고기
                        </label>
                        <label class="checkbox-inline">
                            <input type="checkbox" name ="allergy" value="복숭아"
                            <c:if test="${fn:contains(member.allergy,'복숭아')}">
                            checked
                            </c:if>>복숭아
                        </label>
                        <label class="checkbox-inline">
                            <input type="checkbox" name ="allergy" value="민들레"
                            <c:if test="${fn:contains(member.allergy,'민들레')}">
                            checked
                            </c:if>>민들레
                        </label>
                        <label class="checkbox-inline">
                            <input type="checkbox" name ="allergy" value="계란흰자"
                            <c:if test="${fn:contains(member.allergy,'계란흰자')}">
                            checked
                            </c:if>>계란흰자
                        </label>
                    </fieldset>
                </div>
                <div class="form-group">
                    <div class="col-lg-offset-2 col-lg-10">
                        <button type="submit" class="btn btn-info">수정</button>
                        <button type="button" class="btn btn-warning" >
                        	<a href="delete.do"  id="delete">탈퇴</a></button>
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