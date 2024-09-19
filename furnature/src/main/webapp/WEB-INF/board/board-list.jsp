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
				<li><a href="#" @click="fnCategory('')">전체</a></li>
				<li><a href="#" @click="fnCategory('1')">공지사항</a></li>
				<li><a href="#" @click="fnCategory('2')">자유게시판</a></li>
				<li><a href="#" @click="fnCategory('3')">질문게시판</a></li>
			</ul>
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
									<!--|| sessionStatus == 'A'	-->
						<template v-if="sessionId == item.userId ">
							<button @click="fnRemove(item.boardNo)">삭제</button>
						</template>
					</td>
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
				category: "",
				sessionEmail : '${sessionEmail}',
				sessionStatus : '${sessionStatus}',	

            };
        },
        methods: {
			fnGetList(){
				var self = this;
				var nparmap = {
					keyword : self.keyword,
					category: self.category
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
			fnCategory(category) {
                this.category = category;  // 선택한 카테고리 ID를 설정
                this.fnGetList();  // 리스트를 다시 불러옴
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