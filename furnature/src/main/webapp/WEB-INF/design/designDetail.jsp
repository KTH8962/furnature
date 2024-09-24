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
			<div>
				
			</div>
			<div class="ip-box">
				<div>
					디자이너 {{list.userId}}
				</div>
				<div>
		            디자인 제목 {{list.designTitle}}
				</div>
				<div>
					<img :src="list.designImgPath" style= "width : 500px ; height : 500px">
				</div>
				<div>
					{{list.designContents}}
				</div>
	        </div>
			<button @click="fnRecommend()">추천하기</button>
			<div v-if="sessionId == 'admin'">
				<button @click="fnDesignSelect()">추천확정</button>			
			</div>

			<hr>
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
				designNo : '${designNo}',
				sessionId : '${sessionId}',
				designCheck : false,
				list : {}
            };
        },
        methods: {
			
            fnDesignDetail(){
				var self = this;
				var nparmap = {
					designNo : self.designNo,
					userId : self.sessionId
				};
				$.ajax({
					url:"/design/designDetail.dox",
					dataType:"json",	
					type : "POST", 
					data : nparmap,
					success : function(data) {
						self.list = data.list;
						console.log(data);
					}
				});
            },
			fnRecommend(){
				var self = this;
				if(self.sessionId == '' || self.sessionId == null){
					alert("로그인이 필요한 기능입니다.");
					return;
				}
				var nparmap = {
					designNo : self.designNo,
					userId : self.sessionId
				};
				$.ajax({
					url:"/design/designRecommend.dox",
					dataType:"json",	
					type : "POST", 
					data : nparmap,
					success : function(data) {
						if(data.Flg == "true"){
							alert("추천을 취소하였습니다.");
						}else{
							alert("디자인을 추천하였습니다.");
						}
						console.log(data);
					}
				});
			},
			fnDesignSelect(){
				var self = this;
				if(self.designCheck == false){
					if (!confirm("이 디자인으로 확정을 시키겠습니까?")) {
					       return;
					  }					
				}else{
					alert("이미 확정된 디자인 입니다.");
					return;
				}
				var nparmap = {
					designNo : self.designNo,
					userId : self.sessionId
				};
				$.ajax({
					url:"/design/designSelect.dox",
					dataType:"json",	
					type : "POST", 
					data : nparmap,
					success : function(data) {
						console.log(data);
						if(data.result == '성공'){
							alert("대상 디자인으로 선정하셨습니다.");
							self.designCheck = true;
						}
						
					}
				});
			}	
        },
        mounted() {
            var self = this;
			self.fnDesignDetail();
        }
    });
    app.mount('#app');
</script>