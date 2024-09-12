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
			<div v-for="item in cateList">
				<div><a href="#" @click="fnCateSearchList(item.cateNo)">{{item.cateName}}</a></div>
			</div>
			<div style="display:flex;">
		  가로(W)<div class="ip-box">
		            <input type="text" placeholder="width(mm)">
		        </div>
		  세로(D)<div class="ip-box">
		            <input type="text" placeholder="depth(mm)">
		        </div>
		  높이(H)<div class="ip-box">
		            <input type="text" placeholder="height(mm)">
		        </div>
			</div>
			<div v-for="item in productList">
				<div><a href="#"><img :src="item.prodcutThumbnail" style="width:150px; height : 150px;"></a></div>
				{{item.productName}}
				<div>{{item.productPrice}}</div>
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
				cateList : []
            };
        },
        methods: {
			fnGetProductList(){
				var self = this;
				var nparmap = {};
				$.ajax({
					url:"/product/productList.dox",
					dataType:"json",	
					type : "POST", 
					data : nparmap,
					success : function(data) {
						self.productList = data.productList;								
					}
				});				
			},
            fnGetCateList(){
				var self = this;
				var nparmap = {};
				$.ajax({
					url:"/product/cateList.dox",
					dataType:"json",	
					type : "POST", 
					data : nparmap,
					success : function(data) {
						self.cateList = data.list;							
						
					}
				});
			},
			fnCateSearchList(num){
				
			}
        },
        mounted() {
            var self = this;
			self.fnGetCateList();
			self.fnGetProductList();
        }
    });
    app.mount('#app');
</script>
​