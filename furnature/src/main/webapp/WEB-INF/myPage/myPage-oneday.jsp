<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <jsp:include page="/layout/headlink.jsp"></jsp:include>
    <script src="https://cdn.iamport.kr/v1/iamport.js"></script>
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
					<h2 class="myPage-tit">원데이클래스 신청내역</h2>			
                    <div v-if="isCustomer">
                   		<br>
	                    <div v-for="item in list">
	                        <div>클래스명: {{item.className}}</div>
	                        <div v-if="item.payStatus==1">결제상태: 결제예정</div>
							<div v-else>결제상태: 결제완료
								<div>결제번호: {{item.payId}}</div>
							</div>		
	                        <div>신청일자: {{item.joinDay}}</div>
							<div>결제금액 : {{price}} </div>
							<div><button @click="fnCancel(item.classNo)">수강취소</button></div>
							<div><button @click="fnPay(item.classNo)">결제</button></div>
							<br>
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
	const userCode = ""; 
	IMP.init("imp52370275");
	
    const app = Vue.createApp({
        data() {
            return {
                userId: '${sessionId}',
				sessionAuth : '${sessionAuth}',
                list: [],
				isCustomer : true,
				className : "",
			    payId : "",
				price : ""
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
						   console.log(data);
	                       self.list = data.onedayInfo;
						   for(var i =0; i<self.list.length; i++){
							self.className = data.onedayInfo[i].className;
							self.price = data.onedayInfo[i].price;
						   }		
	                   }
	               });
				}else{
					self.isCustomer = false;
				}
            },
			fnPay(classNo) {
			    var self = this;
				var payConfirm = confirm("결제하시겠습니까?");
				if(payConfirm){

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
				}else{
					alert("결제를 취소하셨습니다");
				}	 
			},
	
			fnSave(rsp) {
			    var self = this;
			    var nparmap = {price : rsp.paid_amount, payId : rsp.merchant_uid, classNo:self.classNo, userId:self.userId};
			    $.ajax({
			        url: "/myPage/oneday-pay.dox",
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
			fnCancel(classNo){
				var self = this;
				var nparmap = {classNo:classNo, userId:self.userId}
				$.ajax({
					url:"/myPage/oneday-cancel.dox",
					dataType:"json",
					type:"POST",
					data:nparmap,
					success: function(data){
						alert("수강취소 되었습니다.");
						self.fnClass();
					}
				})
			}
        },
        mounted() {
            this.fnClass();
        }
    });
    app.mount('#app');
</script>

