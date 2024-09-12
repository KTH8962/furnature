<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<jsp:include page="/layout/headlink.jsp"></jsp:include>
</head>
<body>
	<div id="app">
		<jsp:include page="/layout/header.jsp"></jsp:include>
		<div id="container">            
            <p class="blind">기본페이지</p>
		</div>
		<jsp:include page="/layout/footer.jsp"></jsp:include>
	</div>
</body>
</html>
<script>
    const app = Vue.createApp({
        data() {
            return {
            };
        },
        methods: {
            smaple(){
				var self = this;
				var nparmap = {};
				$.ajax({
					url:"",
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
			self.smaple();
        }
    });
    app.mount('#app');
</script>
​