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
            <p class="blind">이벤트 페이지</p>
			<h2 class="sub-tit">경매 리스트</h2>
			<ul class="auction-list" style="display:flex;">
				<li v-for="item in auctionList">
					<a href="javascript:void(0);" @click="fnDeatil(item.auctionNo)">
						<img :src="item.auctionImgPath" :alt="item.auctionTitle + '이미지'">
						<span>{{item.auctionNo}}</span><br>
						<span>{{item.auctionTitle}}</span><br>
						<span>{{item.auctionPriceCurrent}}</span><br>
						<span>{{item.startDay}}</span><br>
						<span>{{item.endDay}}</span><br>
						<span>
							<template v-if="item.auctionStatus == 'F'">경매 예정</template>
							<template v-else-if="item.auctionStatus == 'I'">경매 진행중</template>
							<template v-else>경매 종료</template>
						</span>
					</a>
				</li>
			</ul>
			<a href="/event/auctionRegister.do">경매등록 임시버튼</a>
			
			<h2 class="sub-tit">룰렛?</h2>
		</div>
	</div>
	<jsp:include page="/layout/footer.jsp"></jsp:include>
</body>
</html>
<script>
    const app = Vue.createApp({
        data() {
            return {
				statusInfo: [],
				auctionList: [],
            };
        },
        methods: {
			fnStatus(){
				var self = this;
				var nparmap = {};
				$.ajax({
					url:"/event/auction-status.dox",
					dataType:"json",	
					type : "POST", 
					data : nparmap,
					success : function(data) {
						console.log(data);
						for(var status of data.statusList) {
							var state;
							if(status.startDay < 0) {
								state = "I";
								if(status.endDay < 0) {
									state = "E";
								}
							} else {
								state = "F";
							}
							self.statusInfo.push({"status": state, "auctionNo": status.auctionNo});
						}
						if(data.result == "success") {
							var status = JSON.stringify(self.statusInfo);
							var sparmap = {statusInfo: status};
							$.ajax({
								url:"/event/auction-setting.dox",
								dataType:"json",
								type:"POST",
								data:sparmap,
								success : function(data) {
									console.log(data);
									if(data.result == "success") {
										self.fnAuctionList();
									}
								}
							});
						}
					}
				});
			},
            fnAuctionList(){
				var self = this;
				var nparmap = {};
				$.ajax({
					url:"/event/auction-list.dox",
					dataType:"json",	
					type : "POST", 
					data : nparmap,
					success : function(data) {
						//console.log(data);
						self.auctionList = data.auctionList;
					}
				});
            },
			fnDeatil(auctionNo) {
				$.pageChange("auctionDetail.do",{auctionNo: auctionNo});
			}
        },
        mounted() {
            var self = this;
			self.fnStatus();
        }
    });
    app.mount('#app');
</script>