<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<jsp:include page="/layout/headlink.jsp"></jsp:include>
	<style>
		img{
			width:600px;
		}
		input[type="file"] {
			appearance: initial;
			width: auto; height:auto; position:static;
		}
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
	            fnSave() {
	                var formData = new FormData();

	                for (var i = 0; i < this.files.length; i++) {
	                    formData.append('files', this.files[i]);
	                }

	                // 데이터 추가
	                formData.append('className', this.className);
	                formData.append('classDate', this.classDate);
	                formData.append('headCount', this.headCount);
	                formData.append('price', this.price);
	                formData.append('startDay', this.startDay);
	                formData.append('endDay', this.endDay);

	                $.ajax({
	                    url: '/oneday/oneday-file.dox', // 서버의 파일 업로드와 데이터 저장을 위한 URL
	                    type: 'POST',
	                    data: formData,
	                    contentType: false,
	                    processData: false,
	                    success: function(response) {
	                        console.log('성공:', response);
	                    },
	                    error: function(err) {
	                        console.error('실패:', err);
	                    }
	                });
	            }
	        }
	    });
	    app.mount('#app');
	</script>