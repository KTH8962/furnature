<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<jsp:include page="/layout/headlink.jsp"></jsp:include>
</head>
<body>
	<div id="app" class="admin">
        <p class="blind">관리자 페이지 - 원데이클래스 등록 및 수정</p>
        <div id="admin-header">
            <h1 class="a-logo"><a href="/admin.do">관리자 페이지 로고</a></h1>
            <jsp:include page="/layout/adminSnb.jsp"></jsp:include>
        </div>
        <div id="admin-container">    
            <div class="contents-top"><a href="/main.do">메인페이지 이동</a></div>
            <div class="contents editor-mode">
                <div class="contens-tit-wrap">
                    <h2 class="admin-tit">
                        원데이클래스 정보 
                        <template v-if="classNo == ''">등록</template>
                        <template v-else>수정</template>
                    </h2>
                </div>
                <div class="contents-editor">
                    <div class="editor-wrap">
                 
                        <div class="ip-list">
                            <div class="tit-box">
                                <p class="tit">클래스명</p>
                            </div>
                            <div class="bot-box">
                                <div class="ip-box">
                                    <input type="text" v-model="className" @input="validateClassName">
                                </div>
                            </div>
                        </div>
                        <div class="ip-list">
                            <div class="tit-box">
                                <p class="tit">수업일자</p>
                            </div>
                            <div class="bot-box">
                                <div class="ip-box">
                                    <input type="datetime-local" v-model="classDate">
                                </div>
                            </div>
                        </div>
                        <div class="ip-list">
                            <div class="tit-box">
                                <p class="tit">수강인원</p>
                            </div>
                            <div class="bot-box">
                                <div class="ip-box">
                                    <input type="text" v-model="numberLimit" @input="validateNumber">
                                </div>
                            </div>
                        </div>
						<div class="ip-list">
                           <div class="tit-box">
                               <p class="tit">수강료</p>
                           </div>
                           <div class="bot-box">
                               <div class="ip-box">
                                   <input type="text" v-model="price" @input="validatePrice">
                               </div>
                           </div>
                       </div>
                        <div class="ip-list">
                            <div class="tit-box">
                                <p class="tit">모집시작일</p>
                            </div>
                            <div class="bot-box">
                                <div class="ip-box">
                                    <input type="datetime-local" v-model="startDay">
                                </div>
                            </div>
                        </div>
                        <div class="ip-list">
                            <div class="tit-box">
                                <p class="tit">모집마감일</p>
                            </div>
                            <div class="bot-box">
                                <div class="ip-box">
                                    <input type="datetime-local" v-model="endDay">
                                </div>
                            </div>
                        </div>
						<div class="ip-list">
                           <div class="tit-box">
                               <p class="tit">상세설명</p>
                           </div>
                           <div class="bot-box">
                               <div class="ip-box">
                                   <div class="text-box"><textarea v-model="description"></textarea></div>
                               </div>
                           </div>
                       </div>
                        <div class="ip-list" v-if="isRegister">
                            <div class="tit-box">
                                <p class="tit">파일업로드</p>
                            </div>
                            <div class="bot-box">
                                <div class="ip-box">
									<input type="file" multiple @change="fnFileUpload">	    
                                </div>
                            </div>
                        </div>
             
                    </div>
                </div>
                <div class="btn-box">
                    <button type="button" class="admin-btn" @click="fnUpdate(classNo)" v-if="!isRegister">수정</button>
                    <button type="button" class="admin-btn" @click="fnRemove(classNo)" v-if="!isRegister">삭제</button>
					<button type="button" class="admin-btn" @click="fnRegister()" v-if="isRegister">등록</button>
                </div>
            </div>
        </div>
	</div>
