<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<jsp:include page="/layout/headlink.jsp"></jsp:include>
	<style>
	</style>	
</head>
<body>
	<jsp:include page="/layout/header.jsp"></jsp:include>
	<div id="app">	
		
		<div class="ip-list">
		    <div class="tit-box">
		        <p class="tit">클래스명</p>
		    </div>
		    <div class="bot-box">
		        <div class="ip-box">
		            <input type="text" v-model="className" @input="validateClassName">
		        </div>
		    </div>
		</div>
		
		<div class="ip-list">
		    <div class="tit-box">
		        <p class="tit">수업일자</p>
		    </div>
		    <div class="bot-box">
		        <div class="ip-box">
		            <input type="datetime-local" v-model="classDate">
		        </div>
		    </div>
		</div>
		
		<div class="ip-list">
		    <div class="tit-box">
		        <p class="tit">수강인원</p>
		    </div>
		    <div class="bot-box">
		        <div class="ip-box">
		            <input type="number" v-model="numberLimit">
		        </div>
		    </div>
		</div>
		
		<div class="ip-list">
		    <div class="tit-box">
		        <p class="tit">수강료</p>
		    </div>
		    <div class="bot-box">
		        <div class="ip-box">
		           <input type="text" v-model="price" @input="validatePrice">
		        </div>
		    </div>
		</div>
		
		<div class="ip-list">
		    <div class="tit-box">
		        <p class="tit">모집시작일</p>
		    </div>
		    <div class="bot-box">
		        <div class="ip-box">
		           <input type="datetime-local" v-model="startDay">
		        </div>
		    </div>
		</div>
		
		<div class="ip-list">
		    <div class="tit-box">
		        <p class="tit">모집마감일</p>
		    </div>
		    <div class="bot-box">
		        <div class="ip-box">
		           <input type="datetime-local" v-model="endDay">
		        </div>
		    </div>
		</div>
		
		<div class="ip-list">
		    <div class="tit-box">
		        <p class="tit">파일업로드</p>
		    </div>
			<div class="ip-box">
			   <input type="file" multiple @change="fnFileUpload">
			   <span v-if="file.length > 0">파일{{file.length}}개</span>
			</div>
			<div><button @click="fnSave">저장</button></div>			
		</div>
		
	</div>
	<jsp:include page="/layout/footer.jsp"></jsp:include>
</body>
</html>
<script>
	const app = Vue.createApp({
	        data() {
	            return {
					classNo : "",
	                className: "",
	                classDate: "",
	                numberLimit : "",
	                price: "",
	                startDay: "",
	                endDay: "",
					file : []
	            };
	        },
	        methods: {
				validateClassName() {
				      this.className = this.className.replace(/[^A-Za-z가-힣 ]+/g, '');
				    },
				validatePrice(){
					this.price = this.price.replace(/[^0-9]/, '');
					
				},
				
				fnFileUpload(event){
					this.file = event.target.files; 
				},
				
				fnSave(){
					var self = this;
					var nparam = {
						className : self.className, 
						classDate : self.classDate.replace('T', ' '),
						numberLimit : self.numberLimit,
						price : self.price,
						startDay : self.startDay.replace('T', ' '),
						endDay : self.endDay.replace('T', ' ')		
					};
					var startDay = new Date(self.startDay);
					var endDay = new Date(self.endDay);
					var classDate = new Date(self.classDate);
					if(startDay>endDay){
						alert("모집시작일이 모집마감일보다 뒤입니다. 올바른 날짜를 입력해주세요.");
						return;
					}
					if(classDate<startDay){
						alert("모집시작일이 수업일보다 뒤입니다. 올바른 날짜를 입력해주세요.");
						return;
					}
					
					if(!self.className || !self.classDate || !self.numberLimit || !self.price || !self.startDay || !self.endDay) {
					        alert("빈칸을 채워주세요.");
					        return;
					}
					console.log(nparam);

					$.ajax({
						url:"/oneday/oneday-register.dox",
						dataType:"json",	
						type : "POST", 
						data : nparam,
						success : function(data) {
							console.log(data);
							var classNo = data.classNo;	 
							 if(self.file.length!==0){
								const formData = new FormData();
								for(var i=0; i<self.file.length; i++){
									formData.append('file', self.file[i]);
								} 	formData.append('classNo', classNo);
								
								$.ajax({
									url: '/oneday/oneday-file.dox',
									type : 'POST',
									data : formData,
									processData : false,
									contentType : false,
									success: function(){
										console.log('업로드 성공!');
										$.pageChange("/oneday/oneday.do", {});

									}
								})
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