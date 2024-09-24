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
					<div>총 포인트 : {{totalMileage}}</div>
					<template v-if="mileageList == ''">
						적립된 마일리지 포인트가 없습니다.
					</template>
					<div v-for="item in mileageList">
						<div>제목 : {{item.mileageName}}</div>
						<div>포인트 : {{item.mileagePrice}} {{item.mileageStatus}}</div>
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
						if(data.mileageList.length > 0) {
							self.mileageList = data.mileageList;
							self.totalMileage = data.mileageList[0].mileageTotal;
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