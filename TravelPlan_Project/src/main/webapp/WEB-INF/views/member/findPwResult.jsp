<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css" />
<title>비밀번호 재설정</title>
<style>
   * { box-sizing:border-box; }
   a { text-decoration: none; }
    form {
        width:400px;
        height:500px;
        display : flex;
        flex-direction: column;
        align-items:center;
        position : absolute;
        top:50%;
        left:50%;
        transform: translate(-50%, -50%) ;
        border: 1px solid rgb(158,158,158);
        border-radius: 10px;
    }
    input[type='text'], input[type='password'] {
        width: 300px;
        height: 40px;
        border : 1px solid rgb(53,99,233);
        border-radius:5px;
        padding: 0 10px;
        margin-bottom: 10px;
    }
    button, #sbtn {
        background-color: rgb(53,99,233);
        color : white;
        width:300px;
        height:50px;
        font-size: 17px;
        border : none;
        border-radius: 5px;
        margin : 20px 0 30px 0;
    }
    #title {
        font-size : 50px;
        margin: 40px 0 30px 0;
    }
    #msg {
        height: 30px;
        text-align:center;
        font-size:16px;
        color:red;
        margin-bottom: 20px;
    }
</style>
</head>
<body>
	<jsp:include page="../common/top.jsp" flush="true" /><br>
	<hr>
	<form action="findPwSuccess" method="post">
		<h3 id="title">비밀번호 재설정</h3>
		<div>
			새로운 비밀번호<br><br>
			<input type="password" name="passwd" id="passwd" placeholder="비밀번호를 입력해주세요."><br>
			새로운 비밀번호 확인<br><br>
			<input type="password" name="pwCheck" id="passwd" placeholder="비밀번호를 한번 더 입력해주세요.">
			<input type="submit" id="sbtn" value="비밀번호 재설정">
		</div>
	</form>
</body>
</html>