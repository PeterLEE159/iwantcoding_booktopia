
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html lang="ko">
<head>
<meta charset="utf-8">
<link rel="stylesheet" href="/css/style.css">
<title>북토피아: 도서 상세정보</title>
</head>
<body>  
<%@ include file="/common/navbar.jsp" %>

   <div class="container">
    	<h1>도서 정보</h1>        
   </div>
 <div class="container">
	<div class="row">
       <div class="col-sm-2">
          <img src="../images/15012323206700.jpg" style="width: 150px;">
       </div>
       <div class="col-sm-7">               
       <table class="table table-condensed">
          <tbody>
             <tr>
                <th><h4><strong>펭귄의 사생활</strong></h4></th>      
                
             </tr>
             <tr>
                <th>저자</th>
                <td>와타나베 유키 | 윤재 역</td>            
             </tr>
             <tr>
                <th>출판사</th>
                <td>니케북스</td>            
             </tr>
             <tr>
                <th>발행일</th>
                <td>2017</td>            
             </tr>
             <tr>
                <th>장르</th>
                <td>힐링펭귄</td>            
             </tr>
             <tr>
                <th>자료상태</th>
                <td>대출중 <a class="btn btn-default btn-xs">예약하기</a> | 대출반납예정일 : 2017-09-15</td>            
             </tr>
             <tr>
                <th>책 미리보기</th>
                <td><button class="btn btn-default btn-xs">책 미리보기</button></td>            
             </tr>
             <tr>
                <th>추천</th>
                <td> <span class="glyphicon glyphicon-thumbs-up"> 10</span> <a class="btn btn-primary btn-xs">추천하기</a></td>            
             </tr>
          </tbody>
       </table>
     </div>
   </div>   
   <div class="col-sm-9">
      <hr class="colorgraph">
      <h5><strong>책 소개</strong></h5>
      <p>바이오깅으로 야생 동물의 일상을 훔쳐보다!
            야생동물들은 어디로, 뭘 하러 가는걸까? 『펭귄의 사생활』은 야마자키 상을 수상한 와타나베 유키가 바이오로깅으로 야생동물을 관찰한 기록이다.
            ‘바이오로깅(BIO-LOGGING)'은 동물의 몸에 센서나 비디오카메라같은 다양한 기기를 부착해 인간의 눈을 대신해 해당 동물의 행동을 조사하는 방법이다.
            저자는 이 책을 통해 바이오로깅이란 무엇이고 바이오로깅을 통해 야생동물의 사생활을 관찰한 결과를 유머러스하게 들려준다.
            이 책의 목적은 바이오로깅으로 알아낸 야생 동물들의 다이내믹한 움직임을 소개하고, 그 배경에 있는 메커니즘과 진화의 의의를 밝혀내는 것이다.
            바이오로깅은 보편성을 중시하는 물리학+다양성의 학문인 생태학의 융합의 과학이다. 저자는 동물을 관찰하는 관찰자 입장을 넘어 생명에 대한 
            근원적인 질문을 던지는 것, 왜 그런 행동을 하는지 메커니즘과 진화의 의의를 밝힌다. 사랑스러운 아델리펭귄을 시작으로 무섭게 생긴 그린란드 상어, 
            큰 몸둘레의 바이칼바다표범까지 저자가 직접 체험한 글을 재미있고 기발하게 들려주어 어렵지 않게 바이오로깅을 소개한다.
     </p>
     <div class="text-center">
	    <a href="/searchingbook.jsp" class="btn btn-primary">돌아가기</a>     
     </div>
   </div>
	   
 </div>
<%@ include file="/common/footer.jsp" %>
</body>
</html>