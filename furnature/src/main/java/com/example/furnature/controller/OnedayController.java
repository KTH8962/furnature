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
	
	@RequestMapping(value = "/oneday/oneday-register.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String onedayReg(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = onedayService.onedayReg(map);
		return new Gson().toJson(resultMap);
	}
	
	@RequestMapping(value = "/oneday/oneday-file.dox")
    public String result(@RequestParam("file1") MultipartFile multi, @RequestParam("classNo") int idx, HttpServletRequest request,HttpServletResponse response, Model model)
    {
        String url = null;
        String path=System.getProperty("user.dir");
        try {
 
            //String uploadpath = request.getServletContext().getRealPath(path);
            String uploadpath = path;
            String originFilename = multi.getOriginalFilename();
            String extName = originFilename.substring(originFilename.lastIndexOf("."),originFilename.length());
            long size = multi.getSize();
            String saveFileName = genSaveFileName(extName);
         
            System.out.println("Working Directory = " + path + "\\src\\webapp\\img");
            if(!multi.isEmpty()){
                File file = new File(path + "\\src\\main\\webapp\\img", saveFileName);
                multi.transferTo(file);
                System.out.println("file check:"+file);
                HashMap<String, Object> map = new HashMap<String, Object>();
                map.put("fileName", saveFileName);
                map.put("path", "../img/" + saveFileName);
                map.put("idx", idx);
                map.put("fileOrgName", originFilename);
                map.put("extName", extName);
                map.put("size", size);
                onedayService.onedayFile(map);
                // insert 쿼리 실행         
                
                model.addAttribute("filename", multi.getOriginalFilename());
                model.addAttribute("uploadPath", file.getAbsolutePath());
                
                return "redirect:oneday-file.do";
            }
        }catch(Exception e) {
            System.out.println(e);
        }
        return "redirect:oneday-file.do";
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