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
            <p class="blind">기본페이지</p>
			<div class="login-wrap">
				<div class="ip-box">
			        <input type="text" placeholder="텍스트입력" v-model="id">
			    </div>
				<div class="ip-box">
			        <input type="password" placeholder="비밀번호입력" v-model="pwd" @keyup.enter="login">
			    </div>
				<button @click="login">로그인</button>
			</div>
			<a href="join.do">회원가입</a>
			<a href="idFind.do">아이디 찾기</a>
			<a href="pwdFind.do">비밀번호 찾기</a>
		</div>
	</div>
	<jsp:include page="/layout/footer.jsp"></jsp:include>
</body>
</html>
<script>
    const app = Vue.createApp({
        data() {
            return {
				id : "user1",
				pwd : "user1",
            };
        },
        methods: {
            login(){
				var self = this;
				var nparmap = {id: self.id, pwd: self.pwd};
				$.ajax({
					url:"/user/login.dox",
					dataType:"json",	
					type : "POST", 
					data : nparmap,
					success : function(data) {
						console.log(data.result)
						if(data.result == "success") {
							$.pageChange("main.do",{});
						} else {
							alert(data.message);
						}
					}
				});
            },
        },
        mounted() {
            var self = this;
        }
    });
    app.mount('#app');
</script>