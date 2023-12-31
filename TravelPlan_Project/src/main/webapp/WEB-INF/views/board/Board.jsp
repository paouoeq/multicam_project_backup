<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<%@ page session="true"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<!-- 합쳐지고 최소화된 최신 CSS -->
<!-- <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css"> -->
<!-- 부가적인 테마 -->
<!-- <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css"> -->
<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<!-- <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA==" crossorigin="anonymous" referrerpolicy="no-referrer" /> -->


<style>
	@font-face {
    	font-family: 'SUIT-Medium';
    	src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_suit@1.0/SUIT-Medium.woff2') format('woff2');
    	font-weight: normal;
    	font-style: normal;
	}
	* {
		font-family: 'SUIT-Medium';
	}
	.boardContainer{
		width: 100%;
		font-size: 14px;
	}
	
	.paging-table{
    width: 100%; /* 테이블이 부모 컨테이너의 100% 가로폭을 차지하도록 설정 */
	}
	.paging{
		text-align: center; /* 셀 내의 텍스트를 수평 가운데 정렬 */
		font-size: 14px;
		font-family: 'SUIT-Medium';
	}
	
	.paging-container {
      width:100%;
      height: 70px;
      display: flex;
      margin-top: 50px;
      margin : auto;
      font-family: 'SUIT-Medium';
    }
    .paging2 {
      color: black;
      width: 100%;
      text-align: center; 
	  font-size: 12px;
    }
    
    td.title   { text-align: left;  }
    td.writer  { text-align: left;  }
    td.viewcnt { text-align: right; }
    td.title:hover {
      text-decoration: underline;
    }
    
    /* 이거 줄지우면 좀 바뀜
    width:300px;
    padding: 10px 12px;
    */
    
    
    tr:nth-child(even) {
      background-color: #f0f0f070;
      
    }
    
    .table_a:link {
	  color : black;
	  text-decoration: none;
	}
	.table_a:visited {
	  color : black;
	  text-decoration: none;
	}
	.table_a:hover {
	  color : black;
	  text-decoration: underline;
	}
	.table_a:active {
	  color : black;
	  text-decoration: none;
	}
    
/*     button{ */
/*       border: none; */
/*       outline: none; */
/*       font-size: 15px; */
/*       padding: 6px 12px; /* Some padding */ */
/*       cursor: pointer; /* Mouse pointer on hover */ */
/*       border-radius: 5px; */
      
/*       margin-left: 5px; */
      
/*       background-color:#3563E9; */
/*       color: white; */
/*       font-family: 'SUIT-Medium'; */
    	
/*     } */
    /* 글쓰기 버튼 스타일 */
	.btnWrite {
       /* Set a font size */
      
      
    }
    .btnWrite:hover {
      text-decoration: underline;
    }

	/* 소거법으로 하나씩 지워보자.*/
	
    table{
      border-top: 2px solid rgb(39, 39, 39);
      width: 100%;
      border-top: 2px solid rgb(39, 39, 39);
      font-family: 'SUIT-Medium';
    }
    .text-center{
    	font-weight: bold;
    }
   

</style>

<script type="text/javascript">
	function go_write() {
		location.href = "WriteRequest?";
	}
</script>
</head>
<body>
	<!--아 게시판을  100%라고 따로 지정을 안해서 작아지는듯-->
	<script type="text/javascript">
		function askYesNo(no) {
			var userConfirmed = confirm("Yes/No로 답해주세요. 계속하시겠습니까?");

			if (userConfirmed) {
				//var Num = parseInt(no, 10);
				
				location.href="delete?contentNum="+no;
				//location.href="delete?contentNum=no";
				alert("사용자가 '예'를 선택했습니다."+no);
			} else {
				alert("사용자가 '아니오'를 선택했습니다.");
			}
		}
		
		function go_update(no,userid) {
			
			//if(userid == null){
			//	alert("로그아웃 상태")
			//	userid = " ";
			//	}
			//var baseUrl = "UpdateRequest";
        	//var queryParams = "contentNum=" + encodeURIComponent(no) + "&userid=" + encodeURIComponent(userid);
        	//var url = baseUrl + "?" + queryParams;
        	
			//location.href="update?contentNum="+no;
			//alert(url);
			
			location.href = "UpdateRequest?contentNum="+no+"&userid="+userid;
		}
	</script>
	<c:set var="DTO" value="${SbDTOList}" />
	<!--{SbDTOList}from model ==> SbDTOList  -->
	
<!-- header -->
<jsp:include page="../common/top.jsp" flush="true" /><br>	
	
