<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<jsp:include page="/layout/headlink.jsp"></jsp:include>
</head>
<body>
	<div id="app" class="admin">
        <p class="blind">관리자 페이지 - 유저 정보 등록 및 수정</p>
        <div id="admin-header">
            <h1 class="a-logo"><a href="/admin.do">관리자 페이지 로고</a></h1>
            <jsp:include page="/layout/adminSnb.jsp"></jsp:include>
        </div>
        <div id="admin-container">    
            <div class="contents-top"><a href="/main.do">메인페이지 이동</a></div>
            <div class="contents editor-mode">
                <div class="contens-tit-wrap">
                    <h2 class="admin-tit">
                        유저 정보 
                        <template v-if="id == ''">등록</template>
                        <template v-else>수정</template>
                    </h2>
                </div>
                <div class="contents-editor">
                    <div class="editor-wrap">
                        <div class="ip-list">
                            <div class="tit-box">
                                <p class="tit">타이틀</p>
                            </div>
                            <div class="bot-box">
                                <div class="ip-box">
                                    <input type="text">
                                </div>
                            </div>
                        </div>
                        <div class="ip-list">
                            <div class="tit-box">
                                <p class="tit">타이틀</p>
                            </div>
                            <div class="bot-box">
                                <div class="ip-box">
                                    <input type="text">
                                </div>
                            </div>
                        </div>
                        <div class="ip-list">
                            <div class="tit-box">
                                <p class="tit">타이틀</p>
                            </div>
                            <div class="bot-box">
                                <div class="ip-box">
                                    <input type="text">
                                </div>
                            </div>
                        </div>
                        <div class="ip-list">
                            <div class="tit-box">
                                <p class="tit">타이틀</p>
                            </div>
                            <div class="bot-box">
                                <div class="ip-box">
                                    <input type="text">
                                </div>
                            </div>
                        </div>
                        <div class="ip-list">
                            <div class="tit-box">
                                <p class="tit">타이틀</p>
                            </div>
                            <div class="bot-box">
                                <div class="ip-box">
                                    <input type="text">
                                </div>
                            </div>
                        </div>
                        <div class="ip-list">
                            <div class="tit-box">
                                <p class="tit">타이틀</p>
                            </div>
                            <div class="bot-box">
                                <div class="ip-box">
                                    <input type="text">
                                </div>
                            </div>
                        </div>
                        <div class="ip-list">
                            <div class="tit-box">
                                <p class="tit">타이틀</p>
                            </div>
                            <div class="bot-box">
                                <div class="ip-box">
                                    <input type="text">
                                </div>
                            </div>
                        </div>
                        <div class="ip-list">
                            <div class="tit-box">
                                <p class="tit">타이틀</p>
                            </div>
                            <div class="bot-box">
                                <div class="ip-box">
                                    <input type="text">
                                </div>
                            </div>
                        </div>
                        <div class="ip-list">
                            <div class="tit-box">
                                <p class="tit">타이틀</p>
                            </div>
                            <div class="bot-box">
                                <div class="ip-box">
                                    <input type="text">
                                </div>
                            </div>
                        </div>
                        <div class="ip-list">
                            <div class="tit-box">
                                <p class="tit">타이틀</p>
                            </div>
                            <div class="bot-box">
                                <div class="ip-box">
                                    <input type="text">
                                </div>
                            </div>
                        </div>
                        <div class="ip-list">
                            <div class="tit-box">
                                <p class="tit">타이틀</p>
                            </div>
                            <div class="bot-box">
                                <div class="ip-chk-txt">
                                    <input type="checkbox" name="t2" id="t12"><label for="t12">체크박스1</label>
                                    <input type="checkbox" name="t2" id="t22"><label for="t22">체크박스2</label>
                                </div>
                            </div>
                        </div>
                        <div class="ip-list">
                            <div class="tit-box">
                                <p class="tit">타이틀</p>
                            </div>
                            <div class="bot-box">
                                <div class="ip-box">
                                    <input type="text">
                                </div>
                            </div>
                        </div>
                        <div class="ip-list">
                            <div class="tit-box">
                                <p class="tit">타이틀</p>
                            </div>
                            <div class="bot-box">
                                <div class="ip-ra-txt">
                                    <input type="radio" name="r2" id="r12"><label for="r12">라디오1</label>
                                    <input type="radio" name="r2" id="r22"><label for="r22">라디오2</label>
                                </div>
                            </div>
                        </div>
                        <div class="ip-list">
                            <div class="tit-box">
                                <p class="tit">타이틀</p>
                            </div>
                            <div class="bot-box">
                                <div class="ip-box">
                                    <input type="text">
                                </div>
                            </div>
                        </div>
                        <div class="ip-list">
                            <div class="tit-box">
                                <p class="tit">타이틀</p>
                            </div>
                            <div class="bot-box">
                                <div class="ip-box">
                                    <input type="text">
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="btn-box">
                    <button type="button" class="admin-btn">등록</button>
                    <button type="button" class="admin-btn">삭제</button>
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
                id: "${id}",
            };
        },
        methods: {
            fnGetList() {
				var self = this;
				var nparmap = {};
				$.ajax({
					url:"",
					dataType:"json",	
					type : "POST", 
					data : nparmap,
					success : function(data) {
                        //console.log(data);
					}
				});
            },
            fnSave(id) {
                var self = this;
                var self = this;
				var check1 = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/; // 이메일이 적합한지 검사할 정규식
				var check2 = /^\d+$/;
				
				var phone = self.phone;
				var email = self.email;

                if(phone != "" && !self.compare(check2, phone, "phoneRef","전화번호는 숫자만 작성해주세요.")){
                    return;
				} else if(phone != "" && self.lengthCheck(phone, 10, "전화번호는 최소 10자리 이상 입력해주세요.")){
                    return;
                } else if(email != "" && !self.compare(check1, email, "emailRef","적합하지 않은 이메일 형식입니다")) {
					return;
				} else {
                    var nparmap = {id: id, phone: self.phone, email: self.email};
                    if(!(self.email == "" && self.phone == "")){
                        $.ajax({
                            url:"/admin/admin-user-edit.dox",
                            dataType:"json",	
                            type : "POST", 
                            data : nparmap,
                            success : function(data) {
                                console.log(data);
                                self.fnGetList(self.currentPage);
                            }
                        });
                    }
                    self.num = "";
                    self.phone = "";
                    self.email = "";
                }
            },
            compare(check, form, name, message) {
				var self = this;
			    if(check.test(form)) {
			        return true;
			    }
			    alert(message);
			    return false;
			},
            lengthCheck(id, cnt, message){
                if(id.length < cnt) {
                    alert(message);
                    return true;
                }
                return false;
            }
        },
        mounted() {
            var self = this;
        }
    });
    app.mount('#app');
</script>