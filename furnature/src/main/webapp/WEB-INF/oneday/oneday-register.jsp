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
			   <input type="text" placeholder="클래스명" v-model="className">
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
			   <input type="text" v-model="price">
			</div>
			<p class="tit">모집시작일</p>
			<div class="ip-box">
			   <input type="date" v-model="startDay">
			</div>
			<p class="tit">모집마감일</p>
			<div class="ip-box">
			   <input type="date" v-model="endDay">
			</div>
			<p class="tit">썸네일업로드</p>
			<div class="ip-box">
			   <input type="file" @change="fnThumbUpload">
			</div>
			<!--<p class="tit">본문파일업로드</p>
			<div class="ip-box">
			   <input type="file" @change="fnFileUpload">
			</div>-->
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
					thumb : "",
					file : ""
	            };
	        },
	        methods: {
				
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
				
				fnThumbUpload(event){
					this.thumb = event.target.files[0];
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
					$.ajax({
						url:"/oneday/oneday-register.dox",
						dataType:"json",	
						type : "POST", 
						data : nparam,
						success : function(data) {
							var classNo = data.classNo;
							 if(self.thumb){
								const formData = new FormData();
								formData.append('thumb', self.thumb);
								formData.append('classNo', self.classNo);
								$.ajax({
									url: '/oneday/oneday-thumb.dox',
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