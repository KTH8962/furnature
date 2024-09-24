<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<jsp:include page="/layout/headlink.jsp"></jsp:include>
	<style>
		img{
			width:300px;
		}
	</style>	
</head>
<body>
	<jsp:include page="/layout/header.jsp"></jsp:include>
	<div id="app">
		
		<div style="display:flex;">
			<div v-for = "item in list" :key="item.classNo">
				<div v-if="item.message=='모집 중' && item.numberLimit===0">모집 중</div>
				<div v-if="item.message=='모집 종료' || item.numberLimit===1">모집 종료</div>
				<div>{{item.className}}</div> 
				<div>{{item.classDate}}</div> 
				<div>{{item.price}}</div> 
				<div>{{item.classNo}}</div>
				<div><a href="#" @click="fnChange(item.classNo)"><img :src="item.filePath"></a></div>
			</div>
		</div>
		
		<div>
			<button v-if="currentPage > 1" @click="fnGetList(currentPage-1)">이전</button>
		    <button v-for="page in totalPages" :key="page" :class="{active: page == currentPage}"
			@click="fnGetList(page)">
		        {{page}}
		    </button>
		    <button v-if="currentPage < totalPages" @click="fnGetList(currentPage+1)">다음</button>
		</div>
		
		<button @click="fnRegister" v-if="isAdmin">클래스 등록</button>
	</div>
	<jsp:include page="/layout/footer.jsp"></jsp:include>
</body>
</html>
<script>
    const app = Vue.createApp({
        data() {
            return {
				classNo : "",
				list : [],
				message : "",
				endDay : "",
				numberLimit : "",
				currentPage : 1,
				totalPages : "",
				pageSize: 4,
				totalCount : "",
				isAdmin : false,
				sessionAuth: "${sessionAuth}"
            };
        },
        methods: {
			fnGetList(page){
				var self = this;
				var startIndex = (page-1)*self.pageSize;
				var outputNumber = self.pageSize;
				self.currentPage = page;
				var nparmap = {startIndex:startIndex, outputNumber:outputNumber};
				console.log(nparmap);
				$.ajax({
					url : "/oneday/oneday-list.dox",
					dataType : "json",
					type : "POST",
					data : nparmap,
					success : function(data){
						self.list = data.onedayList;
						self.totalCount = data.totalCount;
						self.totalPages = Math.ceil(self.totalCount / self.pageSize);
						for(var i=0; i<self.list.length; i++){
						   var endDay = new Date(self.list[i].endDay);
						   var today = new Date();	
						   if(endDay < today) {
	   					       self.list[i].message = "모집 종료";
	   					   }else{
	   						   self.list[i].message = "모집 중";
	   					   }   
						   self.fnCheckNumberLimit(self.list[i].classNo, i);		
						}
					}
					
				})
			},
			fnCheckNumberLimit(classNo, index) {
				var self = this;
				var nparmap = { classNo: classNo };	
				$.ajax({
					url: "/oneday/oneday-numberLimit.dox",
					dataType: "json",
					type: "POST",
					data: nparmap,
					success: function(data) {
						self.list[index].numberLimit = data.numberLimit;	
						console.log(self.list[index].numberLimit);
					}
				})
			},
			fnChange(classNo){
				console.log(classNo);
				$.pageChange("/oneday/oneday-join.do", {classNo:classNo});
			},
			changePage(page) {
				if (page < 1 || page > this.totalPages){
					return;
				}
				this.fnGetList(page);
			},
			fnRegister(){
				$.pageChange("/oneday/oneday-register.do", {});	
			}			
        },
        mounted() {
			var self = this;
			self.isAdmin = self.sessionAuth=='2';
			self.fnGetList(1);
        }
    });
    app.mount('#app');
</script>