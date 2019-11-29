<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<title>메인 페이지</title>
<meta charset="UTF-8">
<!-- 합쳐지고 최소화된 최신 CSS -->
<script src="js/chart.js@2.8.js"></script>
<script src="./js/jquery-3.3.1.js"></script>
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

<script type="text/javascript"
	src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript">
	google.charts.load('current', {
		'packages' : [ 'bar' ]
	});
	google.charts.setOnLoadCallback(drawChart);
	google.charts.setOnLoadCallback(drawChart1);
	google.charts.setOnLoadCallback(drawChart2);
	function drawChart1(){
		let yes;
		var jsonData = $.ajax({
			url : "predict1.do",
			data : {
				code : $("#myChart").attr("data-code")
			},
			dataType : "json",
			success : function(data) {
				yes=Object.keys(data)[0]
				console.log(yes)
				console.log(data)
				var data = google.visualization.arrayToDataTable([
					[ '섭취 정보', '칼로리', '탄수화물', '단백질', '지방', '당류', '나트륨',
							'콜레스트롤', '포화 지방산', '트랜스지방' ],
					[ yes, data[Object.keys(data)[0]].kal,
							data[Object.keys(data)[0]].car,
							data[Object.keys(data)[0]].pro,
							data[Object.keys(data)[0]].fat,
							data[Object.keys(data)[0]].sugar,
							data[Object.keys(data)[0]].nat,
							data[Object.keys(data)[0]].kol,
							data[Object.keys(data)[0]].fatacid,
							data[Object.keys(data)[0]].trans ] ]);
				var options = {
						chart : {
							title : '어제 섭취 정보',
							subtitle : yes,
						}
					}
				var chart = new google.charts.Bar(document
						.getElementById('columnchart_material1'));
				chart.draw(data, google.charts.Bar.convertOptions(options));
			}
		})
	}
	function drawChart(){
		let yes;
		var jsonData = $.ajax({
			url : "predict.do",
			data : {
				code : $("#myChart").attr("data-code")
			},
			dataType : "json",
			success : function(data) {
				yes=Object.keys(data)[0]
				console.log(yes)
				console.log(data)
				var data = google.visualization.arrayToDataTable([
					[ '섭취 정보', '칼로리', '탄수화물', '단백질', '지방', '당류', '나트륨',
							'콜레스트롤', '포화 지방산', '트랜스지방' ],
					[ yes, data[Object.keys(data)[0]].kal,
							data[Object.keys(data)[0]].car,
							data[Object.keys(data)[0]].pro,
							data[Object.keys(data)[0]].fat,
							data[Object.keys(data)[0]].sugar,
							data[Object.keys(data)[0]].nat,
							data[Object.keys(data)[0]].kol,
							data[Object.keys(data)[0]].fatacid,
							data[Object.keys(data)[0]].trans ] ]);
				var options = {
						chart : {
							title : '오늘 섭취 정보',
							subtitle : yes,
						}
					}
				var chart = new google.charts.Bar(document
						.getElementById('columnchart_material'));
				chart.draw(data, google.charts.Bar.convertOptions(options));
			}
		})
	}
	function drawChart2(){
		let yes;
		var jsonData = $.ajax({
			url : "predict2.do",
			data : {
				code : $("#myChart").attr("data-code")
			},
			dataType : "json",
			success : function(data) {
				yes=Object.keys(data)[0]
				console.log(yes)
				console.log(data)
				var data = google.visualization.arrayToDataTable([
					[ '섭취 정보', '칼로리', '탄수화물', '단백질', '지방', '당류', '나트륨',
							'콜레스트롤', '포화 지방산', '트랜스지방' ],
					[ yes, data[Object.keys(data)[0]].kal,
							data[Object.keys(data)[0]].car,
							data[Object.keys(data)[0]].pro,
							data[Object.keys(data)[0]].fat,
							data[Object.keys(data)[0]].sugar,
							data[Object.keys(data)[0]].nat,
							data[Object.keys(data)[0]].kol,
							data[Object.keys(data)[0]].fatacid,
							data[Object.keys(data)[0]].trans ] ]);
				var options = {
						chart : {
							title : '그제 섭취 정보',
							subtitle : yes,
						}
					}
				var chart = new google.charts.Bar(document
						.getElementById('columnchart_material2'));
				chart.draw(data, google.charts.Bar.convertOptions(options));
			}
		})
	}
	
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
				<em>요일별 SAFE FOOD</em>
			</h1>
			<P>건강한 삶을 위한 먹거리 프로젝트</P>
			<br>

		</div>
	</div>
	<article id="two" class="container">
		<section id="sectionOne">
			<div id="columnchart_material" style="width: 800px; height: 500px;"></div>
			<div id="columnchart_material1" style="width: 800px; height: 500px;"></div>
			<div id="columnchart_material2" style="width: 800px; height: 500px;"></div>
		</section>
	</article>

	<footer class="text-center">
		<jsp:include page="copyright.jsp" />
	</footer>
</body>
</html>