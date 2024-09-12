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
		
		<p class="tit">클래스명</p>
        <div class="ip-box">
           <input type="text" placeholder="클래스명" v-model="className">
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
		<p class="tit">파일업로드</p>
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
	                className: "",
	                classDate: "",
	                headCount: "",
	                price: "",
	                startDay: "",
	                endDay: "",
	                files: []
	            };
	        },
	        methods: {
				fnFileUpload(event) {
					this.files = event.target.files;
				},
				fnSave (){
					var self = this;
					var nparam = {
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
							console.log(classNo);
							if (self.file) {
								console.log(self.file);
							  const formData = new FormData();
							  formData.append('file1', self.file);
							  formData.append('boardNo', boardNo);
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