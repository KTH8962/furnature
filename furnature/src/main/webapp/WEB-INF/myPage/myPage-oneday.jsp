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
            <p class="blind">마이페이지 - 원데이클래스</p>
            <div class="myPage-wrap">
                <div class="myPage-snb-wrap">
                    <jsp:include page="/layout/myPageSnb.jsp"></jsp:include>
                </div>
                <div class="myPage myPage-oneday">					
                    <div v-if="isCustomer">신청내역
                   		<br>
	                    <div v-for="item in list">
	                        <div>클래스명: {{item.className}}</div>
	                        <div>결제ID: {{item.payId}}</div>
	                        <div>신청일자: {{item.joinDay}}</div>
							<br>
	                        <div><button @click="fnCancel()">수강취소</button></div>
	                    	<br>
							<div><button @click="fnPay">결제</button></div>
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
                userId: '${sessionId}',
				sessionAuth : '${sessionAuth}',
                list: [],
				isCustomer : true,
				className : "",
				price : "",
			    payId : ""
            };
        },
        methods: {
            fnClass() {
				var self = this;
				if(self.sessionAuth=='1'){
					self.isCustomer = true;
					var nparmap = { userId: self.userId };
	                $.ajax({
	                   url: "/myPage/oneday-info.dox",
	                   dataType: "json",
	                   type: "POST",
	                   data: nparmap,
	                   success: function(data) {
	                       self.list = data.onedayInfo;
	                   }
	               });
				}else{
					self.isCustomer = false;
				}
            },
			fnPay() {
			    var self = this;
				var payConfirm = confirm("결제하시겠습니까?");
				if(payConfirm){
					self.fnPay();						
				}else{
					alert("결제를 취소하셨습니다");
				}	
			    IMP.request_pay({
					pg: "html5_inicis",
				    pay_method: "card",
					merchant_uid: 'oneday' + new Date().getTime(),
				    name: self.className,
				    amount: self.price,
				    buyer_tel: "010-0000-0000",
				  }	, function (rsp){ 
			        if (rsp.success) {
			            alert("성공");
			            self.fnSave(rsp);
			        } else {
			            alert("실패");
			        }
			    }); 
			},
	
			fnSave(rsp) {
			    var self = this;
			    var nparmap = {name : self.name, price : rsp.paid_amount, payId : rsp.merchant_uid, classNo:self.classNo, userId:self.userId};
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
			},
        },
        mounted() {
            this.fnClass();
        }
    });
    app.mount('#app');
</script>

