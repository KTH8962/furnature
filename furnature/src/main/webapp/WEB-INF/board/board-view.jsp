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
		</div>
		<div v-else>
		    제목 : {{info.boardTitle}}<br>
		    내용 : <div v-html="info.boardContents"></div>
		    작성자 : <span>{{info.userName}}</span>
		    <div v-if="sessionId == info.userId || sessionAuth == '2'">
		        <button @click="isEditing = true">수정</button>
		        <button @click="fnDelete(info.boardNo)">삭제</button>
		    </div>
		</div>

		<div>
		    댓글내용 : <textarea v-model="commentContents"></textarea><br>
		    <button @click="fnAddComment">댓글쓰기</button>
		</div>
		    
		<!-- 댓글 목록 -->
		<!--v-if="comment.length > 0"-->
		<div v-if="comment.length > 0">
		    댓글
		    <ul>
		        <li v-for="comment in comment" :key="comment.commentNo">
		            {{ comment.userName }}: {{ comment.commentContents }} <br>
					{{ comment.fCdateTime }}
					<div v-if="sessionId == comment.userId || sessionAuth == '2'">
				        <div v-if="editingCommentNos.includes(comment.commentNo)">
							<textarea v-model="comment.commentContents"></textarea>
							<button @click="commentUpdate(comment.commentNo)">수정 완료</button>
							<button @click="cancelEditing(comment.commentNo)">취소</button>
						</div>
						<div v-else>
							<button @click="startEditing(comment.commentNo)">수정</button>
							<button @click="commentDelete(comment.commentNo)">삭제</button>
						</div>
				    </div>
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
				isCommentEditing : false,
				comment:[],
				editingCommentNos: [] // 수정 중인 댓글의 commentNo 목록
            };
        },
        methods: {
			startEditing(commentNo) {
		        // 현재 수정 중인 댓글이 있으면 추가하지 않음
		        if (!this.editingCommentNos.includes(commentNo)) {
		            this.editingCommentNos.push(commentNo);
		        }
		    },
		    cancelEditing(commentNo) {
		        // 수정 취소 시 해당 commentNo 제거
		        this.editingCommentNos = this.editingCommentNos.filter(no => no !== commentNo);
		    },
			// 댓글 수정
			commentUpdate(num){
				var self = this;
				// num (댓글 번호)로 해당 댓글을 찾음
				    var comment = self.comment.find(c => c.commentNo === num);
				var nparmap ={ 
					commentNo: num,
					//fCdateTime: self.comment.fCdateTime,
					commentContents: comment.commentContents
					
				};
				$.ajax({
					url:"comment-update.dox",
					dataType:"json",
					type : "POST", 
					data : nparmap,
					success : function(data) { 
						alert(data.message);
						self.isEditing = false;
						self.fnGetInfo();
						location.reload();
						//$.pageChange("board-view.do");
					}
				});
			},
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
						self.comment = data.comment;
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
			// 댓글 삭제
			commentDelete(num){
				var self = this;
				var nparmap = {commentNo : num};
				$.ajax({
					url:"comment-delete.dox",
					dataType:"json",
					type : "POST", 
					data : nparmap,
					success : function(data) { 
						alert(data.message);
						self.fnGetInfo();
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
	                contents: self.commentContents,
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
	                        self.commentContents = ""; // 댓글 입력 초기화
	                        self.fnGetInfo(); // 댓글 목록 갱신
	                    } 
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