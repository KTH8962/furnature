<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<jsp:include page="/layout/headlink.jsp"></jsp:include>
</head>
<body>
	<div id="app">
		<jsp:include page="/layout/header.jsp"></jsp:include>
		<div id="container">            
            <p class="blind">기본페이지</p>
			<div class="login-wrap">
				<div class="ip-box">
			        <input type="text" placeholder="텍스트입력" v-model="userId">
			    </div>
				<div class="ip-box">
			        <input type="text" placeholder="텍스트입력" v-model="pwd">
			    </div>
				<button @click="login">로그인</button>
			</div>
		</div>
		<jsp:include page="/layout/footer.jsp"></jsp:include>
	</div>
</body>
</html>
<script>
    const app = Vue.createApp({
        data() {
            return {
				userId : "",
				pwd : ""
            };
        },
        methods: {
            login(){
				var self = this;
				var nparmap = {userId: self.userId, pwd: self.pwd};
				$.ajax({
					url:"/user/login.dox",
					dataType:"json",	
					type : "POST", 
					data : nparmap,
					success : function(data) { 
						console.log(data);
						self.empList = data.empList;
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
​