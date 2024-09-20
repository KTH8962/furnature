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
			디자인을 추천해주세요!
			<div class="ip-box">
	            내가 만든 가구의 이름<input type="text" placeholder="상품의 이름을 입력해주세요" v-model="designTitle">
	        </div>
			<div class="ip-box">
				<div>나의 가구는 이런가구입니다</div>
	           <textarea placeholder="상품을 소개해주세요" v-model="designContents"></textarea>
	        </div>
			<div class="ip-box">
	            디자인 첨부<input type="file" accept=".gif,.jpg,.png" @change="fnDesignAttach">
	        </div>
			<button @click="fnDesignRegist">디자인등록</button>

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
				designTitle : "",
				designContents : "",
				sessionId : '${sessionId}',
				file : null
            };
        },
        methods: {
			fnDesignAttach(event){
	 			this.file = event.target.files[0];
			},
            fnDesignRegist(){
				var self = this;
				var nparmap = {
					designTitle : self.designTitle,
					designContents : self.designContents,
					userId : self.sessionId
				};
				$.ajax({
					url:"/design/designRegist.dox",
					dataType:"json",	
					type : "POST", 
					data : nparmap,
					success : function(data) {
						console.log(data.designNo);
						var designNo = data.designNO;
						if(self.file){
							console.log(data.designNo);
						  const formData = new FormData();
						  formData.append('file1', self.file);
						  formData.append('designNo', self.designNo);
						  $.ajax({
							url: '/design/designFile.dox',
							type: 'POST',
							data: formData,
							processData: false,  
							contentType: false,  
							success: function() {
							  console.log('업로드 성공!');
							},
							error: function(jqXHR, textStatus, errorThrown) {
							  console.error('업로드 실패!', textStatus, errorThrown);
							}
						  });
						}
					}
				});
            },
			
        },
        mounted() {
            var self = this;
			
        }
    });
    app.mount('#app');
</script>