</body>
</html>
<script>
    const app = Vue.createApp({
        data() {
            return {
				classNo: "${classNo}",
	            className: "",
	            classDate: "",
	            numberLimit: "",
	            price: "",
	            startDay: "",
	            endDay: "",
				description: "",
				isRegister : false,
				file : []
            };
        },
		 methods: {
			fnGetInfo(){
				var self = this;
				var nparmap = {classNo:self.classNo}
				$.ajax({
					url:"/admin/oneday-info.dox",
					dataType:"json",	
					type : "POST", 
					data : nparmap,
					success : function(data){
						console.log(data);
						self.className = data.onedayInfo.className;
						self.numberLimit = data.onedayInfo.numberLimit;
						self.classDate = data.onedayInfo.classDate;
						self.price = data.onedayInfo.price;
						self.startDay = data.onedayInfo.startDay;
						self.endDay = data.onedayInfo.endDay;
						self.description = data.onedayInfo.description || "";
					}
				});
			},
	        validateClassName() {
	            this.className = this.className.replace(/[^A-Za-z가-힣 ]+/g, '');
	        },
	        validatePrice(){
	            this.price = this.price.replace(/[^0-9]/g, '');
	        },
			validateNumber(){
				this.numberLimit = this.numberLimit.replace(/[^0-9]/g, '');
			},
			fnFileUpload(event){
				this.file = event.target.files; 
			},
			fnRegister(){
				var self = this;
				var nparam = {
					className : self.className, 
					classDate : self.classDate.replace('T', ' '),
					numberLimit : self.numberLimit,
					price : self.price,
					startDay : self.startDay.replace('T', ' '),
					endDay : self.endDay.replace('T', ' '),
					description : self.description	
				};
				var startDay = new Date(self.startDay);
				var endDay = new Date(self.endDay);
				var classDate = new Date(self.classDate);
				if(startDay>endDay){
					alert("모집시작일이 모집마감일보다 뒤입니다. 올바른 날짜를 입력해주세요.");
					return;
				}
				if(classDate<startDay){
					alert("모집시작일이 수업일보다 뒤입니다. 올바른 날짜를 입력해주세요.");
					return;
				}
				
				if(!self.className || !self.classDate || !self.numberLimit || !self.price || !self.startDay || !self.endDay || !self.description) {
				        alert("빈칸을 채워주세요.");
				        return;
				}
				$.ajax({
					url:"/oneday/oneday-register.dox",
					dataType:"json",	
					type : "POST", 
					data : nparam,
					success : function(data) {
						console.log(data);
						var classNo = data.classNo;	 
						 if(self.file.length!==0){
							const formData = new FormData();
							for(var i=0; i<self.file.length; i++){
								formData.append('file', self.file[i]);
							} 	formData.append('classNo', classNo);
							
							$.ajax({
								url: '/oneday/oneday-file.dox',
								type : 'POST',
								data : formData,
								processData : false,
								contentType : false,
								success: function(){
									console.log('업로드 성공!');
									$.pageChange("/adminOneday.do", {});
								}
							})
						 }
					}
				});
			},
			
			fnRemove(classNo) {
               if(!confirm("삭제 하시겠습니까?")) return;
               var self = this;
               var nparmap = {classNo: classNo};
				$.ajax({
					url:"/admin/oneday-delete.dox",
					dataType:"json",	
					type : "POST", 
					data : nparmap,
					success : function(data) {
	                       if(data.result == "scuccess") {
	                           alert("삭제 완료되었습니다.")
	                           location.reload();
	                       }
					}
				});
           },
	        fnUpdate() {
	            var self = this;
				self.classDate = self.classDate.replace("T", " ");
				self.startDay = self.startDay.replace("T"," ");
				self.endDay = self.endDay.replace("T", " ");
				
	            var nparam = {
	                classNo: self.classNo,
	                className: self.className, 
	                classDate: self.classDate,
	                numberLimit: self.numberLimit,
	                price: self.price,
	                startDay: self.startDay,
	                endDay: self.endDay,
					description: self.description                
	            };
				console.log(self.classDate);
	            var startDay = new Date(self.startDay);
	            var endDay = new Date(self.endDay);
	            var classDate = new Date(self.classDate);
	            if (startDay > endDay) {
	                alert("모집시작일이 모집마감일보다 뒤입니다. 올바른 날짜를 입력해주세요.");
	                return;
	            }
	            if (classDate < startDay) {
	                alert("모집시작일이 수업일보다 뒤입니다. 올바른 날짜를 입력해주세요.");
	                return;
	            }
	            
	            if (!self.className || !self.classDate || !self.numberLimit || !self.price || !self.startDay || !self.endDay || !self.description) {
	                alert("빈칸을 채워주세요.");
	                return;
	            }
	            $.ajax({
	                url: "/oneday/oneday-update.dox",
	                dataType: "json",    
	                type: "POST", 
	                data: nparam,
	                success: function(data) {
	                    alert("저장되었습니다.");
						$.pageChange("/adminOneday.do", {});
	                }
	            });
	        }
	    },
	    mounted() {
			var self = this;
			if(self.classNo != "" && self.classNo != undefined){
				self.fnGetInfo();
			}else{
				self.isRegister = true;
			}
	        
	    }
	});
app.mount('#app');
</script>