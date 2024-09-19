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
            <p class="blind">경매등록 페이지</p>
			<div class="ip-list">
			    <div class="tit-box">
			        <p class="tit">경매 이름</p>
			    </div>
			    <div class="bot-box">
			        <div class="ip-box">
			            <input type="text" v-model="title">
			        </div>
			    </div>
			</div>
			<div class="ip-list">
			    <div class="tit-box">
			        <p class="tit">경매 시작가</p>
			    </div>
			    <div class="bot-box">
			        <div class="ip-box">
			            <input type="text" v-model="price">
			        </div>
			    </div>
			</div>
			<div class="ip-list">
			    <div class="tit-box">
			        <p class="tit">경매 썸네일 이미지</p>
			    </div>
			    <div class="bot-box">
			        <div class="ip-box">
			            <input type="file" multiple @change="fnFileChange($event, 'thumbFile')">
			        </div>
			    </div>
			</div>
			<div class="ip-list">
			    <div class="tit-box">
			        <p class="tit">경매 상세 이미지</p>
			    </div>
			    <div class="bot-box">
			        <div class="ip-box">
			            <input type="file" @change="fnFileChange($event, 'contentsFile')">
			        </div>
			    </div>
			</div>
			<div class="ip-list">
			    <div class="tit-box">
			        <p class="tit">경매 상세 설명</p>
			    </div>
			    <div class="bot-box">
			        <div class="text-box">
			            <textarea v-model="contents"></textarea>
			        </div>
			    </div>
			</div>
			<div class="ip-list">
			    <div class="tit-box">
			        <p class="tit">경매 시작 시간</p>
			    </div>
			    <div class="bot-box">
			        <div class="ip-box">
			            <input type="datetime-local" v-model="startDay">
			        </div>
			    </div>
			</div>
			<div class="ip-list">
			    <div class="tit-box">
			        <p class="tit">경매 종료 시간</p>
			    </div>
			    <div class="bot-box">
			        <div class="ip-box">
			            <input type="datetime-local" v-model="endDay">
			        </div>
			    </div>
			</div>
			<button type="button" @click="fnAuction">경매 등록 하기</button>
		</div>
	</div>
	<jsp:include page="/layout/footer.jsp"></jsp:include>
</body>
</html>
<script>
    const app = Vue.createApp({
        data() {
            return {
				title : "경매제목",
				price : 2000,
				thumbFile : [],
				contentsFile : "",
				contents : "123",
				startDay : "2024-09-23T12:25",
				endDay : "2024-09-28T12:25",
				//sessionId : '${sessionId}'
				sessionId : 'admin'
            };
        },
        methods: {
            fnAuction(){
				var self = this;
				var check = /[0-9]/;
				/* 오늘 날짜 체크용 */
				var time = new Date();
				var year = time.getFullYear();
				var month = String(time.getMonth()+1).padStart(2, "0");
				var day = String(time.getDate()).padStart(2, "0");
				var today = year + "-" + month + "-" + day + "T00:00";

				
				if(self.compare(self.title, "경매 제목을 입력해주세요.")){
					return false;
				} else if (self.compare(self.price, "시작가를 입력해주세요.")) {
					return false;
				} else if (self.compare2(check, self.price, "시작가는 숫자만 입력해주세요.")) {
					return false;
				} else if (self.compare(self.thumbFile, "경매 썸네일 이미지 파일을 등록해주세요.")) {
					return false;
				} else if (self.compare(self.startDay, "시작일을 입력해주세요.")) {
					return false;
				} else if (self.compare(self.endDay, "종료일을 입력해주세요.")) {
					return false;
				} else if (today > self.startDay) {
					alert("시작일은 오늘 일자보다 늦은 일자 및 시간으로 선택해주세요");
					return false;
				} else if (self.startDay >= self.endDay) {
					alert("종료일 시작일 보다 늦은 일자로 선택해주세요");
					return false;
				} 
				self.startDay = self.startDay.replace("T"," ");
				self.endDay = self.endDay.replace("T"," ");
				var nparmap = {title: self.title, price: self.price, id: self.sessionId, startDay: self.startDay, endDay: self.endDay, contents: self. contents};
				$.ajax({
					url:"/event/auction-register.dox",
					dataType:"json",	
					type : "POST", 
					data : nparmap,
					success : function(data) {
						var auctionNo = data.auctionNo;
						if (self.thumbFile) {
							const formData = new FormData();
							for (var i = 0; i < self.thumbFile.length; i++) {
	                        	formData.append('thumbFile', self.thumbFile[i]);
	                   		}
							formData.append('contentsFile', self.contentsFile);
							formData.append('auctionNo', auctionNo);
						  	$.ajax({
								url: '/event/thumbUpload.dox',
								type: 'POST',
								data: formData,
								processData: false,  
								contentType: false,  
								success: function(data) {
									console.log('업로드 성공!');
									$.pageChange("/event/event.do",{});
								},
								error: function(jqXHR, textStatus, errorThrown) {
									console.error('업로드 실패!', textStatus, errorThrown);
								}
						   });
						}
					}
				});
            },
			compare(form, message) {
				if(form == "" || form == undefined) {
					alert(message);
					return true;
				}
				return false;
			},
			compare2(check, form, message) {
				if(!check.test(form)) {
					alert(message);
					return true;
				}
				return false;
			},
			fnFileChange(event, targeting) {
				var self = this;
				if(targeting == "thumbFile") {
					self.thumbFile = event.target.files;
				} else if (targeting == "contentsFile") {
					self.contentsFile = event.target.files[0];
				}
			}
        },
        mounted() {
            var self = this;
        }
    });
    app.mount('#app');		
</script>