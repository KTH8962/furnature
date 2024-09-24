<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <jsp:include page="/layout/headlink.jsp"></jsp:include>
    <script src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
</head>
<body>
    <jsp:include page="/layout/header.jsp"></jsp:include>
    <div id="app">
        <div id="container">            
            <p class="blind">마이페이지 - 내정보</p>
            <div class="myPage-wrap">
                <div class="myPage-snb-wrap">
                    <jsp:include page="/layout/myPageSnb.jsp"></jsp:include>
                </div>
                <div class="myPage myPage-delivery" style="width:100%">
                    <div>배송정보</div>
					{{sessionId}}
					<div v-if="!list || list.length === 0">
					    구매 목록이 없습니다.
					</div>
					<div v-for="item in list">
						<div v-if="item.orderCate =='상품'">
							<div>상품구매 목록</div>
							상품이름 구매수량 주문번호 배달현황
							<div>
	 							<a href="#" @click="fnProDetail(item.productNo)"><img :src="item.productThumbnail" style= "width : 200px ; height : 200px">
								{{item.productName}}</a> {{item.orderCount}}개 {{item.orderNo}}	{{item.cateName}}						
							</div>					
						</div>		
                   </div>
				   <div v-for="item in list">
						<div v-if="item.orderCate =='경매'">
							<div>경매구매 목록</div>
							상품이름 구매수량 주문번호 배달현황
							<div>
	 							<a href="#" @click="fnProDetail(item.productNo)"><img :src="item.productThumbnail" style= "width : 200px ; height : 200px">
								{{item.productName}}</a> {{item.orderCount}}개 {{item.orderNo}}	{{item.cateName}}						
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
<script>
    const app = Vue.createApp({
        data() {
            return {
                sessionId: '${sessionId}',
				productNo : "",
                list: []
            };
        },
        methods: {
            fnDelivery() {
                var self = this;
                var nparmap = { 
					userId : self.sessionId
				};
                $.ajax({
                    url: "/myPage/mypage-delivery.dox",
                    dataType: "json",
                    type: "POST",
                    data: nparmap,
                    success: function(data) {
						console.log(data);
                        self.list = data.list;
                    }
                });
            },
			fnProDetail(productNo){
				$.pageChange("/productDetail/productDetail.do",{productNo : productNo});
			}
      
        },
        mounted() {
            var self = this;
			self.fnDelivery();
        }
    });
    app.mount('#app');
</script>

