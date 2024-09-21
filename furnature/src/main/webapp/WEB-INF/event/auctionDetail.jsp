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
            <p class="blind">경매 상세 페이지</p>
			<div v-if="sessionAuth > 1">
				<button type="button" @click="fnEdit(auctionNo)">수정</button>
				<button type="button" @click="fnRemove(auctionNo)">삭제</button>
			</div>
			<div class="auction-detail-thumb-list" style="display: flex;">
				<div v-for="(item, index) in detailImgListPath">
					<img :src="item" :alt="detailInfo.auctionTitle + ' 썸네일이미지' + (index+1)">
				</div>
			</div>
			<div class="ip-list">
			    <div class="tit-box">
			        <p class="tit">입찰</p>
			    </div>
			    <div class="bot-box">
			        <div class="ip-box ip-ico-box">
			            <input type="text" placeholder="입찰 금액을 입력해주세요" v-model="biddingPrice">
						<button type="button" @click="fnBidding">입찰</button>
			        </div>
			    </div>
			</div>
			<div>경매 번호 : {{detailInfo.auctionNo}}</div>
			<div>제목 : {{detailInfo.auctionTitle}}</div>
			<div>시작 금액 : {{detailInfo.auctionPrice}}</div>
			<div>현재 금액 : {{detailInfo.auctionPriceCurrent}}</div>
			<div>시작일 : {{detailInfo.startDay}}</div>
			<div>종료일 : {{detailInfo.endDay}}</div>
			<div>상세이미지 : <img :src="detailInfo.auctionContentsImgPath" :alt="detailInfo.auctionTitle + '상세이미지'"></div>
			<div>상세설명 : {{detailInfo.auctionContents}}</div>
		</div>
	</div>
	<jsp:include page="/layout/footer.jsp"></jsp:include>
</body>
</html>
<script>
    const app = Vue.createApp({
        data() {
            return {
				sessionId : "${sessionId}",
				sessionAuth : "${sessionAuth}",
				auctionNo : "${auctionNo}",
				detailImgList : [],
				detailImgListPath : [], 
				detailInfo : {},
				biddingPrice : ""
            };
        },
        methods: {
            fnAuctionDetail(){
				var self = this;
				var nparmap = {auctionNo: self.auctionNo};
				$.ajax({
					url:"/event/auction-detail.dox",
					dataType:"json",	
					type : "POST", 
					data : nparmap,
					success : function(data) {
						console.log(data);
						for(var img of data.detailList) {
							self.detailImgList.push(img.auctionImgName);
							self.detailImgListPath.push(img.auctionImgPath);
						}
						self.detailInfo = data.detailList[0];
					}
				});
            },
			fnEdit(auctionNo) {
				$.pageChange("auctionRegister.do", {auctionNo: auctionNo});
			},
			fnRemove(auctionNo) {
				if(!confirm("삭제하시겠습니까?")) return;
				var self = this;
				var imgList = JSON.stringify(self.detailImgList);
				var nparmap = {auctionNo: self.auctionNo, auctionTumb: self.detailImgList, auctionDetail: self.detailInfo.auctionContentsImgName};
				$.ajax({
					url:"/event/auction-remove.dox",
					dataType:"json",	
					type : "POST", 
					data : nparmap,
					success : function(data) {
						if(data.result == "success") {
							$.pageChange("event.do",{});
						} else {
							alert(data.file);
						}
					}
				});
			},
			fnBidding(){
				var self = this;
				if(self.sessionId != "") {
					//if(!confirm("입찰하시겠습니까?")) return;
					if(self.biddingPrice <= self.detailInfo.auctionPriceCurrent) {
						alert("현재 입찰가보다 큰 금액이어야 입찰에 가능합니다.");
						return;
					}
					var nparmap = {auctionNo: self.auctionNo, sessionId: self.sessionId, biddingPrice: self.biddingPrice};
					$.ajax({
						url:"/event/auction-bidding.dox",
						dataType:"json",	
						type : "POST", 
						data : nparmap,
						success : function(data) {
							console.log(data);
							if(data.result == "success") {
								self.detailImgList = [];
								self.detailImgListPath = []; 
								self.detailInfo = {};
								self.fnAuctionDetail();
							} else {
								//alert(data.file);
							}
						}
					});
				} else {
					alert("로그인 후 입찰이 가능합니다.");
				}
			}
        },
        mounted() {
			var self = this;
			self.fnAuctionDetail();
        }
    });
    app.mount('#app');		
</script>