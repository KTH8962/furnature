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
		<div id="container" class="main">            
            <p class="blind">메인페이지</p>
			<div id="main-contents">	
				<div class="main-content">
					<div class="main-divide">
						<div class="left">
							<h2 class="main-tit">원데이 클래스</h2>
							<div class="divide-wrap">
								<div class="divide-box" v-for="item in oneList">
									<a href="javascript:void(0);" class="img-box" @click="fnChangePage('class', item.classNo)">
										<img :src="item.thumbPath" :alt="item.className + '이미지'">
									</a>
									<div class="txt-box">
										<p class="tit">수업명: {{item.className}}</p>
										<p class="price">수강료: {{item.price}}</p>
										<p class="date">강의 일자: {{item.classDate}}</p>
									</div>
								</div>
							</div>
						</div>
						<div class="right">
							<h2 class="main-tit">이벤트 경매</h2>
						</div>
					</div>
				</div>
				<div class="main-content">
					<h2 class="main-tit">커스텀 가구</h2>
					<div class="main-product-wrap">
						<div class="main-product-box" v-for="item in proList">
							<a href="javascript:void(0);" class="img-box" @click="fnChangePage('product', item.productNo)">
								<img :src="item.productThumbnail" :alt="item.productName + '이미지'">
								<span class="txt-box">
									<span class="tit">{{item.productName}}</span>
									<span class="price">{{item.productPrice}}원</span>
								</span>
							</a>
						</div>
					</div>
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
				proList: [],
				oneList: []
            };
        },
        methods: {
            fnProList() {
				var self = this;
				var nparmap = {};
				$.ajax({
					url:"/main/main-product.dox",
					dataType:"json",	
					type : "POST", 
					data : nparmap,
					success : function(data) {
						//console.log(data);
						self.proList = data.list;
					}
				});
            },
			fnOneList() {
				var self = this;
				var nparmap = {};
				$.ajax({
					url:"/main/main-oneday.dox",
					dataType:"json",	
					type : "POST", 
					data : nparmap,
					success : function(data) {
						console.log(data);
						self.oneList = data.list;
					}
				});
            },
			fnChangePage(category, num) {
				if(category == "product") {
					$.pageChange("/productDetail/productDetail.do", {productNo: num});
				} else if (category == "class") {
					$.pageChange("/oneday/oneday-join.do", {classNo: num});
				}
			}
        },
        mounted() {
            var self = this;
			self.fnProList();
			self.fnOneList();
        }
    });
    app.mount('#app');
</script>