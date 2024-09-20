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
                    <nav class="myPage-snb">
                        <ul>
                            <li><a href="/myPage/myPage.do">마이페이지</a></li>
                            <li><a href="javascript:void(0);">추가페이지들</a></li>
                            <li><a href="/myPage/oneday.do">원데이클래스</a></li>
                        </ul>
                    </nav>
                </div>
                <div class="myPage myPage-oneday" style="width:100%">
                    <div>신청내역</div>
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
    <jsp:include page="/layout/footer.jsp"></jsp:include>
</body>
</html>
<script>
    const app = Vue.createApp({
        data() {
            return {
                sessionId: '${sessionId}',
                list: []
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
                    }
                });
            },
            fnCancel(classNo, payId) {
                var self = this;
                var cancelConfirm = confirm("정말 수강을 취소하시겠습니까?");
                if (!cancelConfirm) return;

                // 1. IAMPORT 결제 취소 요청
                this.getAccessToken().then(apiToken => {
                    $.ajax({
                        url: "/iamport/cancelPayment",
                        type: "POST",
                        headers: {
                            "Authorization": `Bearer ${apiToken}`
                        },
                        contentType: "application/json",
                        data: JSON.stringify({
                            impUid: payId,  // Pay ID 전달
                            reason: "User requested cancellation"
                        }),
                        success: function(cancelResponse) {
                            if (cancelResponse.code === 0) {
                                alert("결제가 취소되었습니다.");
                                // 서버에서 데이터 삭제
                                var nparmap = { classNo: classNo, sessionId: self.sessionId };
                                $.ajax({
                                    url: "/myPage/oneday-cancel.dox",
                                    dataType: "json",
                                    type: "POST",
                                    data: nparmap,
                                    success: function(data) {
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
                        error: function() {
                            alert("결제 취소 중 오류가 발생했습니다.");
                        }
                    });
                });
            },
            getAccessToken() {
                return new Promise((resolve, reject) => {
                    $.ajax({
                        url: '/iamport/getToken', // 액세스 토큰 요청 URL
                        method: 'GET',
                        success: function(tokenResponse) {
                            resolve(tokenResponse.access_token);
                        },
                        error: function() {
                            reject("액세스 토큰을 가져오는 데 실패했습니다.");
                        }
                    });
                });
            }
        },
        mounted() {
            this.fnClass();
        }
    });
    app.mount('#app');
</script>

