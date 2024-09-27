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
            <p class="blind">마이페이지 - 내정보</p>
			<div class="myPage-wrap">
				<div class="myPage-snb-wrap">
					<jsp:include page="/layout/myPageSnb.jsp"></jsp:include>
				</div>
				<div class="myPage myPage-mileage">
					<div class="mileage-total">총 포인트 : {{totalMileage}}</div>
					<template v-if="mileageList == ''">
						적립된 마일리지 포인트가 없습니다.
					</template>
					<div v-for="([key, items], index) in Object.entries(mileageList).reverse()" :key="key" class="mileage-wrap">
						<div class="mileage-day">{{key}}</div>
						<div v-for="item in items" class="mileage-box">
							<div class="tit">{{item.mileageName}}</div>
							<div class="price">{{item.mileagePrice}}</div>
							<div class="state">{{item.mileageStatus}}</div>
							<div class="date">풀 : {{item.fullCdatetime}}</div>
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
				sessionId : '${sessionId}',
				mileageList : [],
				totalMileage : ""
            };
        },
        methods: {
            fnGetList(){
				var self = this;
				var nparmap = {sessionId: self.sessionId};
				$.ajax({
					url:"/myPage/mileage-list.dox",
					dataType:"json",	
					type : "POST", 
					data : nparmap,
					success : function(data) {
						console.log(data);
						const keys = Object.keys(data.groupedMileage);
						if(data.groupedMileage[keys[0]].length > 0) {
							self.mileageList = data.groupedMileage;
							self.mileageList.reverse;
							self.totalMileage = data.groupedMileage[keys[0]][0].mileageTotal;
						} else {
							self.totalMileage = 0;
						}
					}
				});
            }
        },
        mounted() {
            var self = this;
			self.fnGetList();
        }
    });
    app.mount('#app');
</script>