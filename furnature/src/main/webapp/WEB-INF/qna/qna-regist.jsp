<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<jsp:include page="/layout/menu.jsp"></jsp:include>
	<title>첫번째 페이지</title>
</head>
<style>
</style>
<body>
	<div id="app">
			<select name="category" v-model="category">
			  <option value="" selected>::전체::</option>
			  <option value="1">Q&A</option>
			  <option value="2">공지사항</option>
			</select>
			<div>	
				제목<input type="text" v-model="title">					
			</div>
			<div>
				내용<textarea v-model="contents">	</textarea>				
			</div>
			<div>
				첨부<input type="file" accept=".gif,.jpg,.png" @change="fnAttach">
			</div>
		<hr>	
			<div>
				<button @click="fnRegist()">등록</button>
			</div>
	</div>
</body>
</html> 
<script>
    const app = Vue.createApp({
        data() {
            return {
				sessionId : '${sessionId}',
				category : "",
				title : "",
				contents : "",
				file : null
            };
        },
        methods: {
			fnAttach(event){
	 			this.file = event.target.files[0];
			},
			fnRegist(){
				var self = this;
				if(self.title == ""){
					alert("제목을 입력해주세요");
					return;
				}else if(self.contents == ""){
					alert("내용을 입력해주세요");
					return;
				}else if(self.category == ""){
					alert("카테고리를 선택해주세요");
					return;
				}
				var nparam = {
					userId : self.sessionId,
					qnaTitle : self.title,
					qnaContents : self.contents,
					qnaCategory : self.category
				}
				$.ajax({
					url:"/qna/qna_regist.dox",
					dataType:"json",	
					type : "POST", 
					data : nparam,
					success : function(data) {
						var qnaNo = data.qnaNo
						if(self.file){
						  const formData = new FormData();
						  formData.append('file1', self.file);
						  formData.append('qnaNo', qnaNo);
						  $.ajax({
							url: '/qna-file.dox',
							type: 'POST',
							data: formData,
							processData: false,  
							contentType: false,
							success: function() {
							  alert("게시글을 등록하였습니다.");
							  location.href="/qnalist.do";
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