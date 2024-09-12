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
            <p class="blind">샘플페이지</p>
            <div style="display: flex; align-items: center; flex-direction: column;">
				<!--<div>	DB저장된 모든 썸네일 출력
					<template v-for="item in urlList">
						<img :src="item.prodcutThumbnail" style="height : 100px; width : 100px;">
					</template>
				</div>-->
					
				<p style="font-size: 20px; font-weight: bold; margin: 20px;">출력</p>
				<table>
					<thead>
						<tr>
							<th>사번</th>
							<th>이름</th>
							<th>직책</th>
							<th>사수사번</th>
							<th>입사일</th>
							<th>급여</th>
							<th>보너스</th>
							<th>부서번호</th>
						</tr>
					</thead>
					<tbody>
						<tr v-for="(item, index) in empList">					
							<td>{{item.empNo}}</td>
							<td>{{item.eName}}</td>
							<td>{{item.job}}</td>
							<td>{{item.mgr}}</td>
							<td>{{item.hiredate}}</td>
							<td>{{item.sal}}</td>
							<td>{{item.comm}}</td>
							<td>{{item.deptNo}}</td>
						</tr>
					</tbody>
				</table>
            </div>
        </div>
		<jsp:include page="/layout/footer.jsp"></jsp:include>
	</div>
</body>
</html>
<script>
    const app = Vue.createApp({
        data() {
            return {
				empList : [],
				urlList : []
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
						console.log(data);
						self.empList = data.empList;
					}
				});
            },
			fnGetUrlList(){
				var self = this;
				var nparmap = {};
				$.ajax({
					url:"/productDetail/samplesejin.dox",
					dataType:"json",
					type : "POST", 
					data : nparmap,
					success : function(data) { 
						console.log(data);
						self.urlList = data.urlList;
					}
				});
          	}
        },
        mounted() {
            var self = this;
			self.fnGetList();
			self.fnGetUrlList();
        }
    });
    app.mount('#app');
</script>
​