<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import ="java.util.*"    %>
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
		<script type="text/javascript"
			src="https://www.gstatic.com/charts/loader.js"></script>
       	<script type="text/javascript">
			google.charts.load('current', {
				'packages' : [ 'bar' ]
			});
			google.charts.setOnLoadCallback(drawChart);
			function drawChart(){
				let yes;
				var jsonData = $.ajax({
					url : "getAllergyInfo.do",
					data : {
						code : $("#myChart").attr("data-code")
					},
					dataType : "json",
					success : function(data) {
						chartData = new google.visualization.DataTable();
						chartData.addColumn('string', '알러지 성분');
						chartData.addColumn('number', '횟수');
						for (var key in data) {
							chartData.addRow([key, data[key]]);
						}
						var options = {
								chart : {
									title : '내 알레르기 섭취 정보',
									subtitle : '',
									bar : { groupWidth: 30 }
								}
							}
						var chart = new google.charts.Bar(document
								.getElementById('columnchart_material'));
						chart.draw(chartData, google.charts.Bar.convertOptions(options));
					},
					error:function(request,status,error){
						var content = document.getElementById('columnchart_material');
						content.style.height = '10px';
						content.innerHTML = '<h3>등록된 알러지가 없습니다.</h3>'
					}
				})
			}
	       	function pagelist(cpage){
	    		//input 양식의 hidden으로 선언된 page에 요청된 페이지 정보 셋팅 
	    		$("#pageNo").val(cpage);
	    		
	    		var frm = $("#frm");
	    		console.log(frm);
	    		$("#action").val("searchMain.do");
	    		frm.attr('action',"main.do");
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
		<article id="two" class="container">
			<section id="sectionOne">
				<div id="columnchart_material" style="width: 800px; height: 500px;"></div>
			</section>
		</article>
		<br/>
		<br/>
		<br/>
            <section>
            <% int index=0 ;
            	ArrayList<Integer> cnt2 = (ArrayList<Integer>)session.getAttribute("cnt2");
            %>
	            <c:forEach var = "p" items="${list2}">
	                <div class="features2">
		                <article>
		                	<span><img src="${p.img}" class="listimg"></img></span>
			    			<div class='content'>
			    				<h3>
			    					<a class = 'goDetailInfo' href ="detailInfo.do?code=${p.code}" >${p.name}</a>
			    				</h3>
				    			<a class="a"><i class="far fa-calendar-alt"> Feb.2017</i></a> &nbsp; 
				    			<a href="detailInfo.do?code=${p.code}" class="a">  <i class="fas fa-external-link-alt">View detail</i></a>
				    			<hr/>
			    				<p >
		    					<div class="ma">
			    					${p.material}
		    					</div>
		    					<h3>먹은 개수 : <%=cnt2.get(index++) %></h3>
			    			</div>
			    		</article>
	                </div>
	            </c:forEach>
            </section>
        </div>
        <div class="bottom"></div>
        <footer class="text-center">
        	<jsp:include page="copyright.jsp"/>
        </footer>
    </body>
</html>