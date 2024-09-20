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
			<!--상품 리스트출력 -->
			<div>
				<div class="ip-box">
		                *상품이름<input type="text" v-model="productName" placeholder="상품이름">
		            </div>
					<br>
					<div class="ip-box">
		                *가로길이<input type="text" v-model="productWidth" placeholder="width(mm)">
		            </div>
					<br>
					<div class="ip-box">
		                *세로길이<input type="text" v-model="productLength" placeholder="depth(mm)">
		            </div>
					<br>
					<div class="ip-box">
		                *높이<input type="text" v-model="productHeight" placeholder="height(mm)">
		            </div>
					<br>
					<div class="ip-box">
		                *가격<input type="text" v-model="productPrice" placeholder="가격">
		            </div>
					<br>
					<div class="ip-box">
		                색상<input type="text" v-model="productColor" placeholder="색상">
		            </div>
					<br>
					<div class="ip-box">
		                *상품 사이즈1<input type="text" v-model="productSize1"placeholder="100mmX100mmX100mm(가로,세로,높이)">
		            </div>
					<br>			
					<div class="ip-box">
		                상품 사이즈2<input type="text" v-model="productSize2"placeholder="100mmX100mmX100mm(가로,세로,높이)">
		            </div>
					<br>			
					<div class="ip-box">
		                상품 사이즈3<input type="text" v-model="productSize3"placeholder="100mmX100mmX100mm(가로,세로,높이)">
		            </div>
					<br>			
					*커스텀 유무
					<div class="ip-ra-txt">
		                <input type="radio" name="custom" v-model=productCustom value="Y" id="r12"><label for="r12">가능</label>
		                <input type="radio" name="custom" v-model=productCustom value="N" id="r22"><label for="r22">불가능</label>
		            </div>
					<br>
					*카테고리1
					<div class="ip-ra-txt">
		                <input type="radio" name="category1" v-model=productCate1 value="1" id="r32"><label for="r32">거실</label>
		                <input type="radio" name="category1" v-model=productCate1 value="2" id="r42"><label for="r42">욕실</label>
		                <input type="radio" name="category1" v-model=productCate1 value="3" id="r52"><label for="r52">주방</label>
		                <input type="radio" name="category1" v-model=productCate1 value="4" id="r62"><label for="r62">침실</label>
		                <input type="radio" name="category1" v-model=productCate1 value="5" id="r72"><label for="r72">오피스</label>
		            </div>
					<br>
					카테고리2
					<div class="ip-ra-txt">
		                <input type="radio" name="category2" v-model=productCate2 value="1" id="r82"><label for="r82">거실</label>
		                <input type="radio" name="category2" v-model=productCate2 value="2" id="r92"><label for="r92">욕실</label>
		                <input type="radio" name="category2" v-model=productCate2 value="3" id="r102"><label for="r102">주방</label>
		                <input type="radio" name="category2" v-model=productCate2 value="4" id="r112"><label for="r112">침실</label>
		                <input type="radio" name="category2" v-model=productCate2 value="5" id="r122"><label for="r122">오피스</label>
		            </div>
				<div>
					<button @click="fnUpdate()">수정</button>
					<button @click="fnCancel()">취소</button>
				</div>
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
				productList : {},
				productNo : '${productNo}',
				productName : "",
				productWidth : "",
				productLength : "",
				productHeight : "",
				productPrice : "",
				productColor : "",
				productSize1 : "",
				productSize2 : "",
				productSize3 : "",
				productCustom : "",
				productCate1 : "",
				productCate2 : ""
            };
        },
        methods: {
			fnGetProductList(){
				var self = this;
				
				var nparmap = {
					productNo : self.productNo
				};
				$.ajax({
					url:"/manage/productUpdateList.dox",
					dataType:"json",	
					type : "POST", 
					data : nparmap,
					success : function(data) {
						self.productList = data.list;
						self.productName = self.productList.productName;
						self.productWidth = self.productList.productWidth;
						self.productLength = self.productList.productLength;
						self.productHeight = self.productList.productHeight;
						self.productPrice = self.productList.productPrice;
						self.productColor = self.productList.productColor;
						self.productSize1 = self.productList.productSize1;
						self.productSize2 = self.productList.productSize2;
						self.productSize3 = self.productList.productSize3;
						self.productCate1 = self.productList.productCate1;
						self.productCate2 = self.productList.productCate2;
					}
				});				 
			},
			fnUpdate(productNo){
				var self = this;
				if(self.productName == ""){
					alert("상품이름을 입력해주세요");
					return;
				}else if(self.productWidth=="" || self.productLength=="" || self.productHeight==""){
					alert("치수는 입력해주세요.");
					return;
				}else if(self.productPrice==""){
					alert("가격을 입력해주세요");
					return;
				}else if(self.productCustom==""){
					alert("커스텀 유무를 선택해주세요");
					return;
				}else if(self.productCate1 == self.productCate2){
					alert("각각다른 카테고리를 선택해주세요");
					return;
				}else if (self.productCate1 == ""|| self.productCate2==""){
					alert("카테고리를 선택해주세요");
					return;
				}else if(self.productSize1==""){
					alert("사이즈를 입력해주세요");
					return;
				}
				var nparmap = {
					productNo : self.productNo,
					productName : self.productName,
					productWidth : self.productWidth,
					productLength : self.productLength,
					productHeight : self.productHeight,
					productPrice : self.productPrice,
					productColor : self.productColor,
					productSize1 : self.productSize1,
					productSize2 : self.productSize2,
					productSize3 : self.productSize3,
					productCustom : self.productCustom,
					productCate1 : self.productCate1,
					productCate2 : self.productCate2
				};
				$.ajax({
					url:"/manage/manageProductUpdate.dox",
					dataType:"json",	
					type : "POST", 
					data : nparmap,
					success : function(data) {
					 	if(data.message=="success"){
							alert("수정되었습니다");
						}else{
							alert("실패!");
						}
					}
				});
			},
			fnCancel(){
				history.back();
			}
        },
        mounted() {
            var self = this;
			self.fnGetProductList();
        }
    });
    app.mount('#app');
</script>
​ 