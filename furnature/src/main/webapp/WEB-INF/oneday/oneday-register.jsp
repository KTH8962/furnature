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
	        <p class="tit">클래스번호</p>
			<div class="ip-box">
			   <p>{{classNo}}</p>
			</div>
			<p class="tit">클래스명</p>
			<div class="ip-box">
			   <input type="text" v-model="className" @input="validateClassName">
			</div>
			<p class="tit">수업일자</p>
			<div class="ip-box">
			   <input type="date" v-model="classDate">
			</div>
			<p class="tit">수강인원</p>
			<div class="ip-box">
			   <input type="number" v-model="headCount">
			</div>
			<p class="tit">수강료</p>
			<div class="ip-box">
			   <input type="text" v-model="price" @input="validatePrice">
			</div>
			<p class="tit">모집시작일</p>
			<div class="ip-box">
			   <input type="date" v-model="startDay">
			</div>
			<p class="tit">모집마감일</p>
			<div class="ip-box">
			   <input type="date" v-model="endDay">
			</div>
			<p class="tit">파일업로드</p>
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
	                headCount: "",
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
				fnClassNo(){
					var self = this;
					var nparam = {}
					$.ajax({
						url:"/oneday/oneday-classNo.dox",
						dataType:"json",	
						type : "POST", 
						data : nparam,
						success : function(data) { 
							console.log(data);
							self.classNo = data.classNo;
						}
					});	
				},
				
				fnFileUpload(event){
					this.file = event.target.files; 
				},
				
				fnSave(){
					var self = this;
					var nparam = {
						classNo : self.classNo,
						className : self.className, 
						classDate : self.classDate,
						headCount : self.headCount,
						price : self.price,
						startDay : self.startDay,
						endDay : self.endDay				
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
					
					if(!self.classNo || !self.className || !self.classDate || !self.headCount || !self.price || !self.startDay || !self.endDay) {
					        alert("빈칸을 채워주세요.");
					        return;
					    }
					
					$.ajax({
						url:"/oneday/oneday-register.dox",
						dataType:"json",	
						type : "POST", 
						data : nparam,
						success : function(data) {
							var classNo = data.classNo;	 
							 if(self.file.length!==0){
								const formData = new FormData();
								for(var i=0; i<self.file.length; i++){
									formData.append('file', self.file[i]);
								} 	formData.append('classNo', self.classNo);
								$.ajax({
									url: '/oneday/oneday-file.dox',
									type : 'POST',
									data : formData,
									processData : false,
									contentType : false,
									success: function(){
										console.log('업로드 성공!');
										console.log(self.classNo);
										location.href="/oneday/oneday.do"
									}
								})
							 }
						}
					});
				}
			 	},
			mounted() {
				var self = this;
				self.fnClassNo();
            }
        });
	    app.mount('#app');
	</script>