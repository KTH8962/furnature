package com.example.furnature.controller;


import java.io.File;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.example.furnature.dao.ProductService;
import com.example.furnature.mapper.ProductMapper;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Controller
public class ProductController {
	@Autowired
	ProductService productService;
	
	@Autowired
	ProductMapper productMapper;
	// 상품 구매 페이지
	@RequestMapping("/productDetail/pay.do")
	public String productPay(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> map) throws Exception{
		request.setAttribute("productNo", map.get("productNo"));
		request.setAttribute("totalPrice", map.get("totalPrice"));
		request.setAttribute("selectedSize", map.get("selectedSize"));
		System.out.println("Con@@@@@@@@@@"+map);
		return "/productDetail/pay";
	}

	//상품 상세정보 페이지
	@RequestMapping("/productDetail/productDetail.do")
	 public String searchProductDetail(HttpServletRequest request,Model model,@RequestParam HashMap<String, Object> map) throws Exception{
        request.setAttribute("productNo", map.get("productNo"));
		return "/productDetail/productDetail";
    }
	
	// 상품 이미지 url 모두 출력
	@RequestMapping(value = "/productDetail/samplesejin.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	//@RequestParam
	public String searchImgUrl(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = productService.searchImgUrl(map);
		return new Gson().toJson(resultMap);
	}
	// 상품 상세 정보
	@RequestMapping(value = "/productDetail/productDetail.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	//@RequestParam
	public String searchProductDetail(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = productService.searchProductDetail(map);
		return new Gson().toJson(resultMap);
	}
	
	@RequestMapping("/product/product.do")
	public String product(Model model) throws Exception{
		return "/product/product";
	}
	
	//상품 리스트
	@RequestMapping(value = "/product/productList.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String productlist(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		System.out.println(map);
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = productService.productList(map);
		return new Gson().toJson(resultMap);
	}
	
	//카테고리 리스트
	@RequestMapping(value = "/product/cateList.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String catelist(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		System.out.println(map);
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = productService.cateList(map);
		return new Gson().toJson(resultMap);
	}
	// 상품 구매
	@RequestMapping(value = "/productDetail/pay.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	//@RequestParam
	public String productPay(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = productService.searchImgUrl(map);
		return new Gson().toJson(resultMap);
	}
	// 상품 결제
	@RequestMapping(value = "/productDetail/productOrder.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	//@RequestParam
	public String productOrder(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		String json = map.get("orderList").toString(); 
		ObjectMapper mapper = new ObjectMapper();
		List<Object> list = mapper.readValue(json, new TypeReference<List<Object>>(){});
		
		map.put("list", list);
		//마일리지 적립
		productMapper.saveMileage(map);
		
		System.out.println("CONTROLLLLLLLLLLLL ORDER !! PAY"+map);
		resultMap = productService.productOrder(map);
		return new Gson().toJson(resultMap);
	}
	//상품 리뷰 리스트
	@RequestMapping(value = "/productDetail/productReview.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	//@RequestParam
	public String productReview(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = productService.productReview(map);
		return new Gson().toJson(resultMap);
	}
	//리뷰 작성 페이지
	@RequestMapping("/productDetail/reviewInsert.do")
	 public String reviewInsert(HttpServletRequest request,Model model,@RequestParam HashMap<String, Object> map) throws Exception{
		request.setAttribute("productNo", map.get("productNo"));
		return "/productDetail/reviewInsert";
    }
	//리뷰 작성
	@RequestMapping(value = "/productDetail/reviewInsert.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String reviewInsert(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		System.out.println("CCCCCCCCCCCCCCCCCCCCCC"+map);
		resultMap = productService.insertReview(map);
		return new Gson().toJson(resultMap);
	}
	//리뷰 이미지첨부
	@RequestMapping("/productDetail/reviewImgFile.dox")
    public String result(@RequestParam("file1") MultipartFile multi, @RequestParam("reviewNo") int reviewNo, HttpServletRequest request,HttpServletResponse response, Model model)
    {
        String path=System.getProperty("user.dir");
        try {
            String originFilename = multi.getOriginalFilename();
            String extName = originFilename.substring(originFilename.lastIndexOf("."),originFilename.length());
            String saveFileName = SaveFileName(extName);
            if(!multi.isEmpty()){
                File file = new File(path + "\\src\\main\\webapp\\uploadImages\\productReview", saveFileName);
                multi.transferTo(file);
                HashMap<String, Object> map = new HashMap<String, Object>();
                map.put("fileName", saveFileName);
                map.put("filePath", "../uploadImages/productReview/" + saveFileName);
                map.put("reviewNo", reviewNo);
                
                // insert 쿼리 실행
                productMapper.insertReviewImg(map);
                
                model.addAttribute("filename", multi.getOriginalFilename());
                model.addAttribute("uploadPath", file.getAbsolutePath());
                
            } 
        }catch(Exception e) {
            System.out.println(e);
        }
        return "redirect:reviewInsert.do";
    }
	
	//시간기준 파일생성
   private String SaveFileName(String extName) {
        String fileName = "";
        
        Calendar calendar = Calendar.getInstance();
        fileName += calendar.get(Calendar.YEAR);
        fileName += calendar.get(Calendar.MONTH);
        fileName += calendar.get(Calendar.DATE);
        fileName += calendar.get(Calendar.HOUR);
        fileName += calendar.get(Calendar.MINUTE);
        fileName += calendar.get(Calendar.SECOND);
        fileName += calendar.get(Calendar.MILLISECOND);
        fileName += extName;
        
        return fileName;
    }
   //리뷰 삭제
   @RequestMapping(value = "/productDetail/deleteReview.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
   @ResponseBody
   public String deleteReview(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
	   HashMap<String, Object> resultMap = new HashMap<String, Object>();
	   resultMap = productService.deleteReview(map);
	   return new Gson().toJson(resultMap);
   }
   
   //리뷰 수정 페이지
   @RequestMapping("/productDetail/updateReview.do")
   public String updateReview(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> map) throws Exception {
       // 필요한 데이터 설정
       request.setAttribute("reviewNo", map.get("reviewNo"));
       return "productDetail/reviewUpdate"; // 뷰 이름 반환
   }
   //리뷰 수정전 내용 불러오기
   @RequestMapping(value = "/productDetail/reviewInfo.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
   @ResponseBody
   public String reviewInfo(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
	   HashMap<String, Object> resultMap = new HashMap<String, Object>();
	   resultMap = productService.reviewInfo(map);
	   return new Gson().toJson(resultMap);
   }
   //리뷰 수정
   @RequestMapping(value = "/productDetail/updateReview.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
   @ResponseBody
   public String updateReview(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
	   HashMap<String, Object> resultMap = new HashMap<String, Object>();
	   resultMap = productService.updateReview(map);
	   System.out.println("CCCCCCCCCCCCCCCCUPDATE" + map);
	   return new Gson().toJson(resultMap);
   }
   
	   
  
}
