<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
            <p class="blind">원데이클래스</p>
			<div v-if="sessionAuth > 1">
				<button type="button" @click="fnUpdate(detail[0].classNo)">수정</button>
				<button type="button" @click="fnDelete(detail[0].classNo)">삭제</button>
			</div>
			<div class="detail-top">
				<div class="thumb-wrap oneday-detail-thumb-list">
					<div class="thumb-list">
						<div class="thumb-box" v-for="(file, index) in filePath">
							<img :src="file" :alt="detail[0].className + ' 썸네일이미지' + (index+1)">
						</div>
					</div>
					<div class="thumb-arrow">
						<button type="button" class="prev">이전</button>
						<button type="button" class="next">다음</button>
					</div>
				</div>
				<div class="detail-top-info">
					<div class="detail-box">
						<div class="tit">수강 신청</div>
						<div class="info">	
							<template v-if="message1=='모집일자가 지났습니다.' || numberLimit==currentNumber">	
								<div>{{message1}}</div>
								<div>{{message2}}</div>
							</template>
							<template v-else="message1=='' && numberLimit>currentNumber">
								<div>{{message1}}</div>
								<div>{{message2}}</div>
								<div class="ip-box ip-ico-box type2">
									<input type="text" placeholder="성함을 입력해주세요" v-model="name">
									<div class="btn-box type2"><button type="button" @click="fnOnedayJoin">수강신청</button></div>
								</div>
							</template>
						</div>
					</div>
					<div class="detail-box">
						<div class="tit">클래스명</div>
						<div class="info">{{className}}</div>
					</div>
					<div class="detail-box">
						<div class="tit">수업일자</div>
						<div class="info">{{classDate}}</div>
					</div>
					<div class="detail-box">
						<div class="tit">수강료</div>
						<div class="info">{{price}}</div>
					</div>
					<div class="detail-box">
						<div class="tit">모집기간</div>
						<div class="info">{{startDay}} ~ {{endDay}}</div>
					</div>
				</div>
				</div>
				<div class="detail-tab">
					<button type="button" @click="fnTab(1)" :class="bottomBox == '1' ? 'active' : ''">수업 소개</button>
					<button type="button" @click="fnTab(2)" :class="bottomBox == '2' ? 'active' : ''">클래스 장소</button>
				</div>
				<div class="detail-bottom">
					<div class="detail-bottom-box" v-if="bottomBox == '1'">
						<div><pre>{{description}}</pre></div>
					</div>
					<div class="detail-bottom-box" v-if="bottomBox == '2'">
						클래스 장소와 전화번호
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
	//포트원 결제 api 사용
    const app = Vue.createApp({
            data() {
                return {
                   classNo : "${classNo}",
				   className : "",
				   detail : {},
				   filePath : [],
				   userId : "${sessionId}",
				   name : "",
				   count : "",
				   price : "",
				   payId : "",
				   numberLimit : "",
				   currentNumber : "",
				   isAdmin : false,
				   sessionAuth: "${sessionAuth}",
				   today : new Date(),
				   startDay : "",
				   endDay : "",
				   classDate : "",
				   description : "",
				   message1 : "",
				   message2 : "",
				   currentSlide: 0,
				   alreadyIn : false,
				   bottomBox : 1
                };
            },
            methods: {
			
				fnDetail() {
					var self = this;
					var nparmap = {classNo:self.classNo};	
					$.ajax({
					url : "/oneday/oneday-detail.dox",
					dataType : "json",
					type : "POST",
					data : nparmap,
					success : function(data){
						console.log(data);
						self.detail = data.onedayDetail;
						self.classNo = data.onedayDetail[0].classNo;
						self.className = data.onedayDetail[0].className;
						self.startDay = data.onedayDetail[0].startDay;
						self.endDay = data.onedayDetail[0].endDay;
						self.classDate = data.onedayDetail[0].classDate;
						self.price = data.onedayDetail[0].price;
						self.description = data.onedayDetail[0].description;
				
						self.filePath = [];			
						self.detail.forEach(item => {
                           if (item.filePath) {
                               self.filePath.push(item.filePath); 
                           }
                       });
					   self.updateData();	
							
						var endDay = new Date(self.detail[0].endDay);
						var today = new Date()
						if(endDay<today){
							self.message1 = "모집일자가 지났습니다.";
						}else{
							self.message1 = "";
						}
						console.log(self.message1);
						var nparmap = {classNo:self.classNo};
						$.ajax({
							url : "/oneday/oneday-numberLimit.dox",
							dataType : "json",
							type : "POST",
							data : nparmap,
							success : function(data){
								console.log(data);
								self.numberLimit = data.numberLimit.numberLimit;
								self.currentNumber = data.numberLimit.currentNumber;
								if(self.numberLimit==self.currentNumber){
									self.message2 = "모집 인원이 초과되었습니다.";
									return;
								}else{
									self.message2 = "";
								}
							}							
						})
						
					}
					
				})
				},
			   fnOnedayJoin(){
					var self = this;
					if(self.userId==''){
						alert("수강 신청은 로그인 후 가능합니다");
						return;
					}	
					if(self.name==''){
						alert("이름을 입력해주세요");
						return;
					}
					var nparmap = {classNo:self.classNo, userId:self.userId, name:self.name};
					$.ajax({
						url : "/oneday/oneday-check.dox",
						dataType : "json",
						type : "POST",
						data : nparmap,
						success : function(data){
							self.onedayCheck = data.onedayCheck;
							if(self.onedayCheck==1){
								$.ajax({
									url : "/oneday/oneday-join.dox",
									dataType : "json",
									type : "POST",
									data : nparmap,
									success : function(data){
										alert("수강신청 되었습니다.");
									}							
								})				
							}else{
								alert("이미 신청한 클래스입니다.");
							}
						}							
					})	
					
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
					    name: self.detail[0].className,
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
				
				fnUpdate(classNo){
					var self = this;						
					$.pageChange("/oneday/oneday-update.do", {classNo:self.classNo});
				},
				fnDelete(classNo) {
					var self = this;
				    var nparmap = { classNo: classNo };
				    $.ajax({
				        url: "/admin/oneday-delete.dox",
				        dataType: "json",
				        type: "POST",
				        data: nparmap,
				        success: function(data) {
				         	console.log(data);
							$.pageChange("/oneday/oneday.do", {});
				        }
				    });
				},
				updateData() {
					var self = this;
					self.$nextTick(() => {
						$.sliderEvent();
					});
				},
				fnTab(num) {
					var self = this;
					self.bottomBox = num;
				}
			},
            mounted() {
				var self = this;
				self.fnDetail(self.classNo);
            }
        });
        app.mount('#app');
</script>