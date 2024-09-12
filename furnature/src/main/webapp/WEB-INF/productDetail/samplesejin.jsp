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
            <p class="blind">샘플페이지</p>
            <div style="display: flex; align-items: center; flex-direction: column;">
				<!--<div>	DB저장된 모든 썸네일 출력
					<template v-for="item in urlList">
						<img :src="item.prodcutThumbnail" style="height : 100px; width : 100px;">
					</template>
				</div>-->
				<!-- 상세 페이지 썸네일 , 이름 가격 등 정보 출력 -->
				<div><img :src="productDetail.prodcutThumbnail"></div>
				<div>{{productDetail.productName}}</div>
				<div>{{productDetail.productPrice}}</div>
				<div>{{productDetail.productColor}}</div>
				<div><select>
						<option>옵션 선택</option>
						<option>{{productDetail.productSize1}}</option>					
						<option>{{productDetail.productSize2}}</option>					
					</select>
				</div>
				<div>
					<button type="button">구매하기</button>
					<button type="button">장바구니</button>
					<button type="button">좋아요버튼?</button>
				</div>
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
				urlList : [],
				productDetail : []
            };
        },
        methods: {
            fnGetProductDetail(){
				var self = this;
				var nparmap = {};
				$.ajax({
					url:"/productDetail/productDetail.dox",
					dataType:"json",	
					type : "POST", 
					data : nparmap,
					success : function(data) { 
						console.log(data);
						self.productDetail = data.productDetail;
					}
				});
            },
			fnGetUrlList(){
				var self = this;
				var nparmap = {};
				$.ajax({
					url:"/productDetail/samplesejin.dox",
					dataType:"json",
					type : "POST", 
					data : nparmap,
					success : function(data) { 
						console.log(data);
						self.urlList = data.urlList;
					}
				});
          	}
        },
        mounted() {
            var self = this;
			self.fnGetProductDetail();
			self.fnGetUrlList();
        }
    });
    app.mount('#app');
</script>
​