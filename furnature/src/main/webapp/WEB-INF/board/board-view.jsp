<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<jsp:include page="/layout/headlink.jsp"></jsp:include>
</head>
<style>
</style>
<body>
	<jsp:include page="/layout/header.jsp"></jsp:include>
	<div id="app">
		제목 : {{info.boardTitle}}<br>
		내용 : <div v-html="info.boardContents"></div>
		작성자 : <span>{{info.userId}}</span>
		<div v-if="sessionId == info.userId || sessionAuth == '2'">
			<button @click="fnRemove(info.boardNo)">수정</button>
			<button @click="fnDelete(info.boardNo)">삭제</button>
		</div>
	</div>
	<jsp:include page="/layout/footer.jsp"></jsp:include>
</body>
</html>
<script>
    const app = Vue.createApp({
        data() {
            return {
				boardNo : '${boardNo}',
				info : {},
				sessionId : '${sessionId}',
				sessionAuth : '${sessionAuth}',
            };
        },
        methods: {
			fnGetInfo(){
				var self = this;
				var nparmap = {boardNo : self.boardNo};
				$.ajax({
					url:"board-view.dox",
					dataType:"json",	
					type : "POST", 
					data : nparmap,
					success : function(data) { 
						console.log(data);
						self.info = data.info;
					}
				});
            },
			fnDelete(num){
				var self = this;
				var nparmap = {boardNo : num};
				$.ajax({
					url:"view-delete.dox",
					dataType:"json",
					type : "POST", 
					data : nparmap,
					success : function(data) { 
						alert(data.message);
						$.pageChange("board.do",{});
					}
				});
			},
        },
        mounted() {
			var self = this;
			self.fnGetInfo();
        }
    });
    app.mount('#app');
</script>