package com.example.furnature.controller;

import java.io.File;
import java.util.Calendar;
import java.util.HashMap;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.example.furnature.dao.OnedayService;
import com.google.gson.Gson;

@Controller
public class OnedayController {
	
	@Autowired
	OnedayService onedayService;
	
	@RequestMapping("/oneday/oneday.do")
	 public String onedayList(Model model) throws Exception{

        return "/oneday/oneday";
    }
	
	@RequestMapping("/oneday/oneday-join.do")
	 public String onedayJoin(HttpServletRequest request, Model model, @RequestParam HashMap<String,Object> map) throws Exception{
		request.setAttribute("classNo", map.get("classNo"));
		
       return "/oneday/oneday-join";
   }

	@RequestMapping("/oneday/oneday-file.do")
	 public String onedayFile(Model model) throws Exception{

       return "/oneday/oneday-file";
   }
	
	@RequestMapping(value = "/oneday/oneday-list.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String onedayList(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = onedayService.onedayList(map);
		return new Gson().toJson(resultMap);
	}
	
	@RequestMapping(value = "/oneday/oneday-detail.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String onedayDetail(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = onedayService.onedayDetail(map);
		return new Gson().toJson(resultMap);
	}
	
	@RequestMapping(value = "/oneday/oneday-pay.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String onedayPay(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = onedayService.onedayPay(map);
		return new Gson().toJson(resultMap);
	}
	
	@RequestMapping(value = "/oneday/oneday-file.dox")
	public String uploadFile(@RequestParam("file1") MultipartFile multi, 
	                         @RequestParam("classNo") int idx, 
	                         HttpServletRequest request, 
	                         HttpServletResponse response, 
	                         Model model) {
	    String path = System.getProperty("user.dir") + "/src/main/webapp/img";
	    String fileName = multi.getOriginalFilename();
	    String extName = fileName.substring(fileName.lastIndexOf("."));
	    long size = multi.getSize();
	    String saveFileName = genSaveFileName(extName);

	    try {
	        if (!multi.isEmpty()) {
	            File file = new File(path, saveFileName);
	            multi.transferTo(file);

	            // 파일 정보를 HashMap에 저장
	            HashMap<String, Object> map = new HashMap<>();
	            map.put("fileName", saveFileName);
	            map.put("path", "../img/" + saveFileName);
	            map.put("idx", idx);
	            map.put("fileOrgName", fileName);
	            map.put("extName", extName);
	            map.put("size", size);

	            // 서비스 메서드 호출
	            onedayService.onedayFile(map);

	            model.addAttribute("filename", fileName);
	            model.addAttribute("uploadPath", file.getAbsolutePath());

	            return "redirect:oneday-file.do";
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    return "redirect:oneday-file.do";
	}

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