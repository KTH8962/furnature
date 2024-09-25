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
		<div>
			<select v-model="searchOption" v-if="sessionAuth == '2'" placeholder="공지여부">
				<option value="Y">공지사항</option>
				<option value="N">일반게시글</option>
			</select>
		</div>
		<!--<div class="ip-ra-txt" v-model="searchOption" v-if="sessionAuth == '2'">
            <input value="Y" type="radio" name="r2" id="r12"><label for="r12">공지사항</label>
            <input value="N" type="radio" name="r2" id="r22"><label for="r22">일반게시글</label>
        </div>-->
			<tr>
			    제목 : <textarea v-model="boardTitle"></textarea><br>
			    내용 : <textarea v-model="boardContents"></textarea><br>
				이미지 첨부 : <input type="file" @change="ImageUpload" multiple />
			</tr>
		<button id="btn" @click="fnSave">저장</button>
	</div>
	<jsp:include page="/layout/footer.jsp"></jsp:include>

</body>
</html>
<script>
    const app = Vue.createApp({
        data() {
            return {
				boardTitle : "",
				boardContents : "",
				sessionId : '${sessionId}',
				sessionAuth : '${sessionAuth}',
				searchOption: "Y",
            };
        },
        methods: {
			// 게시글 저장
			fnSave (){
				var self = this;
				var nparam = {
					boardTitle : self.boardTitle, 
					boardContents : self.boardContents, 
					userId : self.sessionId,
					noticeYn: self.searchOption 
				};
				console.log(self.boardTitle)
				$.ajax({
					url:"board-add.dox",
					dataType:"json",
					type : "POST",
					data : nparam,
					success : function(data) { 
						alert(data.message);
						if(data.result == "success"){
							 location.href = "board.do"
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