<!-- content -->
<div id='wrapper'>
    <div class="boardContainer container">
		<h2 class="text-center">여담 게시판✨</h2><br>
		<!-------------------- 검색 --------------------->	
		<div class="search-container" style="float: right;">
      	<!-- 	<form action="<c:url value="/Board"/>" class="search-form" method="get">  -->
      		<form action="Board" class="search-form row g-1 mb-2" method="get">  
	      		<div class="col-auto">
	        		<select class="search-option form-select form-select-sm" name="searchName">
			          <option value="A" ${PageDTO.searchName == 'A' || PageDTO.searchName=='' ? "selected" : ""}>제목+내용</option>
			          <option value="T" ${PageDTO.searchName == 'T' ? "selected" : ""}>제목만</option>
			          <option value="W" ${PageDTO.searchName == 'W' ? "selected" : ""}>작성자</option>
			        </select>
		        </div>
		        <div class="col-auto">
			        <input type="text" name="searchValue" class="search-input form-control form-control-sm" type="text" value="${PageDTO.searchValue}" placeholder="검색어를 입력해주세요">
		        </div>
		        <div class="col-auto">
			        <input type="submit" class="search-button btn btn-dark btn-sm" value="검색" style="width: 50px;">
			    </div>
      		</form>
    	</div>
		<!-------------------- 검색 --------------------->	
		<table class="table table-hover">
			<thead class="fs-6">
				<tr>
			    </tr>
				<tr>
					<th class="no">번호</th>
					<th>작성자</th>
					<th>제목</th>
					<th>좋아요</th>
					<th>조회수</th>
					<th>작성일</th>

				</tr>
			</thead>
			<tbody class="fs-6">
				<c:forEach var="DTO" items="${content.list}">
					<!--  -->
					<tr>
						<td>${DTO.contentNum}</td>
						<td>${DTO.userID}</td>
						<td class="col-sm-7 col-sm-offset-3"><a class="table_a" href="BoardRetrieve?contentNum=${DTO.contentNum}">${DTO.title}</a></td>
						<td>${DTO.likeContent}</td>
						<td>${DTO.views}</td>
						<td >${DTO.boardDate}</td>

						<!-- ${DTO.contentNum} ${DTO.userID}->
						<!-- <td><a href="delete?no=${list.no}">삭제</a></td> -->
					</tr>
				</c:forEach>
			</tbody>
			
		</table>
		<div class="d-grid gap-2 d-md-flex justify-content-md-end mb-5">
			<button class="rounded btn btn-primary" onclick="go_write()"><i class="fa fa-pencil" ></i>글쓰기</button>
      	</div>
		
    	<div class="paging-container justify-content-center mx-auto">
	    	<nav aria-label="Page navigation example">
			  <ul class="paging2 pagination">
<!-- 	     		<div class="paging2"> -->
		     		<c:set var="perPage" value="${content.perPage}" />
					<c:set var="curPage" value="${content.curPage}" />
					<c:set var="totalCount" value="${content.totalCount}" />
					<c:set var="totalNum" value="${totalCount / perPage}" />
	     		
					<c:set var="searchName" value="${map.searchName}" />
					<c:set var="searchValue" value="${map.searchValue}" />
					
		     		<c:if test="${totalCount % perPage != 0}">
						<c:set var="totalNum" value="${totalNum+1}" />
					</c:if>
	        		<c:if test="${totalCount==null || totalCount==0}">
	          			<div> 게시물이 없습니다. </div>
	        		</c:if>
	        		<!-- 페이지 표시 -->
	        		<c:if test="${totalCount!=null && totalCount!=0}">
	        			<!-- 다음으로 가기 표시 -->
	       				<c:if test="${curPage != 1}">
<%-- 	           		 		<a class="page" href="<c:url value="Board?curPage=${curPage-1}&searchName=${searchName}&searchValue=${searchValue}"/>">&lt;이전</a> --%>
						    <li class="page page-item">
						    	<a class="page-link" href="<c:url value='Board?curPage=${curPage-1}&searchName=${searchName}&searchValue=${searchValue}'/>">
						    		<span aria-hidden="true">&laquo;</span>
						    	</a>
						    </li>
	          			</c:if>
	       				<c:if test="${curPage == 1}">
<%-- 	           		 		<a class="page" href="<c:url value="Board?curPage=${curPage-1}&searchName=${searchName}&searchValue=${searchValue}"/>">&lt;이전</a> --%>
						    <li class="page page-item">
						    	<a class="page-link" href="">
						    		<span aria-hidden="true">&laquo;</span>
						    	</a>
						    </li>
	          			</c:if>
	          			<!-- 페이지 나열 -->
	          			<c:forEach var="i" begin="1" end="${totalNum}">
		          			<c:if test="${curPage == i}">
<%-- 								${i} --%>
							    <li class="page-item active">
						        	<span class="page-link">${i}</span>
						        </li>
							</c:if>
							<c:if test="${curPage != i}">
<%-- 								<a href=" <c:url value='Board?curPage=${i}&searchName=${searchName}&searchValue=${searchValue}'/> "> ${i} </a> <!-- curpage에 url 따라댕겨야 나타낼수잇음 --> --%>
							    <li class="page-item"><a class="page-link" href="<c:url value='Board?curPage=${i}&searchName=${searchName}&searchValue=${searchValue}'/>">${i}</a></li>
							</c:if>
				         </c:forEach>
				         <!-- 이전으로 가기 표시 -->
				         <c:if test="${curPage < totalNum-1}">
<%-- 	            		 	<a class="page" href="<c:url value="Board?curPage=${curPage+1}&searchName=${searchName}&searchValue=${searchValue}"/>">다음&gt;</a> --%>
						    <li class="page page-item">
							    <a class="page-link" href="<c:url value='Board?curPage=${curPage+1}&searchName=${searchName}&searchValue=${searchValue}'/>">
							    	<span aria-hidden="true">&raquo;</span>
							    </a>
						    </li>
	          			 </c:if>
				         <c:if test="${curPage >= totalNum-1}">
<%-- 	            		 	<a class="page" href="<c:url value="Board?curPage=${curPage+1}&searchName=${searchName}&searchValue=${searchValue}"/>">다음&gt;</a> --%>
						    <li class="page page-item">
							    <a class="page-link" href="">
							    	<span aria-hidden="true">&raquo;</span>
							    </a>
						    </li>
	          			 </c:if>
	        		</c:if>
<!-- 	      		</div> -->
			  </ul>
			</nav>
    	</div>
	</div>
</div>

</body>
</html>