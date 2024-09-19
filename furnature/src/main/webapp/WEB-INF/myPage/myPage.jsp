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
				<div class="myPage myPage-info">
					<div class="ip-list">
					    <div class="tit-box">
					        <p class="tit">아이디</p>
					    </div>
					    <div class="bot-box">
					        <p>{{info.userId}}</p>
					    </div>
					</div>
					<div class="ip-list">
					    <div class="tit-box">
					        <p class="tit">이름</p>
					    </div>
					    <div class="bot-box">
					        <p>{{info.userName}}</p>
					    </div>
					</div>
					<div class="ip-list">
					    <div class="tit-box">
					        <p class="tit">주소</p>
					    </div>
					    <div class="bot-box">
					        <p>{{info.userAddr}}</p>
					    </div>
					</div>
					<div class="ip-list">
					    <div class="tit-box">
					        <p class="tit">핸드폰 번호</p>
					    </div>
					    <div class="bot-box">
					        <p>{{info.userPhone}}</p>
					    </div>
					</div>
					<div class="ip-list">
					    <div class="tit-box">
					        <p class="tit">이메일</p>
					    </div>
					    <div class="bot-box">
					        <p>{{info.userEmail}}</p>
					    </div>
					</div>
					<div class="ip-list">
					    <div class="tit-box">
					        <p class="tit">생년월일</p>
					    </div>
					    <div class="bot-box">
					        <p>{{info.userBirth}}</p>
					    </div>
					</div>
					<div class="ip-list">
					    <div class="tit-box">
					        <p class="tit">참여여부</p>
					    </div>
					    <div class="bot-box">
					        <p>
								<template v-if="info.eventRoul == 'N'">참여완료</template>
								<template v-else>참여가능</template>
							</p>
					    </div>
					</div>
					<div class="ip-list">
					    <div class="tit-box">
					        <p class="tit">참여여부</p>
					    </div>
					    <div class="bot-box">
					        <p>
								<template v-if="info.eventCheck == 'N'">참여완료</template>
								<template v-else>참여가능</template>
							</p>
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
				sessionId : '${sessionId}',
				info : {}
            };
        },
        methods: {
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
					}
				});
            },
        },
        mounted() {
            var self = this;
			self.fnGetInfo();
        }
    });
    app.mount('#app');
</script>