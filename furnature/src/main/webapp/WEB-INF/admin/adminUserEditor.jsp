<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<jsp:include page="/layout/headlink.jsp"></jsp:include>
</head>
<body>
	<div id="app" class="admin">
        <p class="blind">관리자 페이지 - 유저 정보 수정</p>
        <div id="admin-header">
            <h1 class="a-logo"><a href="/admin.do">관리자 페이지 로고</a></h1>
            <jsp:include page="/layout/adminSnb.jsp"></jsp:include>
        </div>
        <div id="admin-container">    
            <div class="contents-top"><a href="/main.do">메인페이지 이동</a></div>
            <div class="contents editor-mode">
                <div class="contens-tit-wrap">
                    <h2 class="admin-tit">유저 정보 수정</h2>
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
                    <button type="button" class="admin-btn">수정</button>
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
                userList: [],
                currentPage: 1,
                pageSize: 11,
                totalPages: 0,
                keyword: "",
                removeList: []
            };
        },
        methods: {
            fnGetList(page) {
				var self = this;
                var page = (page - 1) * self.pageSize;
				var nparmap = {currentPage: page, pageSize: self.pageSize, keyword: self.keyword};
				$.ajax({
					url:"/admin/admin-user.dox",
					dataType:"json",	
					type : "POST", 
					data : nparmap,
					success : function(data) {
                        //console.log(data);
                        self.userList = data.userList;
                        self.totalPages = Math.ceil(data.userAllList.allUser / self.pageSize);
					}
				});
            },
            fnPageChange(item) {
                var self = this;
                self.currentPage = item;
                self.fnGetList(item);
            },
            fnRemove() {
                var self = this;
                var nparmap = {removeList: self.removeList};
				$.ajax({
					url:"/admin/admin-user-remove.dox",
					dataType:"json",	
					type : "POST", 
					data : nparmap,
					success : function(data) {
                        console.log(data);
                        if(data.result == "scuccess") {
                            self.fnGetList(1);
                        }
					}
				});
            }
        },
        mounted() {
            var self = this;
			self.fnGetList(1);
        }
    });
    app.mount('#app');
</script>