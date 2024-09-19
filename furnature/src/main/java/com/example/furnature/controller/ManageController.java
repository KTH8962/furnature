package com.example.furnature.controller;

import java.io.File;
import java.util.Calendar;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.example.furnature.dao.ManageService;
import com.example.furnature.mapper.ManageMapper;
import com.google.gson.Gson;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Controller
public class ManageController {
	
	 @Autowired 
	 ManageService manageService;
	 @Autowired
	 ManageMapper manageMapper;

	//상품등록
	@RequestMapping("/manage/management.do")
	public String product(Model model) throws Exception{
		return "/manage/management";
	}

	
	//상품등록
	@RequestMapping(value = "/manage/manageProduct.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String manageProduct(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = manageService.enrollProduct(map);
		return new Gson().toJson(resultMap);
	}
	@RequestMapping("/fileUpload.dox")
    public String result(@RequestParam("thumbnailFile") MultipartFile thumbnailFile,
            @RequestParam("descriptionFile") MultipartFile descriptionFile, @RequestParam("productNo") int productNo, HttpServletRequest request,HttpServletResponse response, Model model)
    {
        String url = null;
        String path=System.getProperty("user.dir");
        System.out.println(path);
        try {
        	
        	HashMap<String, Object> map = new HashMap<>();
        	if (!thumbnailFile.isEmpty()) {
                String originFilename = thumbnailFile.getOriginalFilename();
                String extName = originFilename.substring(originFilename.lastIndexOf("."));
                String saveFileName = genSaveFileName(extName);
                File thumbnailFileToSave = new File(path + "\\src\\main\\webapp\\images", saveFileName);
                thumbnailFile.transferTo(thumbnailFileToSave);
                map.put("productNo", productNo);
                map.put("productThumbnail", "../images/" + saveFileName);
            }

            // 설명 파일 처리
            if (!descriptionFile.isEmpty()) {
                String originFilename = descriptionFile.getOriginalFilename();
                String extName = originFilename.substring(originFilename.lastIndexOf("."));
                String saveFileName = genSaveFileName(extName);
                File descriptionFileToSave = new File(path + "\\src\\main\\webapp\\images", saveFileName);
                descriptionFile.transferTo(descriptionFileToSave);
                map.put("productDetail1", "../images/" + saveFileName);
            }
            
	            manageMapper.attachProduct(map);
                return "redirect:product/product.do";
            
        
        }catch(Exception e) {
            System.out.println(e);
        }
        return "redirect:product/product.do";
    }
    
    // 현재 시간을 기준으로 파일 이름 생성
    private String genSaveFileName(String extName) {
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
}
