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
            <p class="blind">샘플페이지</p>
            <div style="display: flex; align-items: center; flex-direction: column;">
                
                <p style="font-size: 20px; font-weight: bold; margin-bottom: 20px;">인풋</p>
                <div class="ip-box">
                    <input type="text" placeholder="텍스트입력">
                </div>

                <p style="font-size: 20px; font-weight: bold; margin: 20px;">체크박스 - 텍스트X</p>
                <div class="ip-chk">
                    <input type="checkbox" name="t" id="t1"><label for="t1">체크박스1</label>
                    <input type="checkbox" name="t" id="t2"><label for="t2">체크박스2</label>
                </div>
    
                <p style="font-size: 20px; font-weight: bold; margin: 20px;">체크박스 - 텍스트</p>
                <div class="ip-chk-txt">
                    <input type="checkbox" name="t2" id="t12"><label for="t12">체크박스1</label>
                    <input type="checkbox" name="t2" id="t22"><label for="t22">체크박스2</label>
                </div>
    
                <p style="font-size: 20px; font-weight: bold; margin: 20px;">라디오 - 텍스트X</p>
                <div class="ip-ra">
                    <input type="radio" name="r" id="r1"><label for="r1">라디오1</label>
                    <input type="radio" name="r" id="r2"><label for="r2">라디오2</label>
                </div>

                <p style="font-size: 20px; font-weight: bold; margin: 20px;">라디오 - 텍스트</p>
                <div class="ip-ra-txt">
                    <input type="radio" name="r2" id="r12"><label for="r12">라디오1</label>
                    <input type="radio" name="r2" id="r22"><label for="r22">라디오2</label>
                </div>

                <p style="font-size: 20px; font-weight: bold; margin: 20px;">pagenation</p>
				<div class="pagenation">
                    <button type="button" class="prev">이전</button>
                    <button type="button" class="num active">1</button>
                    <button type="button" class="num">2</button>
                    <button type="button" class="num">3</button>
                    <button type="button" class="num">4</button>
                    <button type="button" class="num">5</button>
                    <button type="button" class="num">6</button>
                    <button type="button" class="num">7</button>
                    <button type="button" class="num">8</button>
                    <button type="button" class="num">9</button>
                    <button type="button" class="next">다음</button>
                </div>
				
				<p style="font-size: 20px; font-weight: bold; margin: 20px;">타이틀 + 인풋</p>
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
	</div>
	<jsp:include page="/layout/footer.jsp"></jsp:include>
</body>
</html>
<script>
    const app = Vue.createApp({
        data() {
            return {
				empList : [],
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
        },
        mounted() {
            var self = this;
			self.fnGetList();
        }
    });
    app.mount('#app');
</script>
​