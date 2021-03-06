<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<title>메인 페이지</title>
<meta charset="UTF-8">
<!-- 합쳐지고 최소화된 최신 CSS -->
<script src="./js/jquery-3.3.1.js"></script>
<script src="js/chart.js@2.8.js"></script>
<style>
.input-color {
    position: relative;
}
.input-color input {
    padding-left: 20px;
}
.input-color .color-box {
    width: 10px;
    height: 10px;
    display: inline-block;
    background-color: #ccc;
    position: absolute;
    left: 5px;
    top: 5px;
}
</style>
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
	function pagelist(cpage) {
		//input 양식의 hidden으로 선언된 page에 요청된 페이지 정보 셋팅 
		$("#pageNo").val(cpage);

		var frm = $("#frm");
		console.log(frm);
		$("#action").val("searchMain.do");
		frm.attr('action', "main.do");
		frm.submit();
	}
	$(function() {
		var backgroundColor = [ "#30A9DE",
			"#EFDC05",
			"#E53A40",
			"#F68657",
			"#75D701"]
	console.log(backgroundColor)
		//검색 버튼에 이벤트 연결
		$('#search').click(function() {
			pagelist(1);
		})

		$.ajax({
			url : 'bb.do',
			data : {
				code : $('#myChart').attr("data-code")
			},
			dataType : 'json',
			success : function(data) {

				console.log("ASD");
				var ctx = $('#myChart');
				console.log(Object.keys(data)[0])
				console.log(data[Object.keys(data)[0]])
				var myDoughnutChart = new Chart(ctx, {
					type : 'doughnut',
					data : {
						labels : [ Object.keys(data)[0], Object.keys(data)[1], Object.keys(data)[2], Object.keys(data)[3], Object.keys(data)[4]],
						datasets : [ {
							label : '영양 정보',
							
							backgroundColor : [ "#30A9DE",
									"#EFDC05",
									"#E53A40",
									"#F68657",
									"#75D701"],
							borderColor : [ "#30A9DE",
									"#EFDC05",
									"#E53A40",
									"#F68657",
									"#75D701"],
							borderWidth : 1,
							data : [ data[Object.keys(data)[0]], data[Object.keys(data)[1]], data[Object.keys(data)[2]],
								data[Object.keys(data)[3]], data[Object.keys(data)[4]]]

							
						} ]
					},
					options : {
						maintainAspectRatio : true,
						scales : {
							yAxes : [ {
								ticks : {
									beginAtZero : true
								}
							} ]
						}
					}
				});
			},
			error : function(err) {
				console.log("error")
				console.log(err);
			}

		})

	})
</script>
</head>
<body>
	<jsp:include page="nav.jsp" />
	<jsp:useBean id="bean" class="com.ssafy.model.dto.FoodPageBean"
		scope="request" />
	<!-- Container (중간 섹션) -->
	<div class="bg-1">
		<div>
			<br /> <br /> <br /> <br /> <br /> <br />
		</div>
		<div id="band" class="container conta text-center">
			<h1>
				<em>TOP 5 SAFE FOOD</em>
			</h1>
			<P>건강한 삶을 위한 먹거리 프로젝트</P>
			<br>

		</div>
	</div>
	<article id="two" class="container">
	<c:if test="${sessionScope.id !=null }">
		<section id="sectionTwo">
		
			<div class="col-md-5 col-xs-5">
				<canvas id="myChart" data-code = "${food.code}" width="300" height="300"></canvas>
			</div>
			<div class="col-md-7 col-xs-7">
				<table class = "table">
					<tr>
						<td class = "col-md-3 col-xs-4">TOP 5 식품 섭취</td>
					</tr>
					<% int index=0 ;
            	ArrayList<Integer> cnt2 = (ArrayList<Integer>)session.getAttribute("bcnt");
            %>
					<c:forEach var="best" items="${blist}">
						<tr>
						<td>&num;<%=(index+1) %></td>
						<td id="color"></td>
						<td><a href="detailInfo.do?code=${best.code}" class="a">  <i class="fas fa-external-link-alt">${best.name}</i></a></td>
						<td><%=cnt2.get(index++) %></td>
					</tr>
					</c:forEach>
				</table>
			</div>
		</section>
	</c:if>
	</article>
	<footer class="text-center">
		<jsp:include page="copyright.jsp" />
	</footer>
</body>
</html>