<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="en" data-bs-theme="auto">
<html>
<head>
	<meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
	<title>여담: 일정 만들기</title>
	
	<!-- kakao Map API -->
    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=${client_id}&libraries=services"></script>

	
	<!-- 부트스트랩 코드 넣기 -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"	integrity="sha512-894YE6QWD5I59HgZOGReFYm4dnWc1Qt5NtvYSaNcOP+u1T9qYdvdihz0PPSiiqn/+/3e7Jo4EaG7TubfWGUrMQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js" integrity="sha512-uto9mlQzrs59VwILcLiRYeLKPPbS/bT71da/OEBYEwcdNUk8jYIy+D176RYoop1Da+f9mvkYrmj5MCLZWEtQuA==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.css" integrity="sha512-aOG0c6nPNzGk+5zjwyJaoRUgCdOrfSDhmMID2u4+OIslr0GjpLKo7Xm0Ao3xmpM4T8AmIouRkqwj1nrdVsLKEQ==" crossorigin="anonymous" referrerpolicy="no-referrer" />
	
	<!-- 참조  css, js 코드 -->
	<link rel="stylesheet" href="<c:url value='/css/travelForm.css'/>">
	
	<%@ page import="java.util.Date"%>
	<%@ page import="java.text.SimpleDateFormat"%>
	<%
		Date nowTime = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String region = request.getParameter("region");
	%>
	
	<!-- 부트스트랩 script(상단용) -->
	<link rel="canonical" href="https://getbootstrap.kr/docs/5.3/examples/sidebars/">
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@docsearch/css@3">
	
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
</head>
<body>
<!-- 비행기 아이콘 -->
<svg xmlns="http://www.w3.org/2000/svg" style="display: none;">
  <symbol id="plain" viewBox="0 0 16 16"> <!-- 비행기 아이콘 -->
    <image class="bi" src="https://cdn-icons-png.flaticon.com/512/7893/7893979.png" style="width: 30; height: 24;"/>
  </symbol>
</svg>

<!-- header - tramvelForm -->
<div class="travel-title">
	<div class="d-flex flex-nowrap border-bottom row">
		<div class="div_title col-sm-7">
			<label class="title col">여행 제목 : </label>
			<input class="text col" name="travelTitle" id="travelTitle">
			<div class="calendar col">
				<label class="calendar_sdate">여행 시작일 : </label>
				<input class="input-date" type="date" name="SDate" id="SDate" value="" min="<%= sdf.format(nowTime) %>">
				<p class="wave">~</p>
				<label class="calendar_edate">여행 종료일 : </label>
				<input class="input-date" type="date" id="EDate" value="EDate" min="<%= sdf.format(nowTime) %>">
			</div>
		</div>
<!-- 		<div class="div_title col"> -->
<!-- 			<select name="area" class="select form-select text-center" aria-label="Default select example"> -->
<!-- 				<option value="1">서울</option> -->
<!-- 				<option value="2">인천</option> -->
<!-- 				<option value="3">대전</option> -->
<!-- 				<option value="4">대구</option> -->
<!-- 				<option value="5">광주</option>				 -->
<!-- 				<option value="6">부산</option>				 -->
<!-- 				<option value="7">울산</option>				 -->
<!-- 				<option value="8">세종</option>				 -->
<!-- 				<option value="31">경기</option>				 -->
<!-- 				<option value="32">강원</option>				 -->
<!-- 			</select> -->
<!-- 		</div> -->
		<div class="div_title col text-end">
			<button class="travel-title_submit" onclick="save()">저장</button>
			<button class="travel-title_close" onclick="if(confirm('그만 만드시겠어요?')) history.back(); else alert('닫기 취소')">닫기</button>
		</div>
	</div>
</div>
<!-- header - tramvelForm 끝 -->
	
	
	<%-- <!-- 일정 만들기 맛집 리스트 -->
	<div>
		<ul class="plan-searchbox-ul">
			<c:forEach var="foodList" items="${foodList }">
				<li class="item" onmouseover="this.style.background='#F1F1F1'" onmouseout="this.style.background=''">
					<img src="${foodList.image2 }" class="tourListImg" width="110px" height="86px">
					<div class="info">
						<h5 class="item-name">${foodList.title }</h5>
						<span class="item-addr">${foodList.addr1 }</span>
					</div>
					<!-- 일정 추가하기 버튼 -->
				</li>
			</c:forEach>
		</ul>
	</div> --%>


	<!-- DAYS box -->
	<div class="plan-daysbox">
		<div class="plan-daysboxtitle">일정</div>
		<!-- 사용자 입력을 받은 만큼 반복문 사용  (days) -->
		<div class="select-job-items1">
			<div style="text-align: -webkit-center;">
				<table id="myTable" class="table">
					<thead>
					</thead>
					<tbody id="tbody"></tbody>
				</table>
			</div>
		</div>

		<input type="hidden" id="day_hidden" value="0">

	</div>
	<!-- DAYS box -->


	<!-- 숙박 클릭 시 리스트 -->
	<!-- (c:forEach 사용한 검색결과 -->
	<div>
		<ul class="plan-searchbox-ul">
			<c:forEach var="hotelList" items="${hotelList }">
				<li class="item" onmouseover="this.style.background='#F1F1F1'"
					onmouseout="this.style.background=''"><img
					src="${hotelList.image2 }" class="tourListImg" width="110px"
					height="86px">
					<div class="info">
						<h5 class="item-name">${hotelList.title }</h5>
						<span class="item-addr">${hotelList.addr1 }</span>
					</div> <!-- 일정 추가하기 버튼 -->
					<div class="col-10 mb-1 small">
						<button class="btn-primary">추가</button>
					</div></li>
			</c:forEach>
		</ul>
	</div>


	<!-- 부트스트랩 script (최하단에 위치) -->
	<script	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>

	<!-- Custom JS -->
	<script src="js/travelForm.js"></script> <!-- DAY? 만들기 -->
</body>
</html>