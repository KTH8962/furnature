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
            <p class="blind">마이페이지 - 장바구니</p>
			<div class="myPage-wrap">
				<div class="myPage-snb-wrap">
					<jsp:include page="/layout/myPageSnb.jsp"></jsp:include>
				</div>
				<div class="myPage myPage-info">
					장바구니 페이지 
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
			fnGetCartList() {
	           var self = this;
	           var nparmap = {userId : self.sessionId};
	           $.ajax({
	               url: "/myPage/mypage-cart.dox",
	               dataType: "json",
	               type: "POST",
	               data: nparmap,
	               success: function(data) {
					console.log(data);
	                   self.list = data.list;
	               }
	           });
	       }
        },
        mounted() {
            var self = this;
			//self.fnGetCartList();
        }
    });
    app.mount('#app');
</script>