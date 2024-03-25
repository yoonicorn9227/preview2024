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
			$("#installBtn").click(function(){
				location.href="index"
			});//#installBtn(등록버튼)
			
			
			$("#ViewCondition").change(function(){
				//var viewColumnsCount = $("#ViewCondition").val(); // 페이지당 보여질 게시글 갯수 변수
				
				SearchFrm.submit();
				
			});//#ViewCondition
			
			$("#searchBtn").click(function(){
				SearchFrm.submit(); //<form action="index" method="get" name="searchFrm"> 태그의 action주소로 이동
			 
			});//#searchBtn(검색어 검색)
			var search_stay=$("#searchWord_hidden").val(); //검색창 검색어 유지기능
			$("#searchWord").val(search_stay); //검색어 유지 및 검색어 보여지는 갯수 유지
			
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
						//♠Ajax실행(삭제)
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
								}//if(성공시)
							},//success
							error:function(){
								alert("실패");
							}//error
							
						});//Ajax
						
					}//if-else(회원선택)
					
				}//if(삭제확인)
			});//#listDelBtn(선택 삭제버튼)
			
			var SelectAll_condition=0; //전체선택 상태(0:전체선택 안됨, 1:전체선택됨)
				$("#SelectAll").click(function(){
				if(SelectAll_condition==0){
					$(".CheckBox").prop("checked",true);
					SelectAll_condition=1
				} else if(SelectAll_condition==1){
					$(".CheckBox").prop("checked",false);
					SelectAll_condition=0
				}//if-else(전체선택  || 전체선택 해제)
			});//#SelectAll(전체선택)
			
			
		
			
		});//제이쿼리 최신
	</script>
	<body>
	<!--▼▼▼ 회원정보 리스트 전체테두리 ▼▼▼ -->
	<div class="table-container">
	<h1 style="font-size: 70px; font-weight: 700;">회원정보 리스트</h1>
	
	<!--검색어 찾기 -->
	<div id="search-container">
		<form action="index" method="get" name="SearchFrm" style="width: 100%; display: flex; justify-content: space-between;">
			<div id="selectBox" style="width: 280px; padding-top: 50px;">
				<input type="button" id="SelectAll" value="전체선택" style="font-weight: 700; margin-right: 10px;">
				<c:if test="${map.gender ==null }">
				<input type="radio" id="All_Gender" value="all" name="gender" checked="checked" style="display: inline-block; vertical-align: middle;"><label for="female" >전체</label>
				</c:if>
				<c:if test="${map.gender=='all' }">
				<input type="radio" id="All_Gender" value="all" name="gender" checked="checked" style="display: inline-block; vertical-align: middle;"><label for="female" >전체</label>
				</c:if>
				<c:if test="${map.gender!='all' }">
				<input type="radio" id="All_Gender" value="all" name="gender" checked="checked" style="display: inline-block; vertical-align: middle;"><label for="female" >전체</label>
				</c:if>
				<c:if test="${map.gender=='남' }">
				<input type="radio" id="Male" value="male" name="gender" checked="checked" style="display: inline-block; vertical-align: middle; color: red;"><label for="male">남자</label>
				</c:if>
				<c:if test="${map.gender!='남' }">
				<input type="radio" id="Male" value="male" name="gender" style="display: inline-block; vertical-align: middle;"><label for="male">남자</label>
				</c:if>
				<c:if test="${map.gender=='여' }">
				<input type="radio" id="Female" value="female" name="gender" checked="checked" style="display: inline-block; vertical-align: middle;"><label for="female" >여자</label>
				</c:if>
				<c:if test="${map.gender!='여' }">
				<input type="radio" id="Female" value="female" name="gender"  style="display: inline-block; vertical-align: middle;"><label for="female" >여자</label>
				</c:if>
			</div>
			<div id="searchSection">
				<select id="ViewCondition" name="viewColumnsCount">
					<c:if test="${map.viewColumnsCount==5 }"> <!-- 게시글 보여지는 갯수 선택유지 -->
						<option value="5" selected="selected">5 개</option>
					</c:if>
					<c:if test="${map.viewColumnsCount!=5 }">
						<option value="5">5 개</option>
					</c:if>
					<c:if test="${map.viewColumnsCount==10 }">
						<option value="10" selected="selected">10 개</option>
					</c:if>
					<c:if test="${map.viewColumnsCount!=10 }">
						<option value="10">10 개</option>
					</c:if>
					<c:if test="${map.viewColumnsCount==20 }">
						<option value="20" selected="selected">20 개</option>
					</c:if>
					<c:if test="${map.viewColumnsCount!=20 }">
						<option value="20">20 개</option>
					</c:if>
				</select>
				<select id="searchCategory" name="SearchCategory">
					<c:if test="${map.SearchCategory ==null}"> <!-- 카테고리 유지 -->
					<option value="All" selected="selected">전체</option>
					</c:if>
					<c:if test="${map.SearchCategory !=null}">
					<option value="All">전체</option>
					</c:if>
					<c:if test="${map.SearchCategory =='Name'}">
					<option value="Name" selected="selected">이름</option>
					</c:if>
					<c:if test="${map.SearchCategory !='Name'}">
					<option value="Name">이름</option>
					</c:if>
					<c:if test="${map.SearchCategory =='Address'}">
					<option value="Address" selected="selected">주소</option>
					</c:if>
					<c:if test="${map.SearchCategory !='Address'}">
					<option value="Address">주소</option>
					</c:if>
					<c:if test="${map.SearchCategory =='Id'}">
					<option value="Id" selected="selected">아이디</option>
					</c:if>
					<c:if test="${map.SearchCategory !='Id'}">
					<option value="Id">아이디</option>
					</c:if>
					<c:if test="${map.SearchCategory =='Phone'}">
					<option value="Phone" selected="selected">연락처</option>
					</c:if>
					<c:if test="${map.SearchCategory !='Phone'}">
					<option value="Phone">연락처</option>
					</c:if>
					<c:if test="${map.SearchCategory =='Pnumber'}">
					<option value="Pnumber" selected="selected">주민번호</option>
					</c:if>
					<c:if test="${map.SearchCategory !='Pnumber'}">
					<option value="Pnumber">주민번호</option>
					</c:if>
				</select>
					<input type="text" id="searchWord" name="SearchWord" placeholder=" ※검색어를 입력하세요.">
					<input type="hidden" id="searchWord_hidden" value="${map.SearchWord }"> <!-- 검색어 검색창 유지기능  -->
					<input type="button" id="searchBtn" value="검 색">
			</form>
		</div>
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
			        <c:if test="${ymdto.gender=='남'}">
			        <td style="color: blue; font-weight: 700">${ymdto.gender}</td>
			        </c:if>
			        <c:if test="${ymdto.gender=='여'}">
			        <td style="color: red; font-weight: 700">${ymdto.gender}</td>
			        </c:if>
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
	  	<a href="index?page=1&gender=${map.gender }&viewColumnsCount=${map.viewColumnsCount}&SearchCategory=${map.SearchCategory}&SearchWord=${map.SearchWord}"><li class="num"><i class="fa fa-backward" aria-hidden="true"></i></li></a>
	  	<!--이전 페이지-->
	  	<c:if test="${map.page<=1 }">
	  		<li class="num"><i class="fa fa-chevron-circle-left" aria-hidden="true"></i></li>
	  	</c:if>
	  	<c:if test="${map.page>1 }">
	  		<a href="index?page=${map.page-1 }&gender=${map.gender }&viewColumnsCount=${map.viewColumnsCount}&SearchCategory=${map.SearchCategory}&SearchWord=${map.SearchWord}"><li class="num"><i class="fa fa-chevron-circle-left" aria-hidden="true"></i></li></a>
	  	</c:if>
	  	
	  	<!--페이지 넘버링-->
	  	<c:forEach var="i" begin="${map.startPageNum}" end="${map.endPageNum }" step="1">
			<c:if test="${map.page==i }">
		  		 <li class="num numOn">${i}</li>
			</c:if>	  		
			<c:if test="${map.page!=i }">
		  		<a href="index?page=${i }&gender=${map.gender }&viewColumnsCount=${map.viewColumnsCount}&SearchCategory=${map.SearchCategory}&SearchWord=${map.SearchWord}" style="text-decoration: none;"><li class="num">${i}</li></a>
			</c:if>	  		
	  	</c:forEach>
	  	
	  	<!--다음 페이지-->
	  	<c:if test="${map.page<map.maxPage }">
	  		<a href="index?page=${map.page+1 }&gender=${map.gender }&viewColumnsCount=${map.viewColumnsCount}&SearchCategory=${map.SearchCategory}&SearchWord=${map.SearchWord}"><li class="num"><i class="fa fa-chevron-circle-right" aria-hidden="true"></i></li></a>
	  	</c:if>
	  	<c:if test="${map.page>=map.maxPage }">
	  		<li class="num"><i class="fa fa-chevron-circle-right" aria-hidden="true"></i></li>
	  	</c:if>
	  	
	  	<!-- 마지막 페이지 -->
	  	<a href="index?page=${map.maxPage }&gender=${map.gender }&viewColumnsCount=${map.viewColumnsCount}&SearchCategory=${map.SearchCategory}&SearchWord=${map.SearchWord}"><li class="num"><i class="fa fa-forward" aria-hidden="true"></i></li></a>
	  </ul>
	  <!--페이지 넘버링 끝 -->
	<!--▣ 버튼 ▣ -->
	<div class="button-container">
	  <input type="button" id="installBtn" value="실행">
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