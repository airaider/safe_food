<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib  uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
<!DOCTYPE html>
<html>
    <head>
     	<title>메인 페이지</title>
        <meta charset="UTF-8">
        <!-- 합쳐지고 최소화된 최신 CSS -->
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
	       	function pagelist(cpage){
	    		//input 양식의 hidden으로 선언된 page에 요청된 페이지 정보 셋팅 
	    		$("#pageNo").val(cpage);
	    		
	    		var frm = $("#frm");
	    		console.log(frm);
	    		frm.attr('action',"searchMain.do");
	    		frm.submit();
	    	}
	    	$(function() {
	    		//검색 버튼에 이벤트 연결
	    		$('#search').click(function () {   
	    			pagelist(1);
	    		})		
	    	})
   		</script>
	</head>
    <body>
		<jsp:include page = "nav.jsp" />
		<jsp:useBean id="bean" class="com.ssafy.model.dto.FoodPageBean"  scope="request"/>
        <!-- Container (중간 섹션) -->
        <div class="bg-1">
            <div>
                <br /><br /><br /><br /><br /><br />
            </div>
            <div id="band" class="container conta text-center">
                <h1><em>WHAT WE PROVIDE</em></h1>
                <P>건강한 삶을 위한 먹거리 프로젝트</P>
                <br>
                
            </div>
        </div>
        <div class="container conta">
            <section>
	            <%@include file="/index.html" %>
            </section>
        </div>
        <div class="bottom"></div>
        <footer class="text-center">
        	<jsp:include page="copyright.jsp"/>
        </footer>
    </body>
</html>