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
            <p class="blind">샘플페이지</p>
            <div style="display: flex; align-items: center; flex-direction: column;">
				<!--<div>	DB저장된 모든 썸네일 출력
					<template v-for="item in urlList">
						<img :src="item.prodcutThumbnail" style="height : 100px; width : 100px;">
					</template>
				</div>-->
				<!-- 상세 페이지 썸네일 , 이름, 가격, 사이즈 등 정보 출력 -->
				<div><img :src="productDetail.prodcutThumbnail" alt="썸네일"></div>
				<div>{{productDetail.productName}}</div>
				<div>{{productDetail.productPrice}}</div>
				<div>{{productDetail.productColor}}</div>
				<div>
					<select v-model="sizeSelect" @change="fnSelectSize">
						<option value="">사이즈 선택</option>
						<option v-for="(item,index) in sizeList" :value="index">
							<template v-if="index=='0'">
							{{item}}
							</template>
							<template v-if="index=='1'">
								{{item}} : + 20000 원
							</template>
							<template v-if="index=='2'">
								{{item}} : + 40000 원
							</template>
						</option>					
					</select>
				</div>
				<div><!-- 사이즈 선택 후 목록 출력-->
						<template v-if="sizeSelect != '' ||sizeSelect == '0'">
							{{productDetail.productName}} {{sizeSelect}}번 사이즈 {{addPrice}}원
						</template>
				</div>
				<div><!-- 구매/ 커스텀 등 버튼 구현 -->
					<button type="button" @click="fnPay">구매하기</button>
					<button type="button" @click="fnBasket">장바구니</button>
					<button type="button">좋아요 버튼?</button>
					<!-- 커스텀 버튼은 커스텀 가능 물품만 버튼 보이게 하기.-->
					<button type="button" @click="fnCustom">커스텀 버튼</button>
				</div>
				<div><!-- 상세정보 이미지 출력 전에 띄울 버튼?-->
					<ul>
						<a href="#"><li>상세정보</li></a>
						<a href="#"><li>배송교환정보</li></a>
						<a gref="#"><li>관련추천상품</li></a>
						<a href="#review"><li>후기</li></a>
					</ul>
				</div>
				<div>	<!--제품 상세정보 이미지 영역-->
<!--					<img :src="productDetail.productDetail1" alt="제품상세정보1">
					<img :src="productDetail.productDetail2" alt="제품상세정보2">
					<img :src="productDetail.productDetail3" alt="제품상세정보3">
					<img :src="productDetail.productDetail4" alt="제품상세정보4">	-->
				</div>
				<div><!--배송교환정보 영역-->
				</div>
				<div><!--관련추천상품 4개정도 뿌리기-->
				</div>
				<div id="review"> <!-- 제품 리뷰 영역 5개 정도씩 보이게, 페이징처리 추천순 최신순 별점순 ?-->
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
				urlList : [],
				productDetail : [],
				sizeList : [],
				sizeSelect : "",
				addPrice :	"",
				productNo : '${productNo}' //전담 연동
            };
        },
        methods: {
            fnGetProductDetail(){
				var self = this;
				var nparmap = {productNo : self.productNo};
				$.ajax({
					url:"/productDetail/productDetail.dox",
					dataType:"json",	
					type : "POST", 
					data : nparmap,
					success : function(data) { 
						console.log(data);
						self.productDetail = data.productDetail;
						
						if(data.productDetail.productSize1 != null){
							self.sizeList = [data.productDetail.productSize1]
							if(data.productDetail.productSize2 != null){
								self.sizeList = [data.productDetail.productSize1, data.productDetail.productSize2]
							}if(data.productDetail.productSize3 != null){
								self.sizeList = [data.productDetail.productSize1, data.productDetail.productSize2, data.productDetail.productSize3]
							}
						}
						console.log(self.sizeList);
					}
				});
            },
			fnGetUrlList(){
				var self = this;
				var nparmap = {};
				$.ajax({
					url:"/productDetail/samplesejin.dox",
					dataType:"json",
					type : "POST", 
					data : nparmap,
					success : function(data) { 
						console.log(data);
						self.urlList = data.urlList;
					}
				});
          	},
			fnCustom(){
				confirm('커스텀 하시겠습니까?');
			},
			fnPay(productNo){
				<!--$.pageChange("pay.do",{productNo : productNo});-->
			},
			fnBasket(productNo){
				<!--$.pageChange("basket.do",{productNo: productNo});-->
			},
			fnSelectSize(){
				var self = this;
				
				if (self.sizeSelect === 0) {
				    self.addPrice = parseInt(self.productDetail.productPrice, 10); // 문자열을 숫자로 변환
				} else if (self.sizeSelect === 1) {
				    self.addPrice = parseInt(self.productDetail.productPrice, 10) + 20000;
				} else if (self.sizeSelect === 2) {
				    self.addPrice = parseInt(self.productDetail.productPrice, 10) + 40000;
				}
				console.log(self.sizeSelect);
				console.log(self.addPrice);
				
			}
        },
        mounted() {
            var self = this;
			self.fnGetProductDetail();
			self.fnGetUrlList();
        }
    });
    app.mount('#app');
</script>
​