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
			<div class="detail-top">
				<div class="thumb-wrap auction-detail-thumb-list">
					<div class="thum-list" style="width : 2000px;">
						<div class="thumb-box"><img :src="productDetail.productThumbnail" alt="썸네일"></div>
						<div class="thumb-box"><img :src="productDetail.productThumbnail" alt="썸네일"></div>
						<div class="thumb-box"><img :src="productDetail.productThumbnail" alt="썸네일"></div>
					</div>
					<div class="thum-arrow">
						<button type="button" class="prev"></button>
						<button type="button" class="next"></button>
					</div>
				</div>
				<div class="detail-top-info">
					<div class="detail=box">
						<div class="tit">상품명</div>
						<div class="info">{{productDetail.productName}}</div>
					</div>
					<div class="detail=box">
						<div class="tit">상품 가격</div>
						<div class="info">{{parseInt(productDetail.productPrice).toLocaleString()}}</div>
					</div>
					<div class="detail=box">
						<div class="tit">색상</div>
						<div class="info">{{productDetail.productColor}}</div>
					</div>
					<div class="detail=box">
						<div class="tit">사이즈 선택</div>
						<div class="info">
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
					</div>
					<div class="detail=box">
						<div class="tit">사이즈 선택</div>
						<div class="info">
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
						</div>
					</div>
					<div class="detail-box">
						<div class="info"><!-- 구매/ 커스텀 등 버튼 구현 -->
							<button type="button" @click="fnPay">구매하기</button><br>
							<button type="button" @click="fnBasket">장바구니</button><br>
							<!--<button type="button">좋아요 버튼?</button>-->
							<!-- 커스텀 버튼은 커스텀 가능 물품만 버튼 보이게 하기.-->
							<button type="button" @click="fnCustom">커스텀 버튼</button>
						</div>
					</div>
					
				</div>
			</div>
			<div class="detail-tap"></div>
			<div class="detail-bottom"></div>
            <div style="display: flex; align-items: center; flex-direction: column;">
				<!--<div>	DB저장된 모든 썸네일 출력
					<template v-for="item in urlList">
						<img :src="item.prodcutThumbnail" style="height : 100px; width : 100px;">
					</template>
				</div>-->
				<!-- 상세 페이지 썸네일 , 이름, 가격, 사이즈 등 정보 출력 -->
				
				
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
					<div>리뷰======================================<button type="button" @click="fnReviewInsert">리뷰작성하기</div>
					<div v-if="insertModal">
						모달 리뷰 작성영역
						<!-- repeqt는 숫자만큼 '' 안에 문자열을 출력해주는 함수-->
						<select v-model="reviewRating">
						    <option v-for="(title, index) in reviewTitle" :key="index" :value="index + 1">
						        {{ '★'.repeat(index + 1) + '☆'.repeat(5 - (index + 1)) }} - {{ title }}
						    </option>
						</select>
						<div>내용<textarea v-model="reviewContents"></textarea></div>
						<div>사진첨부<input type="file" accept=".gif,.jpg,.png" @change="fnReviewAttach"></div>
						<button @click="fnReviewInsertSave">리뷰작성</button>
						<button @click="fnCancel">취소</button>
						
					</div>
					<div>리뷰목록</div>
					<div>
						<div>평점 평균<span style="color: gold; font-size: 3em;">★</span> {{ratingAvg}}</div>
					</div>
					<div><!-- 보고있는 페이지의 상품번호와 맞는 리뷰 목록들 출력-->
						<template v-for="item in reviewList">
							<div v-if="item.productNo==productDetail.productNo">
								<div v-if="item.reviewImgPath != null"><img :src="item.reviewImgPath" style= "width : 250px ; height : 250px"></div>
								<div>{{item.reviewCdateTime}}</div>
								<div>
									{{item.reviewTitle}}
									<template v-if="item.reviewRating">
								        <span v-for="star in 5" :key="star" style="color: gold;">
								            {{ star <= item.reviewRating ? '★' : '☆' }}
								        </span>
								    </template> 
									<!--평점 :{{item.reviewRating}}-->
								</div>
								<div>{{item.reviewContents}}</div>
								<div v-if="item.userId==sessionId">
								    <button type="button" @click="fnReviewUpdate(item.reviewNo)">수정</button>
								    <div v-if="updateModal && updateReviewNo === item.reviewNo">
								        {{updateReviewNo}}모달 수정영역 {{item.reviewNo}}
										<!-- repeqt는 숫자만큼 '' 안에 문자열을 출력해주는 함수-->
								        <select v-model="reviewRating">
								            <option v-for="(title, index) in reviewTitle" :key="index" :value="index + 1">
								                {{ '★'.repeat(index + 1) + '☆'.repeat(5 - (index + 1)) }} - {{ title }}
								            </option>
								        </select>
								        <div>내용<textarea v-model="reviewContents"></textarea></div>
								        <div>사진첨부<input type="file" accept=".gif,.jpg,.png" @change="fnReviewAttach"></div>
								        <div>
											<button @click="fnReviewUpdateSave(item.reviewNo)">수정완료</button>
								        	<button @click="fnCancel">취소</button>
										</div>
								    </div>
									<div><button type="button" @click="fnReviewDelete(item.reviewNo)">삭제</button></div>
								</div>
							</div>
						</template>
						<div class="pagenation">
						            <button type="button" class="prev" v-if="currentPage > 1" @click="fnBeforPage()">이전</button>
						            <button type="button" class="num" v-for="page in totalPages" :class="{active: page == currentPage}" @click="fnGetReviewList(page)">
										{{page}}
									</button>
						            <button type="button" class="next" v-if="currentPage < totalPages" @click="fnNextPage()">다음</button>
						        </div>
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
				reviewList : [],
				insertModal : false,
				updateModal : false,
				reviewTitle : ['별로에요', '그저그래요', '좋아요', '맘에들어요', '아주좋아요'],	//리뷰제목
				reviewContents : "",	//리뷰내용
				reviewRating : 5,	//리뷰평점
				file : null,
				updateReviewNo : "",
				currentPage: 1,      
				pageSize: 4,        
				totalPages: 1,
				ratingAvg : 0
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
		    } 
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
			// 장바구니 버튼 shoppingcart
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
			//리뷰 목록 출력
			fnGetReviewList(page){
				var self = this;
				var startIndex = (page-1) *self.pageSize;		
				self.currentPage = page;
				var outputNumber = this.pageSize;
				var nparmap = {
					productNo : self.productNo,
					startIndex : startIndex,
			 	    outputNumber : outputNumber,
				};
				$.ajax({
					url:"/productDetail/productReview.dox",
					dataType:"json",
					type : "POST", 
					data : nparmap,
					success : function(data) { 
						console.log(data);
						self.reviewList = data.reviewList;
						self.totalPages = Math.ceil(data.count/self.pageSize);
						if(data != null && data.reviewList.length > 0){
							self.ratingAvg = data.reviewList[0].avgRating
						}
					}
				});
	      	},
			//리뷰 작성 모달버튼
			fnReviewInsert(){
				var self = this;
				if(self.sessionId != ""){
					var self = this;
					var url = '/productDetail/reviewInsert.do?productNo=' + encodeURIComponent(self.productNo);
					var option = 'width = 700 , height = 600, scrollbars = yes, left = 550, top = 200'; 
					//window.open(url,'review',option);
					if(confirm('리뷰를 작성하시겠습니까?')){
						self.insertModal = !self.insertModal;
					}
					//location.href='/productDetail/reviewInsert.do?productNo='+ encodeURIComponent(self.productNo);
				}else{
					alert('로그인 후 이용해주세요.');
				}
			},
			//리뷰 삭제버튼
			fnReviewDelete(reviewNo){
				var self = this;
				var nparmap = {reviewNo : reviewNo};
				if (confirm('정말 삭제하시겠습니까?')) {
					$.ajax({
						url:"/productDetail/deleteReview.dox",
						dataType:"json",	
						type : "POST", 
						data : nparmap,
						success : function(data) {
							self.fnGetProductDetail();
							alert('리뷰가 삭제되었습니다.')
							window.location.reload();
						}
					});
				} else {
				    // 사용자가 "취소"를 클릭한 경우
				    alert('삭제가 취소되었습니다.');
				}
			},
			//리뷰 수정 모달버튼
			fnReviewUpdate(reviewNo){
				var self = this;
				var self = this;
				if(confirm('리뷰를 수정하시겠습니까?')){
					self.reviewContents = "";
				  	self.updateReviewNo = reviewNo; // 현재 수정할 리뷰 번호 저장
				  	self.updateModal = true;
				}else{
					self.updateModal = false;
				}
			},
			fnReviewAttach(event){
				this.file = event.target.files[0];
			},
			//리뷰작성 모달내 리뷰저장
			fnReviewInsertSave(){
			var self = this;
			var reviewIndex = self.reviewRating - 1; //선택한 셀렉 옵션 인덱스값
			var nparmap = {
				reviewTitle : self.reviewTitle[reviewIndex], //컨트롤러에 배열형식으로 넘어가서 인덱스값으로 넘겨주기 
				reviewContents : self.reviewContents,
				userId : self.sessionId,
				productNo : self.productNo,
				reviewRating : self.reviewRating
			};
			$.ajax({
				url:"/productDetail/reviewInsert.dox",
				dataType:"json",	
				type : "POST", 
				data : nparmap,
				success : function(data) {
					console.log(data);
					console.log(data.reviewNo);
					var reviewNo = data.reviewNo;
					if(self.file){
						console.log(data.reviewNo);
					  const formData = new FormData();
					  formData.append('file1', self.file);
					  formData.append('reviewNo', reviewNo);
					  $.ajax({
						url: '/productDetail/reviewImgFile.dox',
						type: 'POST',
						data: formData,
						processData: false,  
						contentType: false,  
						success: function() {
							if(data && data.reviewNo){
								alert("리뷰가 등록되었습니다.");
								window.location.reload();
								self.insertModal = false;
							} else{
								alert("리뷰 등록에 실패했습니다.");
							}
						},
						error: function(jqXHR, textStatus, errorThrown) {
						  console.error('업로드 실패!', textStatus, errorThrown);
						}
					  });
					}
					alert('리뷰가 등록되었습니다.');
					window.location.reload();
				}
			});
			},
			//리뷰 수정모달내 저장버튼
			fnReviewUpdateSave(reviewNo){
				var self = this;
				var reviewIndex = self.reviewRating - 1; //선택한 셀렉 옵션 인덱스값
				var nparmap = {
					reviewNo : reviewNo,
					reviewTitle : self.reviewTitle[reviewIndex], //컨트롤러에 배열형식으로 넘어가서 인덱스값으로 넘겨주기 
					reviewContents : self.reviewContents,
					reviewRating : self.reviewRating
				};
				if (confirm('정말 수정하시겠습니까?')) {
					$.ajax({
						url:"/productDetail/updateReview.dox",
						dataType:"json",	
						type : "POST", 
						data : nparmap,
						success : function(data) {
							console.log(data);
							console.log(data.reviewNo);
							var reviewNo = data.reviewNo;
							if(self.file){
								console.log(data.reviewNo);
							  const formData = new FormData();
							  formData.append('file1', self.file);
							  formData.append('reviewNo', reviewNo);
							  $.ajax({
								url: '/productDetail/reviewImgFile.dox',
								type: 'POST',
								data: formData,
								processData: false,  
								contentType: false,  
								success: function() {
									if(data && data.reviewNo){
										alert("리뷰가 수정되었습니다.");
										window.location.reload();
										self.updateModal = false;
									} else{
										alert("리뷰 수정에 실패했습니다.");
									}
								},
								error: function(jqXHR, textStatus, errorThrown) {
								  console.error('업로드 실패!', textStatus, errorThrown);
								}
							  });
							}
						}
					});
					window.location.reload();
					alert("리뷰가 수정되었습니다.");
				} else {
				    // 사용자가 "취소"를 클릭한 경우
				    alert('삭제가 취소되었습니다.');
				}
			},
			//취소 버튼
			fnCancel(){
				var self = this;
				self.updateModal = false;
				self.insertModal = false;
				self.contents = "";
				alert('취소되었습니다.');
			},
			fnBeforPage(){
				var self = this;
				self.currentPage = self.currentPage - 1;
				self.fnGetReviewList(self.currentPage);
			},
			fnNextPage(){
				var self = this;
				self.currentPage = self.currentPage + 1;
				self.fnGetReviewList(self.currentPage);
			}
        },
        mounted() {
            var self = this;
			self.fnGetProductDetail();
			self.fnGetUrlList();
			self.fnGetReviewList(1);
        }
    });
    app.mount('#app');
</script>
​