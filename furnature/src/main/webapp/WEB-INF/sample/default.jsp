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
            <p class="blind">기본페이지</p>
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
            fnGetList(category){
				this.category = category;
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
			self.fnGetList(self.category);
        }
    });
    app.mount('#app');
</script>
​