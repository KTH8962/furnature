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
		<div id="container" class="myPage">            
            <p class="blind">마이페이지 - 장바구니</p>
			<div class="myPage-wrap">
				<div class="myPage-snb-wrap">
					<jsp:include page="/layout/myPageSnb.jsp"></jsp:include>
				</div>
				<div class="myPage myPage-delivery">
					<h2 class="myPage-tit">{{sessionId}}님의 장바구니 내역</h2>
					<div v-if="!list || list.length === 0">
					    장바구니 목록이 없습니다.
						<div><button @click="fnBuy">구매하러가기</button></div>
					</div>
					<div class="myPage-img-list-wrap">
						<div v-for="item in list" class="myPage-img-list-box"> <!-- 상품 리스트 반복 -->
							<div>
								<div class="img-box">
									<a href="#" @click="fnProDetail(item.productNo)">
										<img :src="item.productThumbnail" style="width: 200px; height: 200px">
										{{item.productName}}
									</a>
								</div>
								<div class="tit-box">
									<div class="top">
										<div>선택한 사이즈 {{item.productSize}}</div>
										<div>선택한 상품 가격 {{(item.productPrice*1).toLocaleString()}}원</div>
										<div>구매수량 {{item.count}}개</div>
										<div>선택한 상품 총 가격 {{(item.count * item.productPrice).toLocaleString()}}원</div>
										<div>여기에 체크박스 cartNo{{item.cartNo}}
											<input type="checkbox" v-model="selectCheck" :value="item.cartNo" @change="updateSelectCheck">
										</div>
									</div>
								</div>
							</div>
						</div>
						<div v-if="list && list.length > 0">
							<div>
								총구매가격 : {{totalPrice.toLocaleString()}}
							</div>
							<div>
								<input type="checkbox" v-model="selectAll" @change="fnSelectAll">
								<template v-if="selectAll==false">
									<button type="button" @click="fnCheckRemove">선택 삭제</button>
								</template>
								<template v-if="selectAll==true">
									<button type="button" @click="fnCheckRemove">전체 삭제</button>
								</template>
							</div>
							<div>
								<button @click="fnPay">전체구매하기</button>
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
				list: [],
				selectCheck : [],
				selectAll: false,
            };
        },
        computed: {
            totalPrice() { // 총 가격
				var self = this;
				var total = 0;
				for (var i = 0; i < self.list.length; i++) {
					var item = self.list[i];
					total += item.productPrice * item.count; // 가격 * 수량 더하기
				}
				return total; // 총 가격 반환
			}
        },
        methods: {
			fnGetCartList(){
				var self = this;
				var nparmap = {userId: self.sessionId};
				$.ajax({
	               url: "/myPage/mypage-cartList.dox",
	               dataType: "json",
	               type: "POST",
	               data: nparmap,
	               success: function(data) {
					console.log(data);
	                   self.list = data.cartList;
	               }
	           });
	       },
		   fnGetInfo() {
              var self = this;
              var nparmap = { sessionId: self.sessionId };
              $.ajax({
                  url: "/myPage/myPage.dox",
                  dataType: "json",    
                  type: "POST", 
                  data: nparmap,
                  success: function(data) {
                      self.info = data.info;
                      console.log("다음찍히는 콘솔이 userinfo");
                      console.log(data.info);
                      self.myPoint = data.info.mileageTotal;
                  }
              });
          },
		   fnBuy(){
				location.href="/product/product.do"
		   },
		   fnProDetail(productNo){
				$.pageChange("/productDetail/productDetail.do", {productNo: productNo});
		   },
		   fnCheckRemove(){
   				var self = this;

   				// 체크된 항목이 있는지 확인
   				if (self.selectCheck.length === 0) {
   					alert("삭제할 상품을 선택해주세요."); // 선택되지 않았을 경우 알림
   					return;
   				}
   				
   				var fList = JSON.stringify(self.selectCheck);
   				var nparmap = {selectCheck : fList};
				if(confirm('정말 선택한 상품을 삭제하시겠습니까?')){
	   				$.ajax({
	   					url:"/myPage/check-remove.dox",
	   					dataType:"json",	
	   					type : "POST", 
	   					data : nparmap,
	   					success : function(data) {
	   						self.fnGetCartList();
							alert("삭제되었습니다."); 
							console.log(self.selectCheck);
	   					}
	   				});
				}else{
					alert("취소되었습니다.");
				}
   			},
			//전체 선택
			fnSelectAll() {
				var self = this;
				if (self.selectAll) {
					// 모든 항목 선택
					self.selectCheck = [];
					for (var i = 0; i < self.list.length; i++) {
						var item = self.list[i];
						self.selectCheck.push(item.cartNo);
					}
				}else{
					self.selectCheck = []; // 선택 해제
				}
		  	},
			updateSelectCheck() {
				var self = this;
			    var allChecked = true; // 모든 항목이 선택되었다고 가정
			    for (var i = 0; i < self.list.length; i++) {
			        var item = self.list[i];
			        if (!self.selectCheck.includes(item.cartNo)) {
			            allChecked = false; // 선택되지 않은 항목이 있으면 false
			            break; // 더 이상 확인할 필요 없음
			        }
			    }
			    self.selectAll = allChecked; // 전체 선택 상태 업데이트
			},
			fnPay(){
				if(confirm('선택하신 상품을 구매하시겠습니까?')){
					//$.pageChange("/productDetail/pay.do",{carList : self.list});
				}else{
					alert('취소되었습니다');
				}
			}
        },
        mounted() {
            var self = this;
			self.fnGetCartList();
        }
    });
    app.mount('#app');
</script>
