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
                    <input type="text" placeholder="클래스명" v-model="className">
                </div>
            </div>
        </div>
		<p class="tit">수업일자</p>
		<div class="ip-box">
		   <input type="date" placeholder="수업일자" v-model="classDate">
		</div>
		<p class="tit">수강인원</p>
		<div class="ip-box">
		   <input type="number" placeholder="수강인원" v-model="headCount">
		</div>
		<p class="tit">수강료</p>
		<div class="ip-box">
		   <input type="text" placeholder="수강료" v-model="price">
		</div>
		<p class="tit">모집시작일</p>
		<div class="ip-box">
		   <input type="date" placeholder="모집시작일" v-model="startDay">
		</div>
		<p class="tit">모집마감일</p>
		<div class="ip-box">
		   <input type="date" placeholder="모집마감일" v-model="endDay">
		</div>
		<p class="tit">썸네일업로드</p>
		<div class="ip-box">
		   <input type="file" @change="fnThumbUpload">
		</div>
		<p class="tit">본문파일업로드</p>
		<div class="ip-box">
		   <input type="file" multiple @change="fnFileUpload">
		</div>
		<div><button @click="fnSave">저장</button></div>
	</div>
	<jsp:include page="/layout/footer.jsp"></jsp:include>
</body>
</html>
<script>
	const app = Vue.createApp({
	        data() {
	            return {
					classNo : '${classNo}',
	                className: "",
	                classDate: "",
	                headCount: "",
	                price: "",
	                startDay: "",
	                endDay: "",
	                files: [],
					thumb : {}
	            };
	        },
	        methods: {
				fnFileUpload(event) {
					this.files = Array.from(event.target.files);
				},
				fnThumbUpload(event){
					this.file = event.target.file;
				}
				
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
							console.log(self.classNo);
							if (self.files) {
							  const formData = new FormData();
							  self.files.forEach((file,index)=>{
								formData.append('file'+index, files)
							  })
							  formData.append('classNo', self.classNo);
							  $.ajax({
								url: '/oneday/oneday-file.dox',
								type: 'POST',
								data: formData,
								processData: false,  
								contentType: false,  
								success: function() {
								  console.log('업로드 성공!');
								},
								error: function(jqXHR, textStatus, errorThrown) {
								  console.error('업로드 실패!', textStatus, errorThrown);
								}
							  });
							}
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