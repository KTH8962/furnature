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
		<div v-if="isEditing">
			제목 : <input type="text" v-model="info.boardTitle"><br>
			내용 : <textarea v-model="info.boardContents"></textarea><br>
			<button @click="fnUpdate(info.boardNo)">수정 완료</button>
			<button @click="isEditing = false">취소</button>
		</div>
		<div v-else>
			제목 : {{info.boardTitle}}<br>
			내용 : <div v-html="info.boardContents"></div>
			작성자 : <span>{{info.userId}}</span>
			<div v-if="sessionId == info.userId || sessionAuth == '2'">
				<button @click="isEditing = true">수정</button>
				<button @click="fnDelete(info.boardNo)">삭제</button>
			</div>
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
				isEditing: false, // 수정 모드 여부
            };
        },
        methods: {
			// 게시글 정보 가져오기
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
			// 게시글 삭제
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
			// 게시글 수정
			fnUpdate(num){
				var self = this;
				var nparmap = {
					boardNo: num,
					boardTitle: self.info.boardTitle,
					boardContents: self.info.boardContents
				};
				$.ajax({
					url:"view-update.dox",
					dataType:"json",
					type : "POST", 
					data : nparmap,
					success : function(data) { 
						alert(data.message);
						self.isEditing = false;
						self.fnGetInfo(); // 수정 후 최신 정보 가져오기
					}
				});
			}
        },
        mounted() {
			var self = this;
			self.fnGetInfo();
        }
    });
    app.mount('#app');
</script>
