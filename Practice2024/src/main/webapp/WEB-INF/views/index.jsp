<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>  
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
	<c:if test="${session_id==null }">
	 	<script>
	 		alert("※ 로그인 해주세요.")
	 		location.href="login";
	 	</script>
	</c:if>
	<head>
		<meta charset="UTF-8">
		<title>회원리스트</title>
	</head>
	<!-- ♣♣♣ CSS ♣♣♣ -->
	<link href="../css/index.css" rel="stylesheet">
	
	<!-- ♣♣♣ font ♣♣♣ -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
	
	<!-- JQuery 최신 -->
	<script src="http://code.jquery.com/jquery-latest.min.js"></script>
	
	<!--◁◀◁◀ Header ▶▷▶▷ -->
	<%@ include file="/WEB-INF/views/include/sidebar.jsp"%>
	<%@ include file="/WEB-INF/views/include/header.jsp"%>
	<!--◁◀◁◀ Header ▶▷▶▷ -->
	
	<script>
		$(function(){
			$("#listInsertBtn").click(function(){
				alert("test");
			});//#listInsertBtn(등록버튼)
			
			$("#listDelBtn").click(function(){
				if(confirm("삭제 하시겠습니까?")){
					
					//선택된 번호 배열선언
					var selectArr=[];
					//선택된 Ymno위치값
					var SelectYmno = $(this).parent().prev().prev().find(".CheckBox:checked").map(function() {return this.id;}).get();
					
			        // SelectYmno 배열을 selectArr에 추가
			        selectArr = selectArr.concat(SelectYmno);
					
					var Select_length = SelectYmno.length; //선택된 Ymno 갯수
					
					alert(selectArr)
					
					if(Select_length<1){
						alert("선택된 회원정보가 없습니다.");
					} else {
						alert(Select_length);
						//♠Ajax실행
						$.ajax({
							url:"/member/mDelete",
							type:"post",
							contentType: "application/json", //contentType : 데이터를 전송하는 타입
							data: JSON.stringify(selectArr), // selectArr을 JSON 문자열로 변환하여 전송
							dataType:"text", //데이터를 받는 타입
							traditional:true,
							success:function(data){
								if(data=="성공"){
								alert("회원정보가 삭제되었습니다.");
								location.href="/";
								}
							},//success
							error:function(){
								alert("실패");
							}//error
							
						});//Ajax
						
						
						
					}//if-else(회원선택)
					
				}//if(삭제확인)
			});//#listInsertBtn(등록버튼)
			
			var SelectAll_condition=0; //전체선택 상태(0:전체선택 안됨, 1:전체선택됨)
			$("#SelectAll").click(function(){
				alert("전체선택 버튼 test");
				
				if(SelectAll_condition==0){
					$(".CheckBox").prop("checked",true);
					SelectAll_condition=1
				} else if(SelectAll_condition==1){
					$(".CheckBox").prop("checked",false);
					SelectAll_condition=0
				}//if-else(전체선택  || 전체선택 해제)
				
			});//#SelectAll(전체선택)
			
			$("#searchBtn").click(function(){
				alert("검색어 test");
				
				//alert($("#searchWord").val());
				$("#searchWord").val();
				 
			});//#searchBtn(검색어)
			
		});//제이쿼리 최신
	</script>
	<body>
	<!--▼▼▼ 회원정보 리스트 전체테두리 ▼▼▼ -->
	<div class="table-container">
	<h1 style="font-size: 70px; font-weight: 700;">회원정보 리스트</h1>
	
	<!--검색어 찾기 -->
	<div id="search-container">
	
	<div id="seletBox" style="width: 250px; padding-top: 50px;">
		<input type="button" id="SelectAll" value="전체선택" style="font-weight: 700; margin-right: 10px;">
		<input type="radio" id="Male" value="male" name="gender" style="display: inline-block; vertical-align: middle;"><label for="male">남자</label>
		<input type="radio" id="Female" value="female" name="gender" style="display: inline-block; vertical-align: middle;"><label for="female" >여자</label>
	</div>
		<form action="searchList" method="get">
			<div id="searchSection">
				<select id="ViewCondition">
					<option value="5">5 개</option>
					<option value="10">10 개</option>
					<option value="20">20 개</option>
				</select>
				<select id="searchCategory">
					<option value="all">전체</option>
					<option value="Name">이름</option>
					<option value="Id">아이디</option>
					<option value="PhoneNum">연락처</option>
					<option value="Pnum">주민번호</option>
				</select>
				<input type="text" id="searchWord" name="" placeholder=" ※검색어를 입력하세요.">
				<input type="button" id="searchBtn" value="검 색">
			</div>
		</form>
	</div>
	<!--검색어 찾기 끝 -->
	
	<hr style="border: 2px solid #14213d; margin-bottom: 20px;">
	  <table style="border-top: 3px solid #14213d;">
	    <thead>
	    <colgroup>
		    <col width="4%">
		    <col width="6%">
		    <col width="6%">
		    <col width="6%">
		    <col width="4%">
		    <col width="10%">
		    <col width="23%">
		    <col width="12%">
		    <col width="10%">
		    <col width="6%">
		    <col width="12%">
	    </colgroup>
	      <tr>
	        <th>번 호</th>
	        <th>아이디</th>
	        <th>비밀번호</th>
	        <th>성 명</th>
	        <th>성 별</th>
	        <th>연락처</th>
	        <th>주&nbsp;&nbsp;소</th>
	        <th>E-mail</th>
	        <th>주민번호</th>
	        <th>접속횟수</th>
	        <th>최근접속</th>
	      </tr>
	    </thead>
	    <form action="mDelete" method="post" name="memberFrm">
	    <tbody style="border-bottom: 2px solid #14213d;">
	      <c:forEach var="ymdto" items="${map.list}">
		      <tr>
		        <td>
			        <input type="checkbox" class="CheckBox" id="${ymdto.ymno }" name="memberYmno">
		        </td>
		        <td id="ID">${ymdto.id }</td>
		        <td>${ymdto.pw }</td>
		        <td>${ymdto.name }</td>
		        <td>${ymdto.gender}</td>
		        <td>${ymdto.phone}</td>
		        <td>${ymdto.address}</td>
		        <td>${ymdto.email}</td>
		        <td>${ymdto.pnumber}</td>
		        <td>${ymdto.login_num}</td>
		        <td><fmt:formatDate value="${ymdto.recent_time}" pattern="YYYY-MM-dd HH:mm:ss"/> </td>
		      </tr>
	      </c:forEach>
	    </tbody>
	    </form>
	  </table>
	  
	  <!--페이지 넘버링 -->
	  <ul id="PageNum" style="display: flex; list-style: none;">
	  	<!--첫번째 페이지-->
	  	<a href="index?page=1"><li class="num"><i class="fa fa-backward" aria-hidden="true"></i></li></a>
	  	<!--이전 페이지-->
	  	<c:if test="${map.page<=1 }">
	  		<li class="num"><i class="fa fa-chevron-circle-left" aria-hidden="true"></i></li>
	  	</c:if>
	  	<c:if test="${map.page>1 }">
	  		<a href="index?page=${map.page-1 }"><li class="num"><i class="fa fa-chevron-circle-left" aria-hidden="true"></i></li></a>
	  	</c:if>
	  	
	  	<!--페이지 넘버링-->
	  	<c:forEach var="i" begin="${map.startPageNum}" end="${map.endPageNum }" step="1">
			<c:if test="${map.page==i }">
		  		 <li class="num numOn">${i}</li>
			</c:if>	  		
			<c:if test="${map.page!=i }">
		  		<a href="index?page=${i }" style="text-decoration: none;"><li class="num">${i}</li></a>
			</c:if>	  		
	  	</c:forEach>
	  	
	  	<!--다음 페이지-->
	  	<c:if test="${map.page<map.maxPage }">
	  		<a href="index?page=${map.page+1 }"><li class="num"><i class="fa fa-chevron-circle-right" aria-hidden="true"></i></li></a>
	  	</c:if>
	  	<c:if test="${map.page>=map.maxPage }">
	  		<li class="num"><i class="fa fa-chevron-circle-right" aria-hidden="true"></i></li>
	  	</c:if>
	  	
	  	<!-- 마지막 페이지 -->
	  	<a href="index?page=${map.maxPage }"><li class="num"><i class="fa fa-forward" aria-hidden="true"></i></li></a>
	  </ul>
	  <!--페이지 넘버링 끝 -->
	<!--▣ 버튼 ▣ -->
	<div class="button-container">
	  <input type="button" id="listInsertBtn" value="등록">
	  <input type="button" id="listDelBtn" value="삭제">
	</div>
	<!--▣ 버튼 ▣-->
	</div>
	<!-- ▲▲▲ 회원정보 리스트 전체 테두리 끝 ▲▲▲-->
	
	
	</body>
	
	<!--◁◀◁◀ Footer ▶▷▶▷ -->
	<%@ include file="/WEB-INF/views/include/footer.jsp"%>
	<!--◁◀◁◀ Footer ▶▷▶▷ -->
</html>