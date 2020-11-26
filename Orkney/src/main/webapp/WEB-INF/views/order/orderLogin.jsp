<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>

<jsp:include page="/WEB-INF/views/common/header.jsp">		
	<jsp:param name="title" value="주문관리 로그인" />
</jsp:include>
<link rel="stylesheet" href="${path}/resources/css/order/orderForm.css"/>

<section class="order-container">
	<div id="order-container-content">
		<div class="order-container-inner">
			<h1 class="orderform-title">주문 내역</h1>
			<div class="order-form-main">
				<form action="${path }/order/orderList.do">
					<h2 class="order_information-title">로그인</h2>
					<!-- ajax -->
					<div></div>
				  	<div class="form-group">
				  		<label class="order_information" for="orderNo">
					    	<input type="text" name="memberId" class="form-control order-infor-input order-form-number" id="memail">
					    	<span id="inputNo" class="order-input-center">아이디(이메일 주소)</span>
				    	</label>
				  	</div>
				  	
				  	<div class="form-group">
				  		<label class="order_information">
					    	<input type="password" name="memberPassword" class="form-control order-infor-input order-form-phone" id="mpassword">
					   		<span id="inputphone" class="order-input-center">비밀번호</span>
				   		</label>
				  	</div>
				  	<p>
				  		<a href="">비밀번호가 기억나지 않으세요?</a>
				  	</p>	
				  	<button disabled="disabled" type="submit" class="btn order-btn-color" id="order-submit">확인</button>
				</form>
			</div>
		</div>
	</div>
</section>

<script>

	$(".order-form-number").focus(function(){
		$("#inputNo").removeClass("order-input-center");
		$("#inputNo").addClass("order-input-top");
	});
	$(".order-form-number").blur(function(){
		var e = $("#memail").val().trim();
		if(e.length==0){
			$("#inputNo").removeClass("order-input-top");
			$("#inputNo").addClass("order-input-center");
			
		}
	});
	
	$(".order-form-phone").focus(function(){
		$("#inputphone").removeClass("order-input-center");
		$("#inputphone").addClass("order-input-top");
	});
	$(".order-form-phone").blur(function(){
		var p = $("#mpassword").val().trim();
		if(p.length==0){			
			$("#inputphone").removeClass("order-input-top");
			$("#inputphone").addClass("order-input-center");
		}
	});
	
	
	
	$("#memail").on("input",function(){
        if($("#memail").val().length>0 && $("#mepassword").val().length>0 ){
            $("#order-submit").removeAttr("disabled");
        }else{
            $("#order-submit").attr("disabled","disabled");
        }
     });
     $("#mepassword").on("input",function(){
        if($("#memail").val().length>0 && $("#mepassword").val().length>0 ){
            $("#order-submit").removeAttr("disabled");
        }else{
            $("#order-submit").attr("disabled","disabled");
        }
     });
	
	
	
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>