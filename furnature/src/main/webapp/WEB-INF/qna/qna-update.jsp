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
				내용<textarea v-model="contents"></textarea>					
			</div>
			
		<hr>	
			<div>
				<button @click="fnRegist()">등록</button>
				<button @click="fnCancel()">취소</button>
			</div>
	</div>
</body>
</html> 
<script>
    const app = Vue.createApp({
        data() {
            return {
				sessionId : '${sessionId}',
				qnaNo : '${qnaNo}',
				title : "",
				contents : "",
				list : {}
				
            };
        },
        methods: {
			fnView(){
				var self = this;
				var nparam = {
					qnaNo : self.qnaNo
				}
				$.ajax({
					url:"/qna/qna_update.dox",
					dataType:"json",	
					type : "POST", 
					data : nparam,
					success : function(data) {
						self.list = data.list;
						self.title = self.list.qnaTitle;
						self.contents = self.list.qnaContents;
					}
				});
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
					qnaTitle : self.title,
					qnaContents : self.contents,
					qnaCategory : self.category,
					qnaNo : self.qnaNo
				}
				$.ajax({
					url:"/qna/qna_update_regist.dox",
					dataType:"json",	
					type : "POST", 
					data : nparam,
					success : function(data) {
						alert("수정되었습니다.");
						location.href="mileagelist.do"
						
					}
				});
			 },
			 fnCancel(){
				var confirmed = confirm("수정하던 게시글을 취소 하시겠습니까?");
			      if (confirmed) {
			        history.back();
			      }
			 }
        },
		       
        mounted() {
			var self = this;
			self.fnView();
        }
    });
    app.mount('#app');
</script>