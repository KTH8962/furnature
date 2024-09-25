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
            <p class="blind">마이페이지 - 내정보</p>
            <div class="myPage-wrap">
                <div class="myPage-snb-wrap">
                    <jsp:include page="/layout/myPageSnb.jsp"></jsp:include>
                </div>
                <div class="myPage myPage-oneday" style="width:100%">
					
                    <div v-if="isCustomer">신청내역
                    <br>
                    <div v-for="item in list" :key="item.payId">
                        <div>클래스명: {{item.className}}</div>
                        <div>결제ID: {{item.payId}}</div>
                        <div>신청일자: {{item.payDay}}</div>
                        <div><button @click="fnCancel(item.classNo, item.payId)">수강취소</button></div>
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
    const app = Vue.createApp({
        data() {
            return {
                sessionId: '${sessionId}',
				sessionAuth : '${sessionAuth}',
                list: [],
				isCustomer : true,
				onedayClass : [],
				message1 : ""
            };
        },
        methods: {
            fnClass() {
                var self = this;
                var nparmap = { sessionId: self.sessionId };
                $.ajax({
                    url: "/myPage/oneday-info.dox",
                    dataType: "json",
                    type: "POST",
                    data: nparmap,
                    success: function(data) {
                        self.list = data.onedayInfo;
						if(self.sessionAuth=='2'){
							self.isCustomer = false;
						}
                    }
                });
            },
        

			fnGetList(){
				var self = this;
				var nparmap = {};
				$.ajax({
                   url: "/oneday/oneday-list.dox",
                   dataType: "json",
                   type: "POST",
                   data: nparmap,
                   success: function(data) {
                  	console.log(data);
                   }
               });
			}
        },
        mounted() {
            this.fnClass();
        }
    });
    app.mount('#app');
</script>

