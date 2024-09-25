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
			<div v-if="list.qnaCategory==1">질문
			</div> 게시판
			<div v-if="list.qnaCategory==2">공지사항
			</div>
			<div>
				제목 : {{list.qnaTitle}}					
			</div>
			<div>작성자 : {{list.userName}} 작성날짜 : {{list.udatetime}}</div>
			<div>
				내용 : {{list.qnaContents}}	
				<img :src="list.qnaFilePath">				
			</div>
		<hr>	
			<div class="ip-box">
                <input type="text" v-model="comments" placeholder="댓글을 입력하세요">
            </div>
			<button @click="fnComments">댓글</button>
		<hr>
			<div v-for="item in comList">
				<div>댓글 : {{item.commentContents}}</div>
				<span>이름 : {{item.userName}}</span>
				<div v-if="item.userId == sessionId">
					<button :style="{ display: item.flg ? 'none' : 'inline' }" @click="fnCommentUp(item)">수정</button>
					<div class="ip-box" v-if="item.flg">
		                <input type="text" v-model="commentsUp">
						<button @click="fnComUpdate(item.commentNo)">등록</button>
						<button @click="fnCancel">취소</button>
		            </div>
					<button	@click="fnComDelete(item.commentNo)">삭제</button>
				</div>
			</div>
			<div>
				세션아이디 : {{sessionId}}
			</div>
		<div v-if="list.userId == sessionId">			
			<button @click="fnUpdate()">수정</button>
			<button @click="fnDelete()">삭제</button>
		</div>
	</div>
</body>
</html> 
<script>
    const app = Vue.createApp({
        data() {
            return {
				list : [],
				qnaNo : '${qnaNo}',
				comments : "",
				commentNo : "",
				sessionId : '${sessionId}',
				commentsUp : "",
				comList : []
            };
        },
        methods: {
			fnView(){
				var self = this;
				var nparam = {qnaNo : self.qnaNo}
				$.ajax({
					url:"/qna/qna_view.dox",
					dataType:"json",	
					type : "POST", 
					data : nparam,
					success : function(data) {
						self.list = data.list;	
						self.comList = data.comments;
						self.comList = data.comments.map(comment => ({
	                       ...comment,flg: false 
	                   }));
					}
				});
			 },
			 fnComments(){
				var self = this;
				var nparam = {
					qnaNo : self.qnaNo,
					comments : self.comments,
					userId : self.sessionId
				}
				$.ajax({
					url:"/qna/qna_comments.dox",
					dataType:"json",	
					type : "POST", 
					data : nparam,
					success : function(data) {
						alert("댓글을 입력하셨습니다.");
						self.fnView();
					}
				});
					
			 },
			 fnCommentUp(item){
				item.flg = !item.flg;
			 },
			 fnComUpdate(commentNo){
				var self = this;
				self.comUpdateFlg = true;
				var nparam = {
					commentNo : commentNo,
					commentContents : self.commentsUp					
				}
				$.ajax({
					url:"/qna/commentUpdate.dox",
					dataType:"json",	
					type : "POST", 
					data : nparam,
					success : function(data) {
						alert("댓글을 수정하였습니다.");
						self.fnView();
					}
				});
			 },
			 fnComDelete(commentNo){
				var self = this;
				var nparam = {
					commentNo : commentNo,
					userId : self.sessionId
				}
				$.ajax({
					url:"/qna/commentDelete.dox",
					dataType:"json",	
					type : "POST", 
					data : nparam,
					success : function(data) {
						alert("댓글을 삭제하였습니다.");
						self.fnView();
					}
				});
			 },
			 fnUpdate(){
				var self = this;
				$.pageChange("/qnaupdate.do",{qnaNo : self.qnaNo});
			 },
			 fnDelete(){
				var self = this
				alert(self.qnaNo);
			 },
			 fnCancel(){
				var self = this;
				self.fnView();
			 }
			
        },
		       
        mounted() {
			var self = this;
			self.fnView();
        }
    });
    app.mount('#app');
</script>