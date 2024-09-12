<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<jsp:include page="/layout/headlink.jsp"></jsp:include>
	<script src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>

	<style>
		img{
			width:600px;
		}
	</style>	
</head>
<body>
	<jsp:include page="/layout/header.jsp"></jsp:include>
	<div id="app">
		<div><img :src="detail.filePath"></div>
		<div>{{detail.classNo}}</div>
		<div>{{detail.className}}</div>
		<div>모집 시작일 : {{detail.startDay}}</div>
		<div>모집 종료일 : {{detail.endDay}}</div>
		<div>수업일자 : {{detail.classDate}}</div>
		<div>수강료 : {{detail.price}}</div>
		<input type="date">
		<div class="onedayJoinForm">
			신청자 이름 : <input type="text" v-model="name">
		</div>
		<div><button @click="fnOnedayJoin">수강신청</button></div>
    </div>
	<jsp:include page="/layout/footer.jsp"></jsp:include>
</body>
</html>
<script>
	const userCode = ""; 
	IMP.init("imp52370275");
	//포트원 결제 api 사용
    const app = Vue.createApp({
            data() {
                return {
                   classNo : '${classNo}',
				   detail : {},
				   userId : "user1",
				   name : "",
				   count : "",
				   price : "",
				   payId : ""
				
                };
            },
            methods: {
				fnDetail(classNo) {
					var self = this;
					var nparmap = {classNo:self.classNo};
					console.log(self.classNo);
					$.ajax({
					url : "/oneday/oneday-detail.dox",
					dataType : "json",
					type : "POST",
					data : nparmap,
					success : function(data){
						self.detail = data.onedayDetail;
						self.price = self.detail.price;
						console.log(data);	
					}
					
				})
				},
			   fnOnedayJoin(){
					var self = this;
					if(self.userId==''){
						alert("수강 신청은 로그인 후 가능합니다")
						return;
					}	
					if(self.name==''){
						alert("이름을 입력해주세요");
						return;
					}		
					var payConfirm = confirm("결제하시겠습니까?");
					if(payConfirm){
						self.fnPay();						
					}else{
						alert("결제를 취소하셨습니다");
					}	
			   },
				fnPay() {
				    var self = this;
				    IMP.request_pay({
						pg: "html5_inicis",
					    pay_method: "card",
						merchant_uid: 'order_' + new Date().getTime(),
					    name: self.name,
					    amount: self.price,
					    buyer_tel: "010-0000-0000",
					  }	, function (rsp){ // callback
				        if (rsp.success) {
				            alert("성공");
				            console.log(rsp);
				            self.fnSave(rsp);
				        } else {
				            alert("실패");
				        }
				    }); 
				},
	
				fnSave(rsp) {
				    var self = this;
				    var nparmap = { name : rsp.name, price : rsp.paid_amount, payId : rsp.merchant_uid, classNo:self.classNo, userId:self.userId};
				    $.ajax({
				        url: "/oneday/oneday-pay.dox",
				        dataType: "json",
				        type: "POST",
				        data: nparmap,
				        success: function (data) {
							if (data.result === "success") {
	                            alert("신청이 완료되었습니다.");
	                        } else {
	                            alert("신청 중 문제가 발생했습니다.");
	                        }
				        }
				    }); 
				}
	        },
            mounted() {
				var self = this;
				self.fnDetail(self.classNo);
            }
        });
        app.mount('#app');
</script>