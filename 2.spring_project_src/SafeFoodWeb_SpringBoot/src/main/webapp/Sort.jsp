<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript" src="js/jquery-3.3.1.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	$(function() {
		//검색 버튼에 이벤트 연결
		$('#ascend').click(function () {   
			page("ascend");
		})		
		$('#descend').click(function () {   
			page("descend");
		})	
		
	})
  	function page(sort){
  		//input 양식의 hidden으로 선언된 page에 요청된 페이지 정보 셋팅 
  		var frm2 = $("#frm2");
  		$("#tmp").val(sort);
  		frm2.attr('action',"sortMain.do");
  		frm2.submit();
  	}
</script>
</head>
<body>
	<form id ="frm2" align = "right">
		<input type="hidden" id="action2"  name="action"/>
		<input type="hidden" id="tmp"  name="tmp"/>
		<button id = "ascend" class="btn btn-info btn-sm">오름차순</button>
		<button id = "descend" class="btn btn-info btn-sm">내림차순</button>
	</form>
</body>
</html>