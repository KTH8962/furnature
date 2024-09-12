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
	                    <p class="tit">아이디</p>
	                </div>
	                <div class="bot-box">
	                    <div class="ip-box">
	                        <input type="text" placeholder="가입하신 이름을 입력해주세요" v-model="id">
	                    </div>
	                </div>
	            </div>
				<div class="ip-list">
	                <div class="tit-box">
	                    <p class="tit">이름</p>
	                </div>
	                <div class="bot-box">
	                    <div class="ip-box">
	                        <input type="text" placeholder="가입하신 이름을 입력해주세요" v-model="name">
	                    </div>
	                </div>
	            </div>
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
				<button @click="fnFind" v-if="findInfo">비밀번호찾기</button>
				<div v-if="findShow">{{pwd}}</div>
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
				id : "user2",
				name : "김철수",
				phone : "01089622170",
				msgText : "",
				msgSubmit : "",
				msgTime : true,
				timer : "",
				findInfo : true,
				findShow : false,
				pwd : ""
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
				var self = this;
				if(self.msgTime) {					
					if(self.msgSubmit == this.msgText){
						alert("인증되었습니다.");
						clearInterval(self.timer);
						self.findInfo = true;
					} else {
						alert("인증 실패하였습니다.");
						self.findInfo = false;
					}
				} else {
					alert("인증시간이 지났습니다.");
					self.findInfo = false;
				}
            },
			fnInteval(){
				var self = this;
				var time = document.querySelector(".time");
				var timeSet = 65;
				self.timer = setInterval(() => {
					var min = Math.floor(timeSet / 60);
					var sec = timeSet % 60;
					if(timeSet == 0) {
						clearInterval(self.timer);
						time.innerHTML  = `0 : 00`;
						self.msgTime = false;
						return;
					}
					time.innerHTML  = `\${min} : \${sec.toString().padStart(2,0)}`;
					timeSet -= 1;
				},1000);
			},
			fnFind(){
				var self = this;
				var nparmap = {id: self.id, name: self.name, phone: self.phone};
				$.ajax({
					url:"/user/findInfo.dox",
					dataType:"json",	
					type : "POST", 
					data : nparmap,
					success : function(data) {
						console.log(data);
						if(data.result == "success"){
							self.findShow = true;
							self.pwd = data.findInfo;
						} else {
							self.findShow = false;
							alert(data.message);
						}
					}
				});
			}
        },
        mounted() {
            var self = this;
        }
    });
    app.mount('#app');
</script>