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
				<div class="ip-list">
	                <div class="tit-box">
	                    <p class="tit">핸드폰 번호</p>
	                </div>
	                <div class="bot-box">
	                    <div class="ip-box">
	                        <input type="text" placeholder="가입하신 핸드폰 번호를 입력해주세요" v-model="phone">
	                    </div>
	                </div>
	            </div>
				<button type="button" @click="fnMsg">문자인증</button></div>
				<div class="none">
					<input type="text" placeholder="인증번호를 입력해주세요." v-model="msgSubmit">
					<button type="button" @click="fnSubmit">인증하기</button>
					<span class="time"></span>
				</div>
				
				<button @click="login">아이디찾기</button>
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
				phone : "01089622170",
				msgText : "",
				msgSubmit : "",
				msgTime : true,
            };
        },
        methods: {
            fnMsg(){
				var self = this;
				var nparmap = {phone: self.phone};
				$.ajax({
					url:"/user/msg.dox",
					dataType:"json",	
					type : "POST", 
					data : nparmap,
					success : function(data) {
						console.log(data);
						self.msgText = data.msg;
						self.msgTime = true;
						document.querySelector('.none').classList.remove('none');
						self.fnInteval();
					}
				});
            },
			fnSubmit(){
				if(this.msgTime) {					
					if(this.msgSubmit == this.msgText){
						alert("인증되었습니다.");
					} else {
						alert("인증 실패하였습니다.");
					}
				} else {
					alert("인증시간이 지났습니다.");
				}
            },
			fnInteval(){
				var time = document.querySelector(".time");
				var timer;
				var timeSet = 65;
				timer = setInterval(() => {
					var min = Math.floor(timeSet / 60);
					var sec = timeSet % 60;
					if(timeSet == 0) {
						clearInterval(timer);
						time.innerHTML  = `0 : 00`;
						this.msgTime = false;
						return;
					}
					time.innerHTML  = `\${min} : \${sec.toString().padStart(2,0)}`;
					timeSet -= 1;
				},1000);
			}
        },
        mounted() {
            var self = this;
        }
    });
    app.mount('#app');
</script>