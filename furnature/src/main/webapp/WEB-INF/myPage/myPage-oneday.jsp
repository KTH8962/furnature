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
		<div>신청내역</div>
		<br>
		<div v-for="item in list">
			<div>클래스명: {{item.className}}</div>
			<div>결제ID: {{item.payId}}</div>
			<div>신청일자: {{item.payDay}}</div>
			<div><button @click="fnCancel(item.classNo)">수강취소</button></div>
			<br>
		</div>	
	</div>
	<jsp:include page="/layout/footer.jsp"></jsp:include>
</body>
</html>
<script>
    const app = Vue.createApp({
        data() {
            return {
				sessionId : '${sessionId}',
				list : []
            };
        },
		methods: {
		    fnClass(sessionId) {
		        var self = this;
		        var nparmap = {sessionId: self.sessionId};
		        console.log(self.sessionId);
		        $.ajax({
		            url: "/myPage/oneday-info.dox",
		            dataType: "json",
		            type: "POST",
		            data: nparmap,
		            success: function(data) {
		                self.list = data.onedayInfo;
		                console.log(data);
		            }
		        });
		    },
			fnCancel(classNo, payId) {
			    var self = this;
			    var cancelConfirm = confirm("정말 수강을 취소하시겠습니까?");
			    if (!cancelConfirm) return;

			    // 1. Iamport 결제 취소 요청
			    $.ajax({
			        url: 'https://api.iamport.kr/users/getToken',
			        method: 'post',
			        headers: {
			            'Content-Type': 'application/json'
			        },
			        data: JSON.stringify({
			            imp_key: 'imp52370275',
			            imp_secret: 'ebob8MJvxwHrq643UfpkB9mWHVXr2BKqrom9lBSZidoHSWHiVTkHmAnrIls8yoFWgZF3qhnf5ErRorWV'
			        }),
			        success: function (response) {
			            var api_token = response.response.token;

			            $.ajax({
			                url: "https://api.iamport.kr/payments/cancel",
			                type: "POST",
			                headers: {
			                    "Authorization": `Bearer ${api_token}`
			                },
			                data: {
			                    merchant_uid: payId
			                },
			                success: function (response) {
			                    if (response.code === 0) {  // 결제 취소 성공
			                        alert("결제가 취소되었습니다.");

			                        // 2. 서버에서 데이터 삭제
			                        var nparmap = { classNo: classNo, sessionId: self.sessionId };
			                        $.ajax({
			                            url: "/myPage/oneday-cancel.dox",
			                            dataType: "json",
			                            type: "POST",
			                            data: nparmap,
			                            success: function (data) {
			                                if (data.result === "success") {
			                                    alert("수강 신청이 취소되었습니다.");
			                                    self.fnClass(); // 목록 갱신
			                                } else {
			                                    alert("수강 신청 취소에 실패했습니다.");
			                                }
			                            }
			                        });
			                    } else {
			                        alert("결제 취소에 실패했습니다. 관리자에게 문의하세요.");
			                    }
			                },
			                error: function () {
			                    alert("결제 취소 중 오류가 발생했습니다.");
			                }
			            });
			        }
			    });
				}
			},
        mounted() {
			var self = this;
			self.fnClass();
        }
    });
    app.mount('#app');
</script>