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
			<div>질문게시판</div>
			<div>
				<select v-model="searchOption">
					<option value="all">:: 전체 ::</option>
					<option value="title">제목</option>
					<option value="name">작성자</option>
				</select>
				<div class="ip-box">
	                <input type="text" placeholder="검색어" v-model="keyword">
	            </div>
				<button @click="fnGetList(1)">검색</button>
			</div>
			<div>
				<select v-model="selectSize" @change="fnGetList(1)">
					<option value="5">5개씩</option>
					<option value="10">10개씩</option>
					<option value="15">15개씩</option>
				</select>
			</div> 
			<table>
				<thead>
					<tr>
						<th>게시글번호</th>
						<th>제목</th>
						<th>작성자</th>
						<th>작성일</th>
						<th>삭제</th>
					</tr>
				</thead>
				<tbody>
					<tr v-for="(item, index) in list">
						<td>{{item.boardNo}}</td>
						<td><a href="#" @click="fnView(item.boardNo)">{{item.boardTitle}} [{{item.cnt}}]</a></td>
						<td>{{item.userName}}</td>
						<td>{{item.fCdateTime}}</td>
						<td>
							<div v-if="sessionId == item.userId || sessionAuth == '2'">
								<button @click="fnRemove(item.boardNo)">삭제</button>
							</div>
						</td>
					</tr>	
				</tbody>
			</table>
			<div>
				<button @click="fnInsert()">글쓰기</button>
			</div>
			
			<div class="pagenation">
			    <button type="button" class="prev" v-if="currentPage > 1"
				@click="fnBeforPage()"	
				>이전</button>
			    <button class="num" v-for="page in totalPages" 
				:class="{active: page == currentPage}"
				@click="fnGetList(page)"
				>
					 {{ page }}
			    </button>
			    <button type="button" class="next" v-if="currentPage < totalPages"
				@click="fnNextPage()"
				>다음</button>
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
				searchOption : "all",
				category: "",
				sessionId : '${sessionId}',
				sessionAuth : '${sessionAuth}',
				currentPage: 1,      
				pageSize: 5,        
				totalPages: 1,
				selectSize : 5,
            };
        },
        methods: {
			fnGetList(page){
				var self = this;
				self.pageSize = self.selectSize;
				self.currentPage = page;
				var startIndex = (page-1) * self.pageSize;
				var outputNumber = self.pageSize;
				var nparmap = {
					keyword : self.keyword,
					searchOption : self.searchOption,
					category: self.category,
					startIndex : startIndex,
					outputNumber : outputNumber,
				};
				$.ajax({
					url:"board-list.dox",
					dataType:"json",	
					type : "POST", 
					data : nparmap,
					success : function(data) { 
						console.log(data.list);
						self.list = data.list;
						self.totalPages = Math.ceil(data.count / self.pageSize);
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
						self.fnGetList(1);
					}
				});
			},
			fnCategory(category) {
				var self = this;
                self.category = category;
                self.fnGetList();
            },
			fnInsert(){
				$.pageChange("board-insert.do",{});
			},
			fnView(boardNo){
				$.pageChange("board-view.do", {boardNo : boardNo});
			},
			fnBeforPage(){
				var self = this;
				if(self.currentPage == 1){
					return;
				}
				self.currentPage = self.currentPage - 1;
				self.fnGetList(self.currentPage);
			},
			fnNextPage(){
				var self = this;
				if(self.totalPages == self.currentPage){
					return;
				}
				self.currentPage = self.currentPage + 1;
				self.fnGetList(self.currentPage);
			}
        },
        mounted() {
            var self = this;
			self.fnGetList(1);
        }
    });
    app.mount('#app');
</script>
​