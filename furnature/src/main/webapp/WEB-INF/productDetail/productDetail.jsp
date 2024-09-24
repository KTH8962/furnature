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
			세션: {{sessionId}}
            <div style="display: flex; align-items: center; flex-direction: column;">
				<!--<div>	DB저장된 모든 썸네일 출력
					<template v-for="item in urlList">
						<img :src="item.prodcutThumbnail" style="height : 100px; width : 100px;">
					</template>
				</div>-->
				<!-- 상세 페이지 썸네일 , 이름, 가격, 사이즈 등 정보 출력 -->
				<div><img :src="productDetail.productThumbnail" alt="썸네일"></div>
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
						<!--<template v-if="selectedSize != '' ||selectedSize == '0'">-->
						<template v-for="(item,index) in selectedSize">
							<div>
								{{productDetail.productName}} {{ item.size }}번 사이즈
								<button type="button" @click="fnUp(index)">+</button>
								<input type="text" v-model="item.count">
								<button type="button" @click="fnDown(index)">-</button>
								{{(item.price * item.count).toLocaleString()}}원
								<!--toLocaleString() >> 숫자를 천단위에 , 넣어서 출력해주는 함수-->
							</div>
						</template>
						<div>총 합계: {{ totalPrice }}원</div>
				</div>
				<div><!-- 구매/ 커스텀 등 버튼 구현 -->
					<button type="button" @click="fnPay">구매하기</button>
					<button type="button" @click="fnBasket">장바구니</button>
					<button type="button">좋아요 버튼?</button>
					<!-- 커스텀 버튼은 커스텀 가능 물품만 버튼 보이게 하기.-->
					<button type="button" @click="fnCustom">커스텀 버튼</button>
				</div>
				<div><!-- 상세정보 이미지 출력 전에 띄울 버튼?-->
					<div>이동할때 쓸 A태그==========================</div>
					<ul>
						<a href="#"><li>상세정보</li></a>
						<a href="#"><li>배송교환정보</li></a>
						<a gref="#"><li>관련추천상품</li></a>
						<a href="#review"><li>후기</li></a>
					</ul>
				</div>
				<div>	<!--제품 상세정보 이미지 영역-->
     			<img :src="productDetail.productDetail1" alt="제품상세정보1">
					
				</div>
				<div><!--배송교환정보 영역-->
				</div>
				<div><!--관련추천상품 4개정도 뿌리기-->
					<div>관련 추천 상품 목록 만들어야함 ==========================</div>
				</div>
				<div id="review"> <!-- 제품 리뷰 영역 5개 정도씩 보이게, 페이징처리 추천순 최신순 별점순 ?-->
					<div>리뷰======================================<button type="button">리뷰작성</div>
					<div>리뷰목록</div>
					<div>
						<div>평점 평균 {{averageRating}}</div>
					</div>
					<div><!-- 보고있는 페이지의 상품번호와 맞는 리뷰 목록들 출력-->
						<template v-for="item in reviewList">
							<div v-if="item.productNo==productDetail.productNo">
								<div>리뷰넘버(시퀀스번호) : {{item.reviewNo}}</div>
								<div>리뷰 제목 : {{item.reviewTitle}}</div>
								<div>리뷰 내용 :{{item.reviewContents}}</div>
								<div>평점 : {{item.reviewRating}}</div>
							</div> <br>
						</template>
					</div>
					<!--보고있는 페이지의 상품번호와 맞는 리뷰 없을때-->
					<div v-if="reviewList == null || reviewList.length  === 0">등록된 리뷰가 없습니다.</div>
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
				urlList : [],		//모든 이미지 url 리스트 (사용안하는 샘플 fnGetUrlList 사용하는 변수)
				productDetail : [],	// 상품 번호에 맞는 상품의 상세정보
				sizeList : [],		// 현재 상품의 상품 각 사이즈를 리스트에 담아 관리
				sizeSelect : "",	// select v-model 사용하기 위한 변수
				addPrice :	"",		// 사이즈에 가격 넣기위한 변수
				productNo : '${productNo}', //상품페이지 에서 클릭한 상품번호 받아오는 변수
				selectedSize : [],	// 선택된 select 변수로 저장하기위한 리스트
				sessionId: "${sessionId}",
				sessionAuth: "${sessionAuth}",
				reviewList : []
            };
        },
		computed: {
			//주문목록 총 가격
		    totalPrice() {
				var self = this;
				//self.selectedSize.reduce(...) -> selectedSize 배열을 순회해서 total에 누적값 넣어줌
				//for문 사용하지 않아도 됨
		        return self.selectedSize.reduce((total, item) => {
		            return total + (item.price * item.count);
		        }, 0).toLocaleString();
		    },
			averageRating(){
				var self = this;
				if(self.reviewList.length===0){ // 등록된 리뷰가 없을때 0 리턴.
					return 0;
				}	
				// 총가격 구할때 사용한 같은 방식 sum에 0으로 초기화 시켜준 후 reviewList의 인덱스값(item) 만큼 sum + ~~ 해줌
				var totalRating = self.reviewList.reduce((sum, item) => { 
				            return sum + parseFloat(item.reviewRating); //문자열이라 parseFloat 형식 변환해주고 더하기
				        }, 0);
				return (totalRating / self.reviewList.length).toString().slice(0, 3);
			},
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
						
						//상품번호에 맞는 사이즈를 리스트 안에 담아주기
						self.sizeList = [
						     data.productDetail.productSize1,
						     data.productDetail.productSize2,
						     data.productDetail.productSize3
						 ].filter(size => size != null); // null 값을 제외하고 필터링
						console.log(self.sizeList);
					}
				});
            },
			// 모든 이미지 출력 함수 (사용 안하는 샘플입니다.)
			fnGetUrlList(){
				var self = this;
				var nparmap = {};
				$.ajax({
					url:"/productDetail/samplesejin.dox",
					dataType:"json",
					type : "POST", 
					data : nparmap,
					success : function(data) { 
						self.urlList = data.urlList;
					}
				});
          	},
			// 커스텀 버튼
			fnCustom(){
				confirm('커스텀 하시겠습니까?');
			},
			// 결제 버튼
			fnPay(){
				var self = this;
				if(self.sessionId == null || self.sessionId == ''){
					alert('로그인 후 구매 가능합니다.');
					window.location.reload();
				}else{
					if(self.selectedSize == null || self.selectedSize ==''){
						alert('선택된 상품이 없습니다.');
						console.log("???"+self.selectedSize);
					}else{
						
						for(var i=0; i<self.selectedSize.length;i++){	//선택 순서에 따라 담긴 list에 맞는 사이즈로 변경 
							for(var j=0; j<self.sizeList.length;j++){
								if(self.selectedSize[i].size==j){
									self.selectedSize[i].size = self.sizeList[j];
								}
							}
						}
						$.pageChange("pay.do",{productNo : self.productNo , totalPrice : self.totalPrice , selectedSize : self.selectedSize});
					}
					
				}
			},
			// 장바구니 버튼
			fnBasket(productNo){
				<!--$.pageChange("basket.do",{productNo: productNo});-->
			},
			// 사이즈 선택 
			fnSelectSize(){
				var self = this;
				var isDuplicate = false;	// 중복 체크 확인 변수
				// selectedSize 배열 중복 체크
				for (var i = 0; i < self.selectedSize.length; i++) {
				    if (self.selectedSize[i].size === self.sizeSelect) {
				        isDuplicate = true;	//중복시 true로 변경
				        break; // 중복 발견시 종료
				    }
				}
				// 중복시 알림창
				if (isDuplicate) {
				    alert('이미 선택된 사이즈입니다.');
				    self.sizeSelect = '';
				    return;
				}
				
				// 사이즈 선택시 상세정보에 sizeList 리스트에 담아둔 사이즈를 인덱스 값에 따라 가격 추가 
				if (self.sizeSelect === 0) {
				    self.addPrice = parseInt(self.productDetail.productPrice, 10); // 문자열을 숫자로 변환
				} else if (self.sizeSelect === 1) {
				    self.addPrice = parseInt(self.productDetail.productPrice, 10) + 20000;
				} else if (self.sizeSelect === 2) {
				    self.addPrice = parseInt(self.productDetail.productPrice, 10) + 40000;
				}
				
				 if (self.sizeSelect !== '') {
				            self.selectedSize.push({
				                size: self.sizeSelect,
				                price: self.addPrice,
								count : 1
				            });
				}
				
				self.sizeSelect = '';
				console.log(self.sizeSelect);
				console.log(self.selectedSize);
			},
			//수량 - 버튼
			fnUp(index){
				var self=this;
				self.selectedSize[index].count ++;
				console.log(self.totalPrice);
			},
			// 수량 + 버튼
			fnDown(index){
				var self=this;
				self.selectedSize[index].count --;
				if(self.selectedSize[index].count <1){
					alert('수량은 1개 이상 !');
					self.selectedSize[index].count = 1;
				}
					console.log(self.totalPrice);
			},
			fnGetReviewList(){
				var self = this;
				var nparmap = {productNo : self.productNo};
				$.ajax({
					url:"/productDetail/productReview.dox",
					dataType:"json",
					type : "POST", 
					data : nparmap,
					success : function(data) { 
						console.log(data);
						self.reviewList = data.reviewList;
					}
				});
	      	}
        },
        mounted() {
            var self = this;
			self.fnGetProductDetail();
			self.fnGetUrlList();
			self.fnGetReviewList();
        }
    });
    app.mount('#app');
</script>
​