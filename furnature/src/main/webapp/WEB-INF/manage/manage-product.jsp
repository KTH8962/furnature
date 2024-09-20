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
            <p class="blind">기본페이지</p>
			<div class="ip-box">
	            <input type="text" v-model="searchKeyword" placeholder="상품이름">
				<button @click="fnSearchItem">상품검색</button>
	        </div>
			<!--상품 리스트출력 -->
			<div>
				<div>
					상품번호 상품명 상품가격 색상 커스텀유무
				</div>
				<div v-for="item in productList">
					<div><!--<img :src="item.prodcutThumbnail" style="width:150px; height : 150px;">-->
					{{item.productNo}}
					{{item.productName}}
					{{item.productPrice}}
					{{item.productColor}}
					{{item.productCustom}}
					<button @click="fnUpdate(item.productNo)">수정</button>
					<button @click="fnDelete(item.productNo)">삭제</button>
					</div>
				</div>
			</div>
			<!--페이징처리-->
			<div class="pagenation">
                <button type="button" class="prev" v-if="currentPage > 1" @click="fnBeforPage()">이전</button>
                <button type="button" class="num" v-for="page in totalPages" :class="{active: page == currentPage}" @click="fnGetProductList(page)">
					{{page}}
				</button>
                <button type="button" class="next" v-if="currentPage < totalPages" @click="fnNextPage()">다음</button>
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
				productList : [],
				cateList : [],
				searchKeyword : "",
				keyword : "",
				cateNum : "",
				width : "",
				depth : "",
				height : "",
				currentPage: 1,      
				pageSize: 12,        
				totalPages: 1,
				widthSize : "",
				depthSize : "",
				heightSize: ""
            };
        },
        methods: {
			fnGetProductList(page){
				var self = this;
				var startIndex = (page-1) *self.pageSize;			
				self.currentPage = page;
				var outputNumber = this.pageSize;
				var nparmap = {
					startIndex : startIndex,
			 	    outputNumber : outputNumber,
					cateNum : self.cateNum,
					keyword : self.keyword
				};
				$.ajax({
					url:"/manage/productManage.dox",
					dataType:"json",	
					type : "POST", 
					data : nparmap,
					success : function(data) {
						self.productList = data.productList;
						self.totalPages = Math.ceil(data.count/self.pageSize);								
					}
				});				 
			},
			fnSearchItem(){
				var self = this;
				self.keyword = self.searchKeyword;
				self.fnGetProductList(1);
			},
			fnUpdate(productno){
				var self = this;
				$.pageChange("/manage/productUpdate.do",{productNo : productno});
			},
			fnDelete(productno){
				var self = this;
				if (!confirm("상품번호"+productno+"의 게시물을 삭제하시겠습니까?")) {
				        return;
				    }
				var nparmap = {
					productNo : productno
				};
				$.ajax({
					url:"/manage/productDelete.dox",
					dataType:"json",	
					type : "POST", 
					data : nparmap,
					success : function(data) {
						if(data.message="success"){
							alert("삭제되었습니다.");
							self.fnGetProductList(1);					
						}else{
							alert("삭제시 문제가 발생하였습니다.");
						}
					}
				});
			}
        },
        mounted() {
            var self = this;
			self.fnGetProductList(1);
        }
    });
    app.mount('#app');
</script>
​ 