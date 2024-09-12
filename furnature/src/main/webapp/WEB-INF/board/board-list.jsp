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
			<ul style="margin : 20px;">
				<li><a>전체</a></li>
				<li><a>공지사항</a></li>
				<li><a>자유게시판</a></li>
				<li><a>질문게시판</a></li>
			</ul>
			<div style="margin : 20px;"> 
				<select style="margin-right : 5px;">
					<option value="all">:: 전체 ::</option>
					<option value="title">제목</option>
					<option value="name">작성자</option>
				</select>
				<input placeholder="검색어" v-model="keyword">
				<button @click="fnGetList()">검색</button>
			</div>
			<table>
				<tr>
					<th>게시글번호</th>
					<th>제목</th>
					<th>작성자</th>
					<th>조회수</th>
					<th>작성일</th>
					<th>삭제</th>
				</tr>
				<tr v-for="item in list">
					<td>{{item.boardNo}}</td>
					<td>{{item.title}}</td>
					<td>{{item.userName}}</td>
					<td>{{item.hit}}</td>
					<td>{{item.fCdateTime}}</td>
					<td>
						<!--<template v-if="sessionEmail == item.email || sessionStatus == 'A'">-->
							<button>삭제</button>
					</td>
						<!--</template>-->
				</tr>	
			</table>
			
			<div>
				<button>글쓰기</button>
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
        },
        mounted() {
            var self = this;
			self.fnGetList();
        }
    });
    app.mount('#app');
</script>
​