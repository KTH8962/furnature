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
			<h3>Q&A</h3>
			<div class="ip-box">	
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
	</div>
</body>
</html> 
<script>
    const app = Vue.createApp({
        data() {
            return {
				sessionId : '${sessionId}',
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
				}
				var nparam = {
					userId : self.sessionId,
					qnaTitle : self.title,
					qnaContents : self.contents,
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
							  location.href="/qna/qnalist.do";
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