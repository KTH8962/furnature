<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<jsp:include page="/layout/headlink.jsp"></jsp:include>
	<style>
		img{
			width:600px;
		}
	</style>	
</head>
<body>
	<jsp:include page="/layout/header.jsp"></jsp:include>
	<div id="app">
		<div v-for = "item in list">
			<div>{{item.className}}</div> 
			<div>{{item.classDate}}</div> 
			<div>{{item.price}}</div> 
			<div>{{item.classNo}}</div>
			<div><a href="#" @click="fnChange(item.classNo)"><img :src="item.filePath"></a></div>
		</div>
	</div>
	<jsp:include page="/layout/footer.jsp"></jsp:include>
</body>
</html>
<script>
    const app = Vue.createApp({
        data() {
            return {
				classNo : "",
				list : []
            };
        },
        methods: {
			fnGetList(){
				var self = this;
				var nparmap = {};
				$.ajax({
					url : "/oneday/oneday-list.dox",
					dataType : "json",
					type : "POST",
					data : nparmap,
					success : function(data){
						self.list = data.onedayList;
						console.log(data);
					}
					
				})
			},
			fnChange(classNo){
				console.log(classNo);
				$.pageChange("/oneday/oneday-join.do", {classNo:classNo})
			}
			
        },
        mounted() {
			var self = this;
			self.fnGetList();
        }
    });
    app.mount('#app');
</script>