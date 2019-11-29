<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib  uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
 <head>
  	<title>Safe food | 상품정보</title>
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
	 		frm.attr('action',"searchFood.do");
	 		frm.submit();
 		}
    </script>
 </head>
 <body>
	<jsp:include page = "nav.jsp" />
      <!-- Container (중간 섹션) -->
    <div class="bg-1">
        <div>
            <br /><br /><br /><br /><br /><br />
        </div>
        <div id="band" class="container text-center">
           <h1><em>WHAT WE PROVIDE</em></h1>
           <P>건강한 삶을 위한 먹거리 프로젝트</P>
           <br>
            <div class="row bg-2 text-center">
               <form id ="frm">
               	<input type="hidden" id="pageNo"  name="pageNo"  value="${bean.pageNo}"/>
              	 	<input type="hidden" id="action"  name="action"/>
                <div class="form-group col-md-3">
                    <label for="sel1">검색 조건</label>
                    <select class="form-control" id="key" name="key">
                    	<option value="all">---선택하세요---</option>
                        <option value="name">상품명</option>
                        <option value="material">성분</option>
                    </select>
                </div>

                <div class="form-group col-md-6">
                    <label for="keyword">검색 단어</label>
                    <input type="text" class="form-control" id="word" name="word" value = "${bean.word}">
                </div>
                <div class="form-group col-sm-1">
                    <br/>
                     
                     <button type="submit" class="btn btn-info" id="search" onclick="pagelist(1)">
                     	<span class="glyphicon glyphicon-search"></span>
                     </button>
                </div>
               </form>
           </div>
        </div>
    </div>
    <jsp:include page="Sort_food.jsp"/>
    <div class="container2">
        <!-- Section -->
        <section>
           <div class="features">
       	   <c:forEach var = "p" items="${list}">
          	<article><span><img src="${p.img}" class="listimg"></img></span>
			<div class='content'>
				<div class='tit'>
					<h3><a href ='detailInfo.do?code=${p.code}'>${p.name}</a></h3>
					<a class="a"><i class="far fa-calendar-alt"> Feb.2017</i></a> &nbsp; 
					<a href="detailInfo.do?code=${p.code}" class="a"><i class="fas fa-external-link-alt">  View detail</i></a>
				</div>
					<p>
					<div class="ma">${p.material}</div>
					<div class="b">
						<form method="get" name="form">
							<input type="number" id="eat_cnt" name="eat_cnt" value="1" min="1">
							<input type="hidden" name="code" value="${p.code}">
							<input type="submit" class="btn-info" value="추가" onclick="javascript: form.action='foodadd.do';">
							<input type="submit" class="btn-info" value="찜" onclick="javascript: form.action='steam.do';">
							</form>
					</div>
			</div>
		   </article>
       	  </c:forEach>
         </div>
        </section>
    </div>
    <div class="bottom"></div>
	<footer class="text-center">
     	<jsp:include page="copyright.jsp"/>
    </footer>
  </body>
</html>