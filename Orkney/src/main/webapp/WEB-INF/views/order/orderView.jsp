<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>

<jsp:include page="/WEB-INF/views/common/header.jsp">		
	<jsp:param name="title" value="주문/배송조회" />
</jsp:include>
<link rel="stylesheet" href="${path}/resources/css/order/orderForm.css"/>
<link rel="stylesheet" href="${path }/resources/css/order/orderView.css"/>
<section class="order-container">
	<div id="order-container-content">
		<div class="order-container-inner">
			<div class="orderTitle">
				<div class="back-btn">
					<a></a>
				</div>
				<h1 class="orderform-title">주문 내역</h1>
				<p class="orderNumber">주문 번호(iSell 번호): ${order.order_no}</p>
			</div>
			<c:if test="${order.order_state eq '취소완료' }">
				<div class="cancel-msg">
					<div class="cancelicon">
						<svg viewBox="0 0 24 24" width="18px" height="18px" class=""><path fill="currentColor" fill-rule="evenodd" clip-rule="evenodd" d="M12 22C6.477 22 2 17.523 2 12S6.477 2 12 2s10 4.477 10 10-4.477 10-10 10zm0-2a8 8 0 1 0 0-16 8 8 0 0 0 0 16zm-.95-11.67a.95.95 0 1 1 1.9 0 .95.95 0 0 1-1.9 0zM13 17v-6h-2v6h2z"></path></svg>
					</div>
					<div class="cancel-content">
						<p class="cancel-text">주문이 취소되었습니다.</p>
					</div>
				</div>
			</c:if>
			
			<div class="part-line"><hr class="line-c"></div>
			
			<!-- 주문날짜, 주문번호, 최종 결제금액 -->
			<div class="orderDetail">
				<div class="orderDetail-container detail-content">
					<div>
						<div class="orderDetail-content">
							<h5 class="od-title">주문 날짜</h5>
							<p class="od-content"><c:out value="${order.order_date }"/></p>
						</div>
						<div class="orderDetail-content">
							<h5 class="od-title">주문 번호(iSell 번호)</h5>
							<p class="od-content"><c:out value="${order.order_no }"/></p>
						</div>
						<div class="orderDetail-content">
							<h5 class="od-title">최종 결제금액</h5>
							<p class="od-content"><fmt:setLocale value="ko_KR"/><fmt:formatNumber type="currency" value="${order.total_price}" /></p>
						</div>						
					</div>
					<c:if test="${order.order_state eq '주문확인' or order_state eq '배송준비중'  }">
					<div class="cancelCheck">
						<button class="cancel-btn" data-toggle="modal" data-target="#exampleModal" data-whatever="@mdo">
							<svg aria-hidden="true" focusable="false" data-prefix="fas" data-icon="clipboard-check" class="svg-inline--fa fa-clipboard-check fa-w-12 stateCheck-icon" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 384 512"><path fill="currentColor" d="M336 64h-80c0-35.3-28.7-64-64-64s-64 28.7-64 64H48C21.5 64 0 85.5 0 112v352c0 26.5 21.5 48 48 48h288c26.5 0 48-21.5 48-48V112c0-26.5-21.5-48-48-48zM192 40c13.3 0 24 10.7 24 24s-10.7 24-24 24-24-10.7-24-24 10.7-24 24-24zm121.2 231.8l-143 141.8c-4.7 4.7-12.3 4.6-17-.1l-82.6-83.3c-4.7-4.7-4.6-12.3.1-17L99.1 285c4.7-4.7 12.3-4.6 17 .1l46 46.4 106-105.2c4.7-4.7 12.3-4.6 17 .1l28.2 28.4c4.7 4.8 4.6 12.3-.1 17z"></path></svg>
							<p class="cancel-btn-name">주문취소</p>
						</button>
					</div>
					
					<!-- 주문취소 모달 -->
					<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
					  <div class="modal-dialog">
					    <div class="modal-content">
					      <div class="modal-header">
					        <h5 class="modal-title" id="exampleModalLabel">주문 취소</h5>
					        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
					          <span aria-hidden="true">&times;</span>
					        </button>
					      </div>
					      <div class="modal-body">
					        <form>
					          <div class="form-group">
					            <label for="recipient-name" class="col-form-label">주문 취소 사유를 선택해주세요.</label>
					            <input type="text" class="form-control" id="recipient-name">
					          </div>
					        </form>
					      </div>
					      <div class="modal-footer">
					        <button type="button" class="btn btn-secondary" data-dismiss="modal">주문내역으로 돌아가기</button>
					        <button type="button" class="btn btn-primary">확인</button>
					      </div>
					    </div>
					  </div>
					</div>
					
					
					</c:if>
				</div>
			</div>
			
			<div class="part-line disappear-line"><hr class="line-c"></div>
			
			
			<!-- 택배 배송 현황 작은 화면-->
			<c:if test="${order.order_state ne '취소완료' }">
				<div class="delivery-mobile">
					<div class="orderDetail">
						<div class="orderDetail-container detail-content">
							<div>
								<div>
									<div class="delivery-title">
										<div>
											<svg viewBox="0 0 24 24" version="1.1" xmlns="http://www.w3.org/2000/svg" class="delivery-title-icon deilvery-icons Icon_Icon__qK-bt Icon_Large__1-alp"><title>information-parcel</title><g class=""><path d="M4.87057711,7.51444958 C4.87057711,7.51011625 19.6623067,7.50664958 19.6623067,7.50664958 C19.6670949,7.50664958 19.6705773,20.5066496 19.6705773,20.5066496 L4.8788477,20.5066496 C4.87405946,20.5066496 4.87057711,7.51444958 4.87057711,7.51444958 Z M14.2540925,2.00126838 L20.4600015,6.26617069 C20.5104949,6.30060258 20.5409651,6.36016046 20.5409651,6.423906 L20.5409651,21.2109309 C20.5409651,21.313296 20.4634838,21.3961187 20.3681556,21.3961187 L4.17542129,21.3961187 C4.07878723,21.3961187 4,21.3119001 4,21.2086044 L4,6.423906 C4,6.36016046 4.03003491,6.30106788 4.08052838,6.26617069 C4.08052838,6.26617069 10.2955784,1.99987249 10.2981901,2.00359486 C10.2981901,2.00359486 10.7617724,2.78156962 10.7578548,2.7843614 C10.7578548,2.7843614 5.25928979,6.57605776 5.2666897,6.57605776 C5.2666897,6.57605776 19.2847224,6.56535596 19.2786283,6.5602377 C19.2786283,6.5602377 13.7778868,2.77645136 13.7804986,2.772729 C13.7804986,2.772729 14.2501749,1.9989419 14.2540925,2.00126838 Z M9.16171866,9.87423847 C9.15910693,9.87423847 9.1564952,9.87656495 9.1564952,9.87982202 L9.1564952,10.7992467 C9.1564952,10.8025038 9.15910693,10.8048303 9.16171866,10.8048303 L15.2453115,10.8048303 C15.2479233,10.8048303 15.250535,10.8025038 15.250535,10.7992467 L15.250535,9.87982202 C15.250535,9.87656495 15.2479233,9.87423847 15.2453115,9.87423847 L9.16171866,9.87423847 Z"></path></g></svg>
										</div>
										<div class="deli-title-text">
											<h3 class="deli-title">택배 배송</h3>
										</div>	
									</div>
									<div class="delivery-content">
										<h5 class="start-date">배송출발일</h5>
										<p class="start-date-content">2020-11-26 09:00 - 21:00 (GMT+9)</p>
									</div>
									<div>
										<div class="delivery-state">
										배송현황svg
										</div>
										<div class="delivery-content">
											<p class="state-title">주문 진행 상태</p>
											<h4 class="state-content-text">배송중</h4>
										</div>
									</div>
								</div>
								<div>
								<!-- 배송조회 api 버튼 -->
								</div>
								<div>
								
								</div>
							</div>
						</div>
					</div>
				
					<div class="part-line"><hr class="line-c"></div>
					
					
					<!-- 택배 배송 내역 -->
					<div class="">
						<div >
							<div>
								<div id="destination" class="destination">
									<div class="productList-tap">
										<h5 class="de-title">택배 배송 내역</h5>
										<div id="plus" class="pl-svg">
											<svg viewBox="0 0 24 24" width="18px" height="18px" class=""><path fill="currentColor" fill-rule="evenodd" clip-rule="evenodd" d="M13 11h5v2h-5v5h-2v-5H6v-2h5V6h2v5z"></path></svg>
										</div>
										<div id="minus" class="pl-svg">
											<svg viewBox="0 0 24 24" width="18px" height="18px" class=""><path fill="currentColor" fill-rule="evenodd" clip-rule="evenodd" d="M6 13v-2h12v2H6z"></path></svg>
										</div>
									</div>	
								</div>
								<div id="destination-content" class="destination-content">
									<div class="od_mobile">
										<h5 class="od-title address-m-title">주소</h5>
									</div>
									<div class="address-content od-desktop-content">
										<p class="od-content address-text">이윤나</p>
										<p class="od-content address-text">
											<span class="orderAddress">경기 시흥시 신천동 854-6<br>
											대림 2차 1동 202호</span>
											<span>14950</span>
										</p>
									</div>
								</div>
							</div>
						</div>
					</div>
					
					<div class="part-line"><hr class="line-c"></div>
					
				
					<!-- 제품 -->
					<div class="">
						<div >
							<div>
								<div id="productList" class="productList">
									<div class="productList-tap">
										<h3 class="pl-title">택배 배송 제품(1)</h3>
										<div id="p-plus" class="pl-svg">
											<svg viewBox="0 0 24 24" width="18px" height="18px" class=""><path fill="currentColor" fill-rule="evenodd" clip-rule="evenodd" d="M13 11h5v2h-5v5h-2v-5H6v-2h5V6h2v5z"></path></svg>
										</div>
										<div id="p-minus" class="pl-svg">
											<svg viewBox="0 0 24 24" width="18px" height="18px" class=""><path fill="currentColor" fill-rule="evenodd" clip-rule="evenodd" d="M6 13v-2h12v2H6z"></path></svg>
										</div>
									</div>	
								</div>
								<div id="pro-con" class="product-container">
									<div class="product-img">
										<img src="https://www.ikea.com/kr/ko/images/products/njutning-niuteuning-kkochbyeong-dipyujyeoseutig-jong__0539528_PE652510_S3.JPG">
									</div>
									<div class="product-info">
										<p class="product-text">1x 꽃병+디퓨져스틱 6종</p>
										<p class="product-text">NJUTNING 니우트닝</p>
										<div class="price-container">
											<p class="product-price">₩7,900</p>
											<p class="price-amount">₩7,900</p>
										</div>
										<p class="product-text">라벤더블리스, 라일락</p>
										<p class="product-code">303.618.11</p>
									</div>
								</div>
							</div>
						</div>
					</div>
					
					<div class="part-line mobile-line"><hr class="line-c"></div>
				</div>
			
			<!-- 택배 현황 큰 화면  -->
			
				<div class="delivery-desktop">
					<div class="desktop-icon-container">
						<div class="desktop-icon">
							<svg viewBox="0 0 24 24" version="1.1" xmlns="http://www.w3.org/2000/svg" class="delivery-title-icon deilvery-icons Icon_Icon__qK-bt Icon_Large__1-alp"><title>information-parcel</title><g class=""><path d="M4.87057711,7.51444958 C4.87057711,7.51011625 19.6623067,7.50664958 19.6623067,7.50664958 C19.6670949,7.50664958 19.6705773,20.5066496 19.6705773,20.5066496 L4.8788477,20.5066496 C4.87405946,20.5066496 4.87057711,7.51444958 4.87057711,7.51444958 Z M14.2540925,2.00126838 L20.4600015,6.26617069 C20.5104949,6.30060258 20.5409651,6.36016046 20.5409651,6.423906 L20.5409651,21.2109309 C20.5409651,21.313296 20.4634838,21.3961187 20.3681556,21.3961187 L4.17542129,21.3961187 C4.07878723,21.3961187 4,21.3119001 4,21.2086044 L4,6.423906 C4,6.36016046 4.03003491,6.30106788 4.08052838,6.26617069 C4.08052838,6.26617069 10.2955784,1.99987249 10.2981901,2.00359486 C10.2981901,2.00359486 10.7617724,2.78156962 10.7578548,2.7843614 C10.7578548,2.7843614 5.25928979,6.57605776 5.2666897,6.57605776 C5.2666897,6.57605776 19.2847224,6.56535596 19.2786283,6.5602377 C19.2786283,6.5602377 13.7778868,2.77645136 13.7804986,2.772729 C13.7804986,2.772729 14.2501749,1.9989419 14.2540925,2.00126838 Z M9.16171866,9.87423847 C9.15910693,9.87423847 9.1564952,9.87656495 9.1564952,9.87982202 L9.1564952,10.7992467 C9.1564952,10.8025038 9.15910693,10.8048303 9.16171866,10.8048303 L15.2453115,10.8048303 C15.2479233,10.8048303 15.250535,10.8025038 15.250535,10.7992467 L15.250535,9.87982202 C15.250535,9.87656495 15.2479233,9.87423847 15.2453115,9.87423847 L9.16171866,9.87423847 Z"></path></g></svg>
						</div>
					</div>
					<div class="orderDetail">
						<div class="orderDetail-container detail-content">
							<div class="od-deli-container">
								<div class="delivery-inner">
									<div class="delivery-title">
										<div class="deli-title-text">
											<h3 class="deli-title">택배 배송</h3>
										</div>	
									</div>
									<!-- 택배 배송 내역 -->
									<div class="">
										<div >
											<div>
												<div class="od_mobile">
													<h5 class="od-title address-m-title">주소</h5>
												</div>
												<div class="address-content">
													<p class="od-content address-text">이윤나</p>
													<p class="od-content address-text">
														<span class="orderAddress">경기 시흥시 신천동 854-6<br>
														대림 2차 1동 202호</span>
														<span>14950</span>
													</p>
												</div>
											</div>
										</div>
									</div>
									<div class="state-content">
										<div class="statecourse">
											<div class="state-icon-group">
												<div class="state-connection first-state">
												</div>
												<div class="state-icon">
													<svg viewBox="0 0 24 24" version="1.1" xmlns="http://www.w3.org/2000/svg" class="stateIcon Icon_Icon__qK-bt"><title>link-document</title><g class=""><path d="M19.707 5.293L16.414 2H4v20h16V5.586l-.293-.293zM19 21H5V3h11v3h3v15zM8 8v1h8V8H8zm0 3v1h8v-1H8zm0 3v1h8v-1H8z"></path></g></svg>
												</div>
												<div class="state-connection">
												</div>
											</div>
											<div class="state-name">주문 확인</div>
										</div>
										<div class="statecourse">
											<div class="state-icon-group">
												<div class="state-connection">
												</div>
												<div class="state-icon">
													<svg viewBox="0 0 24 24" version="1.1" xmlns="http://www.w3.org/2000/svg" class="stateIcon Icon_Icon__qK-bt"><title>cart</title><g class=""><path d="M6.482 16.983h15.499v.631H6.166a.316.316 0 0 1-.316-.316V7.216L4.506 5.169l-.78.767.818 1.24a.316.316 0 0 1 .052.175l-.007 10.283h-.632l.006-10.189-.907-1.378a.316.316 0 0 1 .042-.399l1.238-1.22a.316.316 0 0 1 .486.052L6.43 6.948a.317.317 0 0 1 .052.173v9.862zM19.74 18.29c.76 0 1.378.618 1.378 1.378a1.38 1.38 0 0 1-2.756 0c0-.76.618-1.378 1.378-1.378zm0 2.124a.747.747 0 0 0 0-1.492.747.747 0 0 0 0 1.492zM7.552 18.29c.76 0 1.378.618 1.378 1.378a1.38 1.38 0 0 1-2.756 0c0-.76.618-1.378 1.378-1.378zm0 2.124a.747.747 0 0 0 0-1.492.747.747 0 0 0 0 1.492z"></path></g></svg>
												</div>
												<div class="state-connection">
												</div>
											</div>	
											<div class="state-name">제품 준비 중</div>
										</div>
										<div class="statecourse">
											<div class="state-icon-group">
												<div class="state-connection">
												</div>
												<div class="state-icon">
													<svg viewBox="0 0 24 24" version="1.1" xmlns="http://www.w3.org/2000/svg" class="stateIcon Icon_Icon__qK-bt"><title>information-parcel</title><g class=""><path d="M4.87057711,7.51444958 C4.87057711,7.51011625 19.6623067,7.50664958 19.6623067,7.50664958 C19.6670949,7.50664958 19.6705773,20.5066496 19.6705773,20.5066496 L4.8788477,20.5066496 C4.87405946,20.5066496 4.87057711,7.51444958 4.87057711,7.51444958 Z M14.2540925,2.00126838 L20.4600015,6.26617069 C20.5104949,6.30060258 20.5409651,6.36016046 20.5409651,6.423906 L20.5409651,21.2109309 C20.5409651,21.313296 20.4634838,21.3961187 20.3681556,21.3961187 L4.17542129,21.3961187 C4.07878723,21.3961187 4,21.3119001 4,21.2086044 L4,6.423906 C4,6.36016046 4.03003491,6.30106788 4.08052838,6.26617069 C4.08052838,6.26617069 10.2955784,1.99987249 10.2981901,2.00359486 C10.2981901,2.00359486 10.7617724,2.78156962 10.7578548,2.7843614 C10.7578548,2.7843614 5.25928979,6.57605776 5.2666897,6.57605776 C5.2666897,6.57605776 19.2847224,6.56535596 19.2786283,6.5602377 C19.2786283,6.5602377 13.7778868,2.77645136 13.7804986,2.772729 C13.7804986,2.772729 14.2501749,1.9989419 14.2540925,2.00126838 Z M9.16171866,9.87423847 C9.15910693,9.87423847 9.1564952,9.87656495 9.1564952,9.87982202 L9.1564952,10.7992467 C9.1564952,10.8025038 9.15910693,10.8048303 9.16171866,10.8048303 L15.2453115,10.8048303 C15.2479233,10.8048303 15.250535,10.8025038 15.250535,10.7992467 L15.250535,9.87982202 C15.250535,9.87656495 15.2479233,9.87423847 15.2453115,9.87423847 L9.16171866,9.87423847 Z"></path></g></svg>
												</div>
												<div class="state-connection">
												</div>
											</div>
											<div class="state-name">배송 터미널 도착</div>
										</div>
										<div class="statecourse">
											<div class="state-icon-group">
												<div class="state-connection">
												</div>
												<div class="state-icon">
													<svg viewBox="0 0 24 24" version="1.1" xmlns="http://www.w3.org/2000/svg" class="stateIcon Icon_Icon__qK-bt"><title>fulfilment-delivery</title><g class=""><path d="M21.3453067,15.8189633 L19.3826542,15.8189633 C19.2166647,14.911293 18.4216624,14.2208249 17.4666957,14.2208249 C16.5120302,14.2208249 15.7170279,14.911293 15.5510384,15.8189633 L14.3857982,15.8189633 L14.3857982,8.52687329 L16.6319282,8.52687329 L18.7768377,11.7499614 C18.8178079,11.8114167 18.8780582,11.8575081 18.9476473,11.8807045 L21.3453067,12.6811293 L21.3453067,15.8189633 Z M17.4666957,17.4562643 C16.75755,17.4562643 16.1803524,16.8790667 16.1803524,16.1699211 C16.1803524,15.4604742 16.75755,14.8832766 17.4666957,14.8832766 C18.1761426,14.8832766 18.7533401,15.4604742 18.7533401,16.1699211 C18.7533401,16.8790667 18.1761426,17.4562643 17.4666957,17.4562643 Z M6.79727691,14.2208249 C5.84291266,14.2208249 5.04821163,14.9106905 4.88161963,15.8177582 L2.79093533,15.8189633 L2.79093533,6.54524197 L13.7233465,6.54403696 L13.7233465,15.8180595 L8.71323544,15.8180595 C8.5469447,14.9109917 7.75194241,14.2208249 6.79727691,14.2208249 Z M6.79727691,17.4562643 C6.08813126,17.4562643 5.51093369,16.8790667 5.51093369,16.1699211 C5.51093369,15.4604742 6.08813126,14.8832766 6.79727691,14.8832766 C7.50672382,14.8832766 8.08392139,15.4604742 8.08392139,16.1699211 C8.08392139,16.8790667 7.50672382,17.4562643 6.79727691,17.4562643 Z M21.7818199,12.1277306 L19.2654674,11.2881431 L17.0853115,8.01173349 C17.0238562,7.91924933 16.9202257,7.86381909 16.8093652,7.86381909 L14.3857982,7.86381909 L14.3857982,6.21266049 C14.3857982,6.12469509 14.3511543,6.04034472 14.2887953,5.97828694 C14.2267375,5.91592791 14.1423871,5.88128401 14.0544217,5.88128401 L2.45955885,5.88248902 C2.27639804,5.88248902 2.12788112,6.03100593 2.12788112,6.21386549 L2.12788112,16.1503397 C2.12788112,16.2383051 2.16312753,16.3226555 2.22518531,16.3850145 C2.28724308,16.4470723 2.37159346,16.4817162 2.45955885,16.4817162 L4.87529336,16.4805112 C5.02501527,17.4077628 5.82875385,18.118716 6.79727691,18.118716 C7.76640248,18.118716 8.57014105,17.4077628 8.71956172,16.4805112 L14.0502042,16.4805112 C14.0517105,16.4805112 14.0529155,16.481415 14.0544217,16.481415 L15.5450134,16.481415 C15.6950365,17.4080641 16.4984739,18.118716 17.4666957,18.118716 C18.4352187,18.118716 19.2386561,17.4080641 19.3886792,16.481415 L21.6766832,16.481415 C21.859844,16.481415 22.0080596,16.3331993 22.0080596,16.1500385 L22.0080596,12.442237 C22.0080596,12.2994438 21.9167805,12.1729183 21.7818199,12.1277306 L21.7818199,12.1277306 Z"></path></g></svg>
												</div>
												<div class="state-connection">
												</div>
											</div>
											<div class="state-name">배송중</div>
										</div>
										<div class="statecourse">
											<div class="state-icon-group">
												<div class="state-connection">
												</div>
												<div class="state-icon">
													<svg viewBox="0 0 24 24" version="1.1" xmlns="http://www.w3.org/2000/svg" class="stateIcon Icon_Icon__qK-bt"><title>order-confirmation</title><g class=""><path d="M11,16.71 L9.11,14.81 L9.81,14.11 L11,15.29 L14.65,11.65 L15.35,12.35 L11,16.71 Z M18,21 L6,21 L6,6 L8,6 L8,7 L16,7 L16,6 L18,6 L18,21 Z M12,3 C13.105,3 14,3.895 14,5 L10,5 C10,3.895 10.895,3 12,3 L12,3 Z M15,5 C15,3.343 13.657,2 12,2 C10.343,2 9,3.343 9,5 L5,5 L5,22 L19,22 L19,5 L15,5 Z"></path></g></svg>
												</div>
												<div class="state-connection first-state">
												</div>
											</div>
											<div class="state-name">배송 완료</div>
										</div>
									</div>
									<div>
										<div class="delivery-content desktop-date">
											<h5 class="start-date">배송출발일</h5>
											<p class="start-date-content">2020-11-26 09:00 - 21:00 (GMT+9)</p>
										</div>
										<div class="delivery-content">
											<p class="state-title">주문 진행 상태</p>
											<h4 class="state-content-text">배송중</h4>
										</div>
									</div>
								</div>
								<div>
								<!-- 배송조회 api 버튼 -->
								</div>
							</div>
						</div>
					</div>
				
					<div class="part-line"><hr class="line-c"></div>
					
					<!-- 제품 -->
					<div class="">
						<div >
							<div>
								<div class="desktop-productList">
									<h5>제품</h5>
								</div>
								<div class="product-container">
									<div class="product-img">
										<img src="https://www.ikea.com/kr/ko/images/products/njutning-niuteuning-kkochbyeong-dipyujyeoseutig-jong__0539528_PE652510_S3.JPG">
									</div>
									<div class="product-info">
										<p class="product-text">1x 꽃병+디퓨져스틱 6종</p>
										<p class="product-text">NJUTNING 니우트닝</p>
										<div class="price-container">
											<p class="product-price">₩7,900</p>
											<p class="price-amount">₩7,900</p>
										</div>
										<p class="product-text">라벤더블리스, 라일락</p>
										<p class="product-code">303.618.11</p>
									</div>
								</div>
							</div>
						</div>
					</div>
					
					<!-- <div class="part-line mobile-line"><hr class="line-c"></div> -->
				</div>
			</c:if>
			
			
			
			<!-- 취소완료 했을 때 큰화면에서 보여지는 제품 -->
			<c:if test="${order.order_state eq '취소완료' }">
				<div class="">
					<div >
						<div>
							<div id="productList" class="productList">
								<div class="productList-tap">
									<h3 class="pl-title">제품</h3>
									<div id="p-plus" class="pl-svg">
										<svg viewBox="0 0 24 24" width="18px" height="18px" class=""><path fill="currentColor" fill-rule="evenodd" clip-rule="evenodd" d="M13 11h5v2h-5v5h-2v-5H6v-2h5V6h2v5z"></path></svg>
									</div>
									<div id="p-minus" class="pl-svg">
										<svg viewBox="0 0 24 24" width="18px" height="18px" class=""><path fill="currentColor" fill-rule="evenodd" clip-rule="evenodd" d="M6 13v-2h12v2H6z"></path></svg>
									</div>
								</div>	
							</div>
							<div class="desktop-productList">
								<h5>제품</h5>
							</div>
							<div id="pro-con" class="product-container">
								<div class="product-img">
									<img src="https://www.ikea.com/kr/ko/images/products/njutning-niuteuning-kkochbyeong-dipyujyeoseutig-jong__0539528_PE652510_S3.JPG">
								</div>
								<div class="product-info">
									<p class="product-text">1x 꽃병+디퓨져스틱 6종</p>
									<p class="product-text">NJUTNING 니우트닝</p>
									<div class="price-container">
										<p class="product-price">₩7,900</p>
										<p class="price-amount">₩7,900</p>
									</div>
									<p class="product-text">라벤더블리스, 라일락</p>
									<p class="product-code">303.618.11</p>
								</div>
							</div>
						</div>
					</div>
				</div>
			</c:if>
			
			
			
			
			<!-- 주소 -->
			<div class="orderDetail">
				<div class="orderDetail-container address-container">
					<div class="od-desktop-container">
						<div class="od_desktop">
							<h3 class="od_d_title">주소</h3>
						</div>
						<div class="od_mobile">
							<h5 class="od-title address-m-title">주소</h5>
						</div>
						<div class="od-desktop-content">
							<p class="od-content address-text">이윤나</p>
							<p class="od-content address-text">
								<span class="orderAddress">경기 시흥시 신천동 854-6<br>
								대림 2차 1동 202호</span>
								<span>14950</span>
							</p>
							<p class="od-content address-text">yoonnable@gmail.com</p>
						</div>
					</div>
				</div>
			</div>
			
			<div class="part-line"><hr class="line-c"></div>
			
			<!-- 결제방법 -->
			<div class="orderDetail">
				<div class="orderDetail-container">
					<div class="od-desktop-container">
						<div class="od_desktop">
							<h3 class="od_d_title">결제 방법</h3>
						</div>
						<div class="od_mobile">
							<h5 class="od-title">결제 방법</h5>
						</div>
						<div class="od-desktop-content">
							<p class="od-content">신용카드</p>
						</div>
					</div>
				</div>
			</div>
			
			<div class="part-line"><hr class="line-c"></div>
			
			<!-- 결제 내역 -->
			<div class="">
				<div>
					<div class="od-desktop-container">
						<div class="od_desktop">
							<h3 class="od_d_title">결제내역</h3>
						</div>
						<div class="od-desktop-content desktop-price">
							<div class="price-container payment-container">
								<h5 class="payment-price">총 주문금액</h5>
								<h5 class="payment-price">₩7,900</h5>
							</div>
							<div class="price-container">
								<p class="payment-deilvery">배송비</p>
								<p class="payment-deilvery">₩5,000</p>
							</div>
							<hr class="payment-partline">
							<div class="price-container">
								<h5 class="payment-price paymentAmount">최종 결제금액</h5>
								<h5 class="payment-price paymentAmount">₩12,900</h5>
							</div>
						</div>
					</div>
				</div>
			</div>
			
		</div>
	</div>
</section>

<script type="text/javascript">
	$("#destination").click(e=>{
		if($("#destination-content").hasClass("apple") === true) {
			$(".destination-content").css("display","none");
			$("#destination-content").removeClass("apple");
			$("#plus").css("display","block");
			$("#minus").css("display","none");
		}else{
			$(".destination-content").css("display","block");
			$("#destination-content").addClass("apple");
			$("#plus").css("display","none");
			$("#minus").css("display","block");
		}
	})
	$("#productList").click(e=>{
		if($("#pro-con").hasClass("apple") === true) {
			$("#pro-con").css("display","none");
			$("#pro-con").removeClass("apple");
			$("#p-plus").css("display","block");
			$("#p-minus").css("display","none");
			$(".mobile-line").css("display","block");
		}else{
			$("#pro-con").css("display","flex");
			$("#pro-con").addClass("apple");
			$("#p-plus").css("display","none");
			$("#p-minus").css("display","block");
			$(".mobile-line").css("display","none");
		}
	})
</script>



<jsp:include page="/WEB-INF/views/common/footer.jsp"/>