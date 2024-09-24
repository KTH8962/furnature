<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<jsp:include page="/layout/headlink.jsp"></jsp:include>
</head>
<body>
	<jsp:include page="/layout/header.jsp"></jsp:include>
	<div id="app">
		<div id="container">            
            <p class="blind">마이페이지 - 경매입찰리스트</p>
			<div class="myPage-wrap">
				<div class="myPage-snb-wrap">
					<jsp:include page="/layout/myPageSnb.jsp"></jsp:include>
				</div>
				<div class="myPage myPage-info">
					<div v-for="item in biddingList">
						<div>경매 제목 : {{item.auctionTitle}}</div>
						<div>경매 번호 : {{item.auctionNo}}</div>
						<div>최고 입찰 금액 : {{item.auctionPriceCurrent}}</div>
						<div>내 입찰 금액 : {{item.myBidding}}</div>
						<div>입찰 일자 : {{item.auctionBiddingDate}}</div>
						<div>
							<template v-if="item.auctionStatus == 'E'">
								<template v-if="item.auctionPriceCurrent == item.myBidding">
									최고 입찰 금액으로 입찰되었습니다. <br>
									제품 구매를 진행해 주세요.
									<button @click="fnBuy(item.auctionTitle, item.myBidding)">구매하기</button>
									<button @click="fnBuyCancel()">취소하기</button>
								</template>
								<template v-else>
									최고 입찰 금액 이용자에게 입찰되었습니다. <br>
									다른 경매에도 많은 참여해주세요.
								</template>
							</template>
							<template v-else>
								<button type="button" @click="fnCancel(item.auctionNo)">입찰 취소</button>
							</template>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<jsp:include page="/layout/footer.jsp"></jsp:include>
</body>
</html>
<script src="https://cdn.iamport.kr/v1/iamport.js"></script>
<script>
	const userCode = "imp80826844"; 
	IMP.init(userCode);
    const app = Vue.createApp({
        data() {
            return {
				sessionId : '${sessionId}',
				biddingList : [],
				infoList: [],
            };
        },
        methods: {
            fnGetList(){
				var self = this;
				var nparmap = {sessionId: self.sessionId};
				$.ajax({
					url:"/myPage/bidding-list.dox",
					dataType:"json",	
					type : "POST", 
					data : nparmap,
					success : function(data) {
						console.log(data);
						self.biddingList = data.biddingList;
					}
				});
            },
			fnCancel(auctionNo){
				if(!confirm("입찰을 취소 하시겠습니까?")) return;
				var self = this;
				var nparmap = {auctionNo: auctionNo, sessionId: self.sessionId};
				$.ajax({
					url:"/myPage/bidding-cancel.dox",
					dataType:"json",	
					type : "POST", 
					data : nparmap,
					success : function(data) {
						if(data.result =="success") {
							self.fnGetList();
							alert(data.message);
						}
					}
				});
			},
			fnBuy(title, myBidding){
				var self = this;
				IMP.request_pay({
	                pg: "kakaopay",
	                pay_method: "card",
	                merchant_uid: "order_id_" + new Date().getTime(), // 유니크한 주문 ID 생성
	                name: title,
	                amount: myBidding, // 결제 금액
	                buyer_name: "홍길동",
	                buyer_tel: "010-1234-5678",
	                buyer_email: "example@example.com",
	                m_redirect_url: "http://your-redirect-url.com" // 결제 완료 후 리디렉션 URL
	            }, function (rsp) {
					console.log(rsp);
					if (rsp.success) {
						self.infoList = rsp;
                        $.ajax({
                            url: "/payment/verification/" + rsp.imp_uid,
                            method: "POST",
                        }).done(function (data) {
                            // 가맹점 서버 결제 API 성공시 로직
							console.log(data);
                        })
                    } else {
                        alert("결제에 실패하였습니다. 에러 내용: " + rsp.error_msg);
                    }
	                // if (rsp.success) {
	                //     // 결제 성공 시
	                //     alert("결제 성공!");
	                //     console.log(rsp);
					// 	self.fnInsert(rsp);
	                // } else {
	                //     // 결제 실패 시
	                //     alert("결제 실패: " + rsp.error_msg);
	                //     console.log(rsp);
	                // }
	                // if (rsp.success) {
	                //     // 결제 성공 시
	                //     alert("결제 성공!");
					// 	self.infoList = rsp;
	                //     console.log(self.infoList);
					// 	//self.fnInsert(rsp);
	                // } else {
	                //     // 결제 실패 시
	                //     alert("결제 실패: " + rsp.error_msg);
	                //     console.log(rsp);
	                // }
	            });
			},
			fnBuyCancel() {
				var self = this;
				console.log(self.infoList);
				$.ajax({
					url: '/payment/cancel/' + self.infoList.imp_uid,
					method: 'POST',
				}).done(function (data) {
					console.log(data);
				})
			},
			fnInsert(rsp){
				var self = this;
				var nparmap = {name: rsp.name, price: rsp.paid_amount, productId: rsp.merchant_uid};
				$.ajax({
					url:"/api/payment.dox",
					dataType:"json",	
					type : "POST", 
					data : nparmap,
					success : function(data) { 
						//console.log(data);
					}
				});
            }
        },
        mounted() {
            var self = this;
			self.fnGetList();
        }
    });
    app.mount('#app');
</script>