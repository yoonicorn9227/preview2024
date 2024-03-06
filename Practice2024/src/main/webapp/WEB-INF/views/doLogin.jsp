<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>doLogin</title>
	</head>
	<script>
		if(${result==1}){
			alert(" ※ 로그인 되었습니다.");
			location.href="/";
		} else {
			alert(" ※ 아이디 혹은 비밀번호가 일치하지 않습니다.")
			location.href="login";
		}//로그인 확인(회원 일치 : 1 미일치 : 0)
	</script>
</html>