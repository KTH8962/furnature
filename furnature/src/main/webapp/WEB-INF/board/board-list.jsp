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
			
			<div style="margin : 20px;"> 
				<select style="margin-right : 5px;">
					<option value="all">:: 전체 ::</option>
					<option value="title">제목</option>
					<option value="name">작성자</option>
				</select>
				<div class="ip-box">
	                <input type="text" placeholder="검색어" v-model="keyword">
	            </div>
				<button @click="fnGetList()">검색</button>
			</div>
			<table>
				<tr>
					<th>게시글번호</th>
					<th>제목</th>
					<th>작성자</th>
					<th>작성일</th>
					<th>삭제</th>
				</tr>
				<tr v-for="item in list">
					<td>{{item.boardNo}}</td>
					<td>{{item.boardTitle}}</td>
					<td>{{item.userName}}</td>
					<td>{{item.cdateTime}}</td>
					<td>
						<template v-if="sessionId == item.userId || sessionStatus == 'A'">
							<button @click="fnRemove(item.boardNo)">삭제</button></td>
						</template>
					
				</tr>	
			</table>
			<div>
				<button @click="fnInsert()">글쓰기</button>
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
				list : [],
				keyword : "",
				sessionEmail : '${sessionEmail}',
				sessionStatus : '${sessionStatus}',	

            };
        },
        methods: {
			fnGetList(){
				var self = this;
				var nparmap = {
					keyword : self.keyword,
				};
				$.ajax({
					url:"board-list.dox",
					dataType:"json",	
					type : "POST", 
					data : nparmap,
					success : function(data) { 
						console.log(data);
						self.list = data.list;
					}
				});
	        },
			fnRemove(num) {
				var self = this;
				var nparmap = {boardNo : num};
				$.ajax({
					url:"board-remove.dox",
					dataType:"json",	
					type : "POST", 
					data : nparmap,
					success : function(data) { 
						alert(data.message);
						self.fnGetList();
					}
				});
			},
			fnInsert(){
				//location.href = "board-insert.do";
				$.pageChange("board-insert.do",{});
			},
        },
        mounted() {
            var self = this;
			self.fnGetList();
        }
    });
    app.mount('#app');
</script>
​