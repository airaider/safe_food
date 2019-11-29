<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<style type="text/css">
body {
	padding-top: 70px;
}

#two {
	padding-top: 70px;
}
</style>
<script src="./js/jquery-3.3.1.js"></script>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<script src="js/chart.js@2.8.js"></script>

<link rel="stylesheet" href="./css/food.css">
<link rel="stylesheet" href="./css/main.css">
<link rel="stylesheet" href="./font/cssFont/all.css">

<meta charset="UTF-8">
<title>SafeFood | 상품 정보</title>
<script>
	$(function() {
		console.log("!!")
		$.ajax({
			url : 'detail.do'
			, data : {
				code : $('#myChart').attr("data-code")
			}
			, dataType : 'json'
			, success : function(data){
				
				console.log("ASD");
				var ctx = $('#myChart');
				var myDoughnutChart = new Chart(ctx, {
					type: 'doughnut',
					data: {
						labels: ["칼로리", "탄수화물", "단백질", "지방", "당류", "나트륨"
							, "콜레스테롤", "포화지방산", "트랜스지방"],
						datasets: [{
							label: '영양 정보',
							data: [data.calory, data.carbo
								,data.protein, data.fat
								,data.sugar, data.natrium
								,data.chole, data.fattyacid
								,data.transfat]
								
							, backgroundColor: [
								"rgba(255, 51, 51, 0.2)"
								, "rgba(153, 255, 255, 0.2)"
								, "rgba(153, 255, 153, 0.2)"
								, "rgba(255, 153, 255, 0.2)"
								, "rgba(255, 255, 51, 0.2)"
								, "rgba(153, 153, 153, 0.2)"
								, "rgba(153, 153, 255, 0.2)"
								, "rgba(153, 0, 204, 0.2)"
								, "rgba(51, 255, 204, 0.2)"
							]
							, borderColor: [
								"rgba(255, 51, 51, 0.2)"
								, "rgba(153, 255, 255, 0.2)"
								, "rgba(153, 255, 153, 0.2)"
								, "rgba(255, 153, 255, 0.2)"
								, "rgba(255, 255, 51, 0.2)"
								, "rgba(153, 153, 153, 0.2)"
								, "rgba(153, 153, 255, 0.2)"
								, "rgba(153, 0, 204, 0.2)"
								, "rgba(51, 255, 204, 0.2)"
							],
							borderWidth: 1
						}]
					},
					options: {
						maintainAspectRatio: true,
						scales: {
							yAxes: [{
								ticks: {
									beginAtZero: true
								}
							}]
						}
					}
				});
			}
			,error : function(err){
				console.log("error")
				console.log(err);
			}
			
		})
	})
	</script>

</head>

<body>
	<jsp:include page="nav.jsp" />
	<header>
		<br />
		<br />
		<h1 align="center">제품 정보</h1>
		<img>
		<hr />
	</header>
	<!-- Container (중간 섹션) -->
	<article id="one" class="container">
		<section id="sectionOne">
			<div class="col-md-3 col-xs-3">
				<span><img src="${food.img}" class="img-responsive"></span>
			</div>
			<div id="food" class="col-md-9 col-xs-9">
				<table class="table">
					<tr>
						<td class="col-md-2 col-xs-3">제품명</td>
						<td>${food.name}</td>
					</tr>
					<tr>
						<td>제조사</td>
						<td>${food.maker}</td>
					</tr>
					<tr>
						<td>원재료</td>
						<td>${food.material}</td>
					</tr>
					<tr>
						<td>알레르기 성분</td>
						<td>${food.allergy}</td>
					</tr>
				</table>
			</div>
		</section>
	</article>
	<article class="container">
		<div class="col-md-3 col-xs-3"></div>
		<div>
			<fieldset>
				<form method="get" name="form">
							<input type="number" id="eat_cnt" name="eat_cnt" value="1" min="1">
							<input type="hidden" name="code" value="${food.code}">
							<input type="submit" class="btn-info" value="추가" onclick="javascript: form.action='foodadd.do';">
							<input type="submit" class="btn-info" value="찜" onclick="javascript: form.action='steam.do';">
							</form>
			</fieldset>
		</div>
	</article>
	<article id="two" class="container">
		<section id="sectionTwo">
			<div class="col-md-5 col-xs-5">
				<canvas id="myChart" data-code="${food.code}" width="300"
					height="300"></canvas>
			</div>
			<div class="col-md-7 col-xs-7">
				<table class="table">
					<tr>
						<td class="col-md-2 col-xs-3">일일 제공량</td>
						<td class="col-md-4 col-xs-4">${food.supportpereat}</td>
					</tr>
					<tr>
						<td>칼로리</td>
						<td>${food.calory}</td>
					</tr>
					<tr>
						<td>탄수화물</td>
						<td>${food.carbo}</td>
					</tr>
					<tr>
						<td>단백질</td>
						<td>${food.protein}</td>
					</tr>
					<tr>
						<td>지방</td>
						<td>${food.fat}</td>
					</tr>
					<tr>
						<td>당류</td>
						<td>${food.sugar}</td>
					</tr>
					<tr>
						<td>나트륨</td>
						<td>${food.natrium}</td>
					</tr>
					<tr>
						<td>콜레스테롤</td>
						<td>${food.chole}</td>
					</tr>
					<tr>
						<td>포화 지방산</td>
						<td>${food.fattyacid}</td>
					</tr>
					<tr>
						<td>트랜스지방</td>
						<td>${food.transfat}</td>
					</tr>
				</table>
			</div>
		</section>
	</article>
	<footer class="text-center">
		<jsp:include page="copyright.jsp" />
	</footer>
</body>
</html>