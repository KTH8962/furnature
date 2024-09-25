<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<jsp:include page="/layout/headlink.jsp"></jsp:include>
</head>
<body>
	<div id="app" class="admin">
        <p class="blind">관리자 페이지 - 유저 정보</p>
        <div id="admin-header">
            <h1 class="a-logo"><a href="/admin.do">관리자 페이지 로고</a></h1>
            <jsp:include page="/layout/adminSnb.jsp"></jsp:include>
        </div>
        <div id="admin-container">    
            <div class="contents-top"><a href="/main.do">메인페이지 이동</a></div>
            <div class="contents">
                <div class="contens-tit-wrap">
                    <h2 class="admin-tit">유저 정보</h2>
                    <div class="search-box">
                        <div class="select-box">
                            <select name="" id="">
                                <option value="">전체</option>
                                <option value="">이름</option>
                                <option value="">제목</option>
                            </select>
                        </div>
                        <div class="ip-box ip-ico-box">
                            <input type="text" placeholder="이름을 입력해주세요" v-model="keyword" @keyup.enter="fnPageChange(1)">
                            <div class="btn-box type1"><button type="button" @click="fnPageChange(1)">검색버튼</button></div>
                        </div>
                    </div>
                </div>
                <div class="contents-table">
                    <div class="flex-table user-table">
                        <div class="thead">
                            <div class="tr">
                                <div class="th">삭제</div>
                                <div class="th">아이디</div>
                                <div class="th">이름</div>
                                <div class="th">주소</div>
                                <div class="th">전화번호</div>
                                <div class="th">이메일</div>
                                <div class="th">생년월일</div>
                                <div class="th">회원등급</div>
                                <div class="th">룰렛 참여 현황</div>
                                <div class="th">수정</div>
                            </div>
                        </div>
                        <div class="tbody">
                            <div class="tr" v-for="(item, index) in userList">
                                <div class="td">
                                    <div class="ip-chk" v-if="item.userId != 'admin'">
                                        <input type="checkbox" name="remove" :id="index" v-model="removeList" :value="item.userId"><label :for="index">삭제</label>
                                    </div>
                                </div>
                                <div class="td">{{item.userId}}</div>
                                <div class="td">{{item.userName}}</div>
                                <div class="td">{{item.userAddr}}</div>
                                <div class="td">
                                    <template v-if="num === index">
                                        <div class="ip-box">
                                            <input type="text" v-model="phone">
                                        </div>
                                    </template>
                                    <template v-else>{{item.userPhone}}</template>
                                </div>
                                <div class="td">
                                    <template v-if="num === index">
                                        <div class="ip-box">
                                            <input type="text" v-model="email">
                                        </div>
                                    </template>
                                    <template v-else>{{item.userEmail}}</template>
                                </div>
                                <div class="td">{{item.userBirth}}</div>
                                <div class="td">
                                    <template v-if="num === index"><button type="button">비밀번호<br>초기화</button></template>
                                    <template v-else>{{item.userAuth}}</template>
                                </div>
                                <div class="td">{{item.eventRoul}}</div>
                                <div class="td">
                                    <template v-if="item.userId != 'admin'">
                                        <button type="button" @click="fnSave(item.userId)" v-if="num === index">저장</button>
                                        <button type="button" @click="fnEdit(index)" v-else>수정</button>
                                    </template>
                                    <template v-else>수정불가</template>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="btn-box">
                    <button type="button" class="admin-btn">등록</button>
                    <button type="button" class="admin-btn" @click="fnRemove">삭제</button>
                </div>
            </div>
            <div class="contents-bottom">
                <div class="pagenation">
                    <button type="button" class="prev" :disabled="currentPage == 1" @click="fnPageChange(currentPage - 1)">이전</button>
                    <button type="button" class="num" v-for="item in totalPages" :class="{active: item == currentPage}" @click="fnPageChange(item)">{{item}}</button>
                    <button type="button" class="next" :disabled="currentPage == totalPages" @click="fnPageChange(currentPage + 1)">다음</button>
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
                removeList: [],
                num: "",
                phone: "",
                email: "",
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
                self.num = "";
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
            },
            fnEdit(index) {
                var self = this;
                self.num = index;
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
			self.fnGetList(1);
        }
    });
    app.mount('#app');
</script>