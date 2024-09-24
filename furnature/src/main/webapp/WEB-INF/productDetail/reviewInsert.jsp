<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/layout/headlink.jsp"></jsp:include>
</head>
<body>
	<div id="app">
		<div id="container">            
			<!--<div>제목<input type="text" placeholder="제목" v-model="reviewTitle"></div>-->
			<select>
				<option>아주좋아요★★★★★</option>
				<option>맘에들어요★★★★☆</option>
				<option>좋아요★★★☆☆</option>
				<option>그저그래요★★☆☆☆</option>
				<option>별로에요★☆☆☆☆</option>
			</select>
			<div>내용<textarea v-model="reviewContents"></textarea></div>
			<div>사진첨부<input type="file" accept=".gif,.jpg,.png" @change="fnReviewAttach"></div>
			<button @click="fnReviewInsert">리뷰등록</button>
		</div>
	</div>
</body>
</html>
<script>
	const app = Vue.createApp({
	       data() {
	           return {
				reviewTitle : "",
				reviewContents : "",
				reviewRating : "",
				productNo : '${productNo}',
				sessionId : '${sessionId}',
				file : null,
	           };
	       },
	       methods: {
			fnReviewAttach(event){
	 			this.file = event.target.files[0];
			},
	           fnReviewInsert(){
				var self = this;
				var nparmap = {
					reviewTitle : self.reviewTitle,
					reviewContents : self.reviewContents,
					userId : self.sessionId,
					productNo : self.productNo
				};
				$.ajax({
					url:"/productDetail/reviewInsert.dox",
					dataType:"json",	
					type : "POST", 
					data : nparmap,
					success : function(data) {
						console.log(data);
						console.log(data.reviewNo);
						var reviewNo = data.reviewNo;
						if(self.file){
							console.log(data.reviewNo);
						  const formData = new FormData();
						  formData.append('file1', self.file);
						  formData.append('reviewNo', reviewNo);
						  $.ajax({
							url: '/productDetail/reviewImgFile.dox',
							type: 'POST',
							data: formData,
							processData: false,  
							contentType: false,  
							success: function() {
							  alert("리뷰가 등록되었습니다.");
							  window.opener.location.reload();
							  window.close(); 
							},
							error: function(jqXHR, textStatus, errorThrown) {
							  console.error('업로드 실패!', textStatus, errorThrown);
							}
						  });
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