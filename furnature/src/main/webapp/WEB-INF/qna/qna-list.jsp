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
		<select name="cate" v-model="category">
		  <option value="" selected>::전체::</option>
		  <option value="cateTitle">제목</option>
		  <option value="cateUser">작성자</option>
		</select>
		<div class="ip-box">검색 : <input type="text" v-model="searchData">
			 <button @click="fnGetList(1)">검색</button></div>
		<table>
	        <tr>
				<th>카테고리</th>
	            <th>번호</th>
	            <th>작성자</th>
	            <th>제목</th>
	            <th>작성일</th>
	        </tr>
	        <tr v-for="item in list">
				<p>
					<td v-if="item.qnaCategory == 1">질문</td>
					<td v-if="item.qnaCategory == 2">공지사항</td>					
				</p>
	            <td>{{item.qnaNo}}</td>
	            <td>{{item.userName}}</td>
	            <td><a href="#" @click="fnView(item.qnaNo)">{{item.qnaTitle}} <template v-if="item.commentCount > 0">[{{item.commentCount}}]</template></a></td>
	            <td>{{item.udatetime}}</td>
	        </tr>
	    </table>
				<button @click="fnInsert()">게시글작성</button>
		<div class="pagination">
		    <button v-if="currentPage > 1"  @click="fnBeforePage()">이전</button>
		    <button v-for="page in totalPages" :class="{active: page == currentPage}" @click="fnGetList(page)">
		        {{ page }}
		    </button>
		    <button v-if="currentPage < totalPages" @click="fnAfterPage()">다음</button>
		</div>
		<hr>
	</div>
	<jsp:include page="/layout/footer.jsp"></jsp:include>
</body>
</html> 
<script>
    const app = Vue.createApp({
        data() {
            return {
				list : [],
				qnaNo : "",
				title : "",
				userId : "",
				searchData : "",
				category : "",
				number : "",
				sessionId : '${sessionId}',
				currentPage: 1,      
				pageSize: 10,
				totalPages: 1,
				cntValue : 5,
				selectItem : []
            };
        },
        methods: {
            fnGetList(page){
				var self = this;
				self.currentPage = page;
				var startIndex = (page-1) *self.pageSize;			
				var outputNumber = self.pageSize;
				var nparmap = {
					startIndex : startIndex,
				 	outputNumber : outputNumber,
					searchData : self.searchData,
					category : self.category
				    };
				$.ajax({
					url:"qna/qna_list.dox",
					dataType:"json",	
					type : "POST", 
					data : nparmap,
					success : function(data) { 
						console.log(data);
						self.list = data.list;
						self.totalPages = Math.ceil(data.count/self.pageSize);
					}
				});
            },
			fnView(qnano){
				var self = this;
				$.pageChange("/qnaview.do",{qnaNo : qnano});
			},
			fnBeforePage(){
				var self = this;
				self.currentPage =self.currentPage -1;
				self.fnGetList(self.currentPage);
			},
			fnAfterPage(){
				var self = this;
				self.currentPage =self.currentPage +1;
				self.fnGetList(self.currentPage);
			},
			fnInsert(){
				location.href="qna-regist.do";
			}
			
        },
		       
        mounted() {
            var self = this;
			self.fnGetList(1);
        }
    });
    app.mount('#app');
</script>