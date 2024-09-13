<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<jsp:include page="/layout/menu.jsp"></jsp:include>
	<link href="https://cdn.quilljs.com/1.3.6/quill.snow.css" rel="stylesheet">
    <script src="https://cdn.quilljs.com/1.3.6/quill.min.js"></script>
	<title>view 기본 세팅 파일</title>
</head>
<head>
	<jsp:include page="/layout/headlink.jsp"></jsp:include>
</head>
<body>
	<jsp:include page="/layout/header.jsp"></jsp:include>

	<div id="app">
		<table>
			<tr>
				<th>제목</th>
				<td><input id="boardTitle" v-model="boardTitle"></td>
			</tr>
			<tr>
				<th>내용</th>
				<td><div id="editor"></div></td>
			</tr>
		</table>
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
				sessionId : '${sessionId}'
            };
        },
        methods: {
			fnSave (){
				var self = this;
				var nparam = {boardTitle : self.boardTitle, boardContents : self.boardContents, userId : self.sessionId};
				$.ajax({
					url:"board-add.dox",
					dataType:"json",	
					type : "POST", 
					data : nparam,
					success : function(data) { 
						alert(data.message);
						if(data.result == "success"){
							location.href = "board-list.do"
						}
					}
				});
			}
        },
        mounted() {
			var self = this;
			// Quill 에디터 초기화
	        var quill = new Quill('#editor', {
	            theme: 'snow',
	            modules: {
	                toolbar: [
	                    [{ 'header': [1, 2, 3, 4, 5, 6, false] }],
	                    ['bold', 'italic', 'underline'],
	                    [{ 'list': 'ordered'}, { 'list': 'bullet' }],
	                    ['link', 'image'],
	                    ['clean']
	                ]
	            }
	        });

	        // 에디터 내용이 변경될 때마다 Vue 데이터를 업데이트
	        quill.on('text-change', function() {
	            self.contents = quill.root.innerHTML;
	        });
        }
    });
    app.mount('#app');
</script>
​