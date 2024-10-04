<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <jsp:include page="/layout/headlink.jsp"></jsp:include>
</head>
<body>
    <jsp:include page="/layout/header.jsp"></jsp:include>
    <div id="app">
        <div id="container" class="myPage">            
            <p class="blind">마이페이지 - 구매내역</p>
            <div class="myPage-wrap">
                <div class="myPage-snb-wrap">
                    <jsp:include page="/layout/myPageSnb.jsp"></jsp:include>
                </div>
                <div class="myPage myPage-oneday">
					<h2 class="myPage-tit">상품 구매내역</h2>			
						<div class="myPage-img-list-wrap">
							<div class="myPage-img-list-box" v-for="item in list">
								<div class="img-box">
                                    <a href="javascript:void(0);" @click="fnProDetail(item.productNo, item.orderCate)"><img :src="item.productThumbnail"></a>
                                </div>
								<div class="tit-box">
									<div class="top">
										<div class="tit"><a href="javascript:void(0);" @click="fnProDetail(item.productNo, item.orderCate)">{{item.productName}}</a></div>
									</div>
									<div>선택옵션 : {{item.orderSize}} </div>
									<div>상품가격 : {{item.productPrice}} </div>
									<div v-if="item.payStatus==1">결제상태: 결제예정</div>
									<div v-else>결제상태: 결제완료
										<div>결제번호: {{item.orderId}}</div>
									</div>
									<div class="price-box">
										<div class="price" v-if="item.payStatus==2">결제 금액 : {{item.price}} </div>
										<div class="price" v-if="item.payStatus==1">결제 예정 금액 : {{item.price}} </div>
									</div>
									<div class="date" v-if="item.payStatus==1">신청일자: {{item.joinDay}}</div>
									<div class="date" v-if="item.payStatus==2">결제일자: {{item.payDay}}</div>
								</div>
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
	const userCode = ""; 
	IMP.init("imp80826844");
	
    const app = Vue.createApp({
        data() {
            return {
                userId: '${sessionId}',
                list : []
            };
        },
        methods: {
            fnOrderInfo() {
				var self = this;
				var nparmap = { userId: self.userId };
					
	                $.ajax({
	                   url: "/myPage/payment.dox",
	                   dataType: "json",
	                   type: "POST",
	                   data: nparmap,
	                   success: function(data) {
							console.log(data);
							console.log(data.list);
							self.list = data.list;
							console.log(self.list);
	                   }
	               });
			},
			fnProDetail(productNo, orderCate){
	            if(orderCate == "상품") {
	                $.pageChange("/productDetail/productDetail.do",{productNo : productNo});
	            } else if(orderCate == "경매") {
	                $.pageChange("/event/auctionDetail.do",{auctionNo : productNo});
	            }
			}
        },
        mounted() {
			var self = this;
            self.fnOrderInfo();
        }
    });
    app.mount('#app');
</script>

