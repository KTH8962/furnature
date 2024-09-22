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
            <p class="blind">마이페이지 - 경매입찰리스트</p>
			<div class="myPage-wrap">
				<div class="myPage-snb-wrap">
					<jsp:include page="/layout/myPageSnb.jsp"></jsp:include>
				</div>
				<div class="myPage myPage-info">
					<div v-for="item in biddingList">
						<div>경매 제목 : {{item.auctionTitle}}</div>
						<div>경매 번호 : {{item.auctionNo}}</div>
						<div>입찰 금액 : {{item.maxBidding}}</div>
						<div>입찰 일자 : {{item.auctionBiddingDate}}</div>
						<div><button type="button" @click="fnCancel(item.auctionNo)">입찰 취소</button></div>
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
				biddingList : [],
            };
        },
        methods: {
            fnGetList(){
				var self = this;
				var nparmap = {sessionId: self.sessionId};
				$.ajax({
					url:"/myPage/bidding-list.dox",
					dataType:"json",	
					type : "POST", 
					data : nparmap,
					success : function(data) {
						console.log(data);
						self.biddingList = data.biddingList;
					}
				});
            },
			fnCancel(auctionNo){
				if(!confirm("입찰을 취소 하시겠습니까?")) return;
				var self = this;
				var nparmap = {auctionNo: auctionNo, sessionId: self.sessionId};
				$.ajax({
					url:"/myPage/bidding-cancel.dox",
					dataType:"json",	
					type : "POST", 
					data : nparmap,
					success : function(data) {
						if(data.result =="success") {
							self.fnGetList();
							alert(data.message);
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