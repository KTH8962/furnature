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
	            <p class="blind">원데이클래스</p>	
				<h2 class="sub-tit">원데이클래스</h2>
				
				<ul class="img-list oneday-list">
					<li v-for = "item in list" :key="item.classNo">
						<a href="javascript:void(0);" @click="fnChange(item.classNo)">
							<figure class="img"><img :src="item.filePath" :alt="item.className + '이미지'"></figure>
						</a>
						<span class="tit">{{item.className}}</span>
						<span class="price">수강료 <br> {{item.price}} </span>
						<span class="date">수업일자 <br> {{item.classDate}} </span>
						<span class="date">모집기간 <br> {{item.startDay}} ~ {{item.endDay}}</span>
						<span class="state">
							<template v-if="item.message1=='모집 중' && item.numberLimit>item.currentNumber">모집 중</template>
							<template v-else-if="item.message1=='모집 종료' || item.numberLimit==item.currentNumber">모집 종료</template>
						</span>
					</li>
				</ul>
	
				<div>
					<button @click="fnGetList(currentPage - 1)" :disabled="currentPage <= 1">이전</button>
				    <button v-for="page in totalPages" :key="page" :class="{active: page == currentPage}"
					@click="fnGetList(page)">{{page}}</button>
				    <button @click="fnGetList(currentPage+1)" :disabled="currentPage >= totalPages">다음</button>
				</div>
				
				<button @click="fnRegister" v-if="isAdmin">클래스 등록</button>
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
				list : [],
				message1 : "",
				endDay : "",
				numberLimit : "",
				currentNumber : "",
				currentPage : 1,
				totalPages : "",
				pageSize: 8,
				totalCount : "",
				isAdmin : false,
				sessionAuth: "${sessionAuth}",
				test : ""
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
						self.list = [];
						for(var i=0; i<data.onedayList.length; i++){
							self.list.push(data.onedayList[i]);
						}
						self.totalCount = data.totalCount;
						self.totalPages = Math.ceil(self.totalCount / self.pageSize);
						for(var i = 0; i < self.list.length; i++) {
						    var endDay = new Date(self.list[i].endDay);
						    var today = new Date();	
						    if(endDay < today) {
						        self.list[i].message1 = "모집 종료";
						    } else {
						        self.list[i].message1 = "모집 중";
						    }   
						    self.fnCheckNumberLimit(self.list[i].classNo, i); 
						    console.log(self.list[i].message1);	
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
			            // numberLimit 결과를 currentNumber와 함께 self.list에 업데이트
			            if (data.numberLimit) {
			                self.list[index].currentNumber = data.numberLimit.currentNumber;
			                self.list[index].numberLimit = data.numberLimit.numberLimit;
			            }
			            console.log(self.list[index]); // 각 항목의 현재 상태 출력
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