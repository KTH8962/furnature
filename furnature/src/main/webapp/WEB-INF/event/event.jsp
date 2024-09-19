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
			<a href="/event/eventRegister.do">이벤트등록 임시버튼</a>
			
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
            };
        },
        methods: {
            fnGetList(){
				var self = this;
				var nparmap = {};
				$.ajax({
					url:"/sample/sample.dox",
					dataType:"json",	
					type : "POST", 
					data : nparmap,
					success : function(data) {
					}
				});
            },
        },
        mounted() {
            var self = this;
			self.fnGetList();
        }
    });
    app.mount('#app');
</script>