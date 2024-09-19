<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
            <p class="blind">기본페이지</p>
			{{sessionId}}
			{{info}}
			<div>
				<div>주문상품</div>
				<div>썸네일</div>
				<div>상품명 : {{productDetail.productName}}</div>
				<div><template v-for="item in selectedSize">사이즈별 수량 판매가 배송비? 최종구매가 : {{item}}</template></div>
				
			</div>
			<div>
				<div>주문자정보 확인</div>
				<!--<div>주문자<input type="text" :value=info.userName readonly="readonly"></div>-->
				<div>주문자 {{info.userName}}</div>
				<div>휴대전화 {{info.userPhone}}</div>
			</div>
			<div>
				<div>배송지 정보</div>
				<div>
					<label><input type="radio" name="as" value="10" @click="fnDeliveryInfo(10)">주문자정보와 동일</label>
					<label><input type="radio" name="as" value="20" @click="fnDeliveryInfo(20)">직접입력</label> 
				</div>
				<div>
					<div>받는사람  <input type="text" v-model="name"> </div>
					<div>휴대폰 번호  <input type="text" v-model="phone"></div>
					<div>주소
									<input type="text" id="postcode" placeholder="우편번호" readonly="readonly" v-model="postcode"><br>
									<button type="button" @click="daumPost">주소검색</button><br>
									<input type="text" id="address" placeholder="주소"  readonly="readonly" v-model="address"><br>
									<input type="text" id="detailAddress" placeholder="상세주소" v-model="detailAddress" ref="addrRef">
					</div>
					<div>배송요청사항</div>
				</div>
			</div>
			<div>
				<div>결제정보</div>
				<div>총 상품 금액 : {{totalPrice}}</div>
				<div>포인트</div>
				<div>총 할인금액 / 사용포인트 :</div>
				<div>최종 결제 금액 : {{totalPrice}}</div>
			</div>
			<div>
				약관동의 
				<input type="checkbox">전체
				<input type="checkbox">개인정보 수집,이용동의
				<input type="checkbox">상기결제정보 확인했으며, 구매진행 동의
			</div>
			
			<div>
				<div>최종 결제 금액 : </div>
				<div>결제수단 ??</div>
				<div>
					<button type="button" @click="fnOrder">결제하기</button>
					<button type="button">취소하기/돌아가기</button>
				</div>
			</div>
		</div>
	</div>
	<jsp:include page="/layout/footer.jsp"></jsp:include>
</body>
</html>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
	//포트원 결제 api 사용
	IMP.init("imp16537616");
	
    const app = Vue.createApp({
        data() {
            return {
				productNo : '${productNo}',
				productDetail : [], //상품상세정보
				totalPrice : '${totalPrice}',
				selectedSize : '${selectedSize}',
				sizeList : [],
				detailAddress : "",
				address : "",
				postCode : "",
				sessionId: "${sessionId}",
				sessionAuth: "${sessionAuth}",
				info :[],
				name : "",
				phone : "",
				postcode : "",
				deliveryInfo : ""
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
								
								//상품번호에 맞는 사이즈를 리스트 안에 담아주기
								self.sizeList = [
								     data.productDetail.productSize1,
								     data.productDetail.productSize2,
								     data.productDetail.productSize3
								 ].filter(size => size != null); // null 값을 제외하고 필터링
								
								// selectedSize가 문자열 형식으로 넘어와서 파싱하고 배열 형태로 변환
								if (typeof self.selectedSize === 'string') {
								    self.selectedSize = JSON.parse(self.selectedSize);
								}
								
								console.log(self.sizeList);
								console.log(self.selectedSize);
							}
						});
			        },
			daumPost(){
				var self = this;
			    new daum.Postcode({
			        oncomplete: function(data) {
			            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분입니다.
			            // 예제를 참고하여 다양한 활용법을 확인해 보세요.
			            
			            //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
			            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
			                addr = data.roadAddress;
			            } else { // 사용자가 지번 주소를 선택했을 경우(J)
			                addr = data.jibunAddress;
			            }
			            document.getElementById('postcode').value = data.zonecode;
			            self.address = addr;
			            document.getElementById('detailAddress').focus();
			        }
			    }).open();
			},
			fnGetInfo(){
				var self = this;
				var nparmap = {sessionId: self.sessionId};
				$.ajax({
					url:"/myPage/myPage.dox",
					dataType:"json",	
					type : "POST", 
					data : nparmap,
					success : function(data) {
						self.info = data.info;
						console.log("userinfo"+data.info);
						console.log( new Date().getTime());
					}
				});
			},
			fnDeliveryInfo(value){
				var self = this;
				self.deliveryInfo = value;
				if(value==10){
					self.name = self.info.userName;
					self.phone = self.info.userPhone;
					self.address = self.info.userAddr;
					self.postcode ='123456';
				}else{
					self.name = "";
					self.phone = "";
					self.address = "";
					self.postcode = "";
				}
				console.log(value);
			},
			fnOrder() {
				var self = this;
			  IMP.request_pay({
			    pg: "html5_inicis.INIpayTest",
			    pay_method: "card",
			    merchant_uid: "order" + new Date().getTime(), //주문번호
			    name: self.productDetail.productName,	//상품명
			    amount: 100,	//가격
			  //  buyer_name: self.name,	//구매자 이름
			  //  buyer_tel: self.phone,	//구매자 휴대폰
			  // buyer_addr: self.address,	//구매자 주소
			  //  buyer_postcode: self.postcode,	//구매자 우편번호
			  },function (rsp) { //callback
                   if (rsp.success) { // 결제 성공시
                       var msg = '결제가 완료되었습니다.';
					   msg += '주문번호 : ' + rsp.imp_uid;
					   msg += '거래ID : ' + rsp.merchant_uid;
					   msg += '결제금액 : ' + rsp.paid_amount;
                     	
						var nparmap = {impUid : rsp.imp_uid, orderNo : rsp.merchant_uid, orderPrice : rsp.paid_amount, userId : self.info.userId ,productNo : self.productNo};
						$.ajax({
							url:"/productDetail/productOrder.dox",
							dataType:"json",	
							type : "POST", 
							data : nparmap,
							success : function(data) {
							}
						});
                   } else { //결제 실패
                       var msg = '결제를 실패하였습니다.';
                   }
                   alert(msg);
				   //document.location.href="/product/product.do";
               });
			},
        },
        mounted() {
            var self = this;
			self.fnGetProductDetail();
			self.fnGetInfo();
        }
    });
    app.mount('#app');
</script>