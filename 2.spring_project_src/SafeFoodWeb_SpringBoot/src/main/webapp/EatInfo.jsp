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
google.charts.load('current', {'packages':['bar']});
google.charts.setOnLoadCallback(drawChart);

function drawChart() {
	$.ajax({
		url : "pp.do",
		dataType : "json",
		success : function(data) {
			var g = data[Object.keys(data)[0]]
			var t = data[Object.keys(data)[1]]
			var k = data[Object.keys(data)[2]]
			var gdata = google.visualization.arrayToDataTable([
				[ '섭취 정보', '칼로리/10', '탄수화물', '단백질', '지방', '당류', '나트륨/10',
					'콜레스트롤', '포화 지방산', '트랜스지방'],
				[ Object.keys(data)[0], g.kal/10,
					g.car,
					g.pro,
					g.fat,
					g.sugar,
					g.nat/10,
					g.kol,
					g.fatacid,
					g.trans ],
				[ Object.keys(data)[1], t.kal/10,
					t.car,
					t.pro,
					t.fat,
					t.sugar,
					t.nat/10,
					t.kol,
					t.fatacid,
					t.trans ],
				[ Object.keys(data)[2], k.kal/10,
					k.car,
					k.pro,
					k.fat,
					k.sugar,
					k.nat/10,
					k.kol,
					k.fatacid,
					k.trans ]
			])
			var options = {
			    chart: {
			      title: '요일별 섭취 정보',
			      subtitle: '최근 3일',
			    },
			    bars: 'horizontal', 
			    	bar: { groupWidth: "90%" }
			  }
			  var chart = new google.charts.Bar(document.getElementById('columnchart_material'))
			  chart.draw(gdata, google.charts.Bar.convertOptions(options))
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
			<div id="columnchart_material" style="width: 1400px; height: 700px;"></div>
		</section>
	</article>

	<footer class="text-center">
		<jsp:include page="copyright.jsp" />
	</footer>
</body>
</html>