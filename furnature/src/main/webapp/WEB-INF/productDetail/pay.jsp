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
			<div>
				<div>주문상품</div>
				<div><img :src="productDetail.productThumbnail" style="height : 300px; width : 300px;"></div>
				<div>상품명 : {{productDetail.productName}}</div>
				<div><template v-for="item in selectedSize">사이즈 {{item.size}} 수량 {{item.count}} 판매가 {{ (item.price*1).toLocaleString() }} <br> </template>총 구매가격 : {{parseInt(totalPrice).toLocaleString()}}</div>
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
				<div>보유 포인트 : {{myPoint}}</div>
				<div>사용 포인트 : <input type="text" placeholder="0" v-model="pointPay" @change="fnPointLimit">원
					<button type="button" @click="fnPoint">전액사용</button>
				</div>
				<div>최종 결제 금액 : {{totalPrice}}</div>
			</div>
			<div>
				약관동의 
				<input type="checkbox">전체
				<input type="checkbox">개인정보 수집,이용동의
				<input type="checkbox">상기결제정보 확인했으며, 구매진행 동의
			</div>
			
			<div>
				<div>최종 결제 금액 : {{payPrice}} </div>
				<div>구매시 적립 마일리지 : {{mileage}}</div>
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
				totalPrice: parseFloat('${totalPrice}'.replace(/[^0-9.-]+/g,"")) || 0, // 문자열로 받아와서 숫자로 변화ㄴ
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
				deliveryInfo : "",
				myPoint : 100000,
				pointPay : 0,
            };
        },
		computed: {
			//주문목록 총 가격
		    payPrice() {
				var self = this;
		       	return Math.max(this.totalPrice - this.pointPay, 0); // 음수일 경우도 무조건 0 으로 출력
		    },
			mileage(){
						var self = this;
						return parseInt(self.payPrice * 0.05);
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
								
								// selectedSize가 문자열 형식으로 넘어와서 파싱하고 배열 형태로 변환
								if (typeof self.selectedSize === 'string') {
								    self.selectedSize = JSON.parse(self.selectedSize);
								}
								console.log(data)
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
					self.postcode =self.info.userZipCode;
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
				var orderList = JSON.stringify(self.selectedSize);
			  IMP.request_pay({
			    pg: "html5_inicis.INIpayTest",
			    pay_method: "card",
			    merchant_uid: "product" + new Date().getTime(), //주문번호
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
                     	
						var nparmap = {impUid : rsp.imp_uid, orderNo : rsp.merchant_uid, orderPrice : rsp.paid_amount, userId : self.info.userId ,productNo : self.productNo, orderList : orderList, mileage : self.mileage};
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
					   console.log(rsp.merchant_uid);
					   console.log(self.info.userId);
					   console.log(self.productNo);
					   console.log(self.selectedSize);
					   
                   }
                   alert(msg);
				   location.reload();
               });
			},
			fnPoint(){
				var self=this;
				if(self.totalPrice<=self.myPoint){
					self.pointPay = self.totalPrice;
				}else{
					self.pointPay = self.myPoint;
				}
			},
			fnPointLimit(){
				var self=this;
				if(self.pointPay>self.myPoint){
					alert('보유 금액 이상은 사용 불가능 합니다.');
					if(self.totalPrice<=self.myPoint){
						self.pointPay = self.totalPrice;
					}else{
						self.pointPay = self.myPoint;						
					}
				}
				if(self.totalPrice<self.pointPay){
					alert('사용 포인트가 구매가격을 넘었습니다.');
						self.pointPay = self.totalPrice;
				}
			}
        },
        mounted() {
            var self = this;
			self.fnGetProductDetail();
			self.fnGetInfo();
        }
    });
    app.mount('#app');
</script>