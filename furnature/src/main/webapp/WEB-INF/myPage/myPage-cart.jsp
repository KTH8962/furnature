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
            <p class="blind">마이페이지 - 장바구니</p>
			<div class="myPage-wrap">
				<div class="myPage-snb-wrap">
					<jsp:include page="/layout/myPageSnb.jsp"></jsp:include>
				</div>
				<div class="myPage myPage-info">
					<div>{{sessionId}}님의 장바구니 내역</div>
					<div v-if="!list || list.length === 0">
					    장바구니 목록이 없습니다.
						<div><button @click="fnBuy">구매하러가기</button></div>
					</div>
					<div>장바구니 목록
						<div v-for="(items, productNo) in groupList"> <!--상품번호로 만든 맵 반복 -->
							<div>
								<a href="#" @click="fnProDetail(productNo)">
									<img :src="items[0].productThumbnail" style="width: 200px; height: 200px">
									{{items[0].productName}}
								</a>
								<div v-for="item in items">
									<div>선택한 사이즈 {{item.productSize}}</div>
									<div>{{(item.productPrice*1).toLocaleString()}}원</div>
									<div>{{item.count}}개</div>
									<div>{{(item.count * item.productPrice).toLocaleString()}}원</div>
								</div>
							</div>
						</div>
						<div>
							총구매가격 : {{totalPrice.toLocaleString()}}
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
				list: []
            };
        },
        computed: {
            groupList() {	// 상품 번호끼리 묶끼
                var group = {};
				var self = this;
                for (let i = 0; i < self.list.length; i++) {
                    var item = self.list[i];
                    if (!group[item.productNo]) {
                        group[item.productNo] = [];
                    }
                    group[item.productNo].push(item);
                }
                return group;
            },
			totalPrice() { // 총 가격
				var self = this;
				var total = 0;
				var items;
				var item;
				for (var productNo in this.groupList) { // 상품 번호 반복
					items = this.groupList[productNo]; // 상품 번호에 해당하는 아이템 배열
					for (var j = 0; j < items.length; j++) { // 아이템 배열 반복
						item = items[j];
						total += item.productPrice * item.count; // 가격 * 수량 더하기
					}
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
		   fnBuy(){
				location.href="/product/product.do"
		   },
		   fnProDetail(productNo){
				$.pageChange("/productDetail/productDetail.do", {productNo: productNo});
		   }
        },
        mounted() {
            var self = this;
			self.fnGetCartList();
        }
    });
    app.mount('#app');
</script>
