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
			<button @click="fnDesignRegist">디자인등록</button>
			{{sessionId}}
		</div>
	</div>
	<jsp:include page="/layout/footer.jsp"></jsp:include>
</body>
</html>
<script>
    const app = Vue.createApp({
        data() {
            return {
				sessionId : '${sessionId}'
            };
        },
        methods: {
            fnGetList(){
				var self = this;
				var nparmap = {};
				$.ajax({
					url:"/design/design.dox",
					dataType:"json",	
					type : "POST", 
					data : nparmap,
					success : function(data) {
					}
				});
            },
			fnDesignRegist(){
				location.href="/design/designRegist.do";
			}
        },
        mounted() {
            var self = this;
			
        }
    });
    app.mount('#app');
</script>