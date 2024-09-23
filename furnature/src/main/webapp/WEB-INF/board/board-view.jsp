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
		    제목 : <textarea v-model="info.boardTitle"></textarea><br>
		    내용 : <textarea v-model="info.boardContents"></textarea><br>
		    <button @click="fnUpdate(info.boardNo)">수정 완료</button>
		    <button @click="isEditing = false">취소</button>
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
		<div v-else>
		    제목 : {{info.boardTitle}}<br>
		    내용 : <div v-html="info.boardContents"></div>
		    작성자 : <span>{{info.userId}}</span>
		    <div v-if="sessionId == info.userId || sessionAuth == '2'">
		        <button @click="isEditing = true">수정</button>
		        <button @click="fnDelete(info.boardNo)">삭제</button>
		    </div>
		</div>

		<div v-if="isComment">
		    내용 : <textarea v-model="commentContent"></textarea><br>
		    <button @click="fnAddComment">댓글쓰기</button>
		    <button @click="isComment = false">취소</button>
		</div>
		<div v-else>
		    <button @click="isComment = true">댓글쓰기</button>
		</div>

		<!-- 댓글 목록 -->
		<div>
		    댓글
		    <ul>
		        <li v-for="comment in comments" :key="comment.id">
		            <strong>{{ comment.userId }}:</strong> {{ comment.content }}
		        </li>
		    </ul>
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
				isComment : false,
				comments:[],
				commentContent: ""
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
						self.comments = data.comments;
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
			},
			// 댓글 추가
	        fnAddComment() {
	            var self = this;
	            var nparmap = {
	                boardNo: self.boardNo,
	                content: self.commentContent,
	                userId: self.sessionId // 작성자 ID
	            };
	            $.ajax({
	                url: "add-comment.dox", // 댓글 추가 API
	                dataType: "json",
	                type: "POST",
	                data: nparmap,
	                success: function(data) {
	                    alert(data.message);
	                    if (data.result == "success") {
	                        self.commentContent = ""; // 댓글 입력 초기화
	                        self.fnGetInfo(); // 댓글 목록 갱신
	                    }
	                }
	            });
			},
			}
        },
        mounted() {
			var self = this;
			self.fnGetInfo();
        }
    });
    app.mount('#app');
</script>
