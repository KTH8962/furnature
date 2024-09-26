package com.example.furnature.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.furnature.dao.AdminService;
import com.google.gson.Gson;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class AdminController {
	@Autowired
	AdminService adminService;
	
  // 유저 정보 목록
	@RequestMapping("/admin.do")
	public String userList(Model model) throws Exception{
		model.addAttribute("activePage", "admin");
		return "/admin/adminUser";
	}
	
  // 유저 정보 수정
	@RequestMapping("/adminEditor.do")
	public String userEdit(Model model, HttpServletRequest request, @RequestParam HashMap<String, Object> map) throws Exception{
		model.addAttribute("activePage", "admin");
		request.setAttribute("id", map.get("id"));
		return "/admin/adminUserEditor";
	}
	
	@RequestMapping("/adminOneday.do")
	public String onedayClass(Model model, HttpServletRequest request, @RequestParam HashMap<String, Object> map) throws Exception{
		request.setAttribute("sessionAuth", map.get("sessionAuth"));
		return "/admin/adminOneday";
	}
	
	@RequestMapping("/admin/oneday-edit.do")
	public String onedayEdit(Model model, HttpServletRequest request, @RequestParam HashMap<String, Object> map) throws Exception{
		request.setAttribute("classNo", map.get("classNo"));
		return "/admin/adminOnedayEditor";
	}
	
	// 유저 정보 목록 db
	@RequestMapping(value = "/admin/admin-user.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String searchUserList(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = adminService.searchUserList(map);
		return new Gson().toJson(resultMap);
	}
	
	// 유저 정보 삭제 db
	@RequestMapping(value = "/admin/admin-user-remove.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String removeUser(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();		
		resultMap = adminService.removeUser(map);
		return new Gson().toJson(resultMap);
	}
	
	// 유저 정보 수정 db
	@RequestMapping(value = "/admin/admin-user-edit.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String editUser(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		System.out.println(map);
		resultMap = adminService.editUser(map);
		return new Gson().toJson(resultMap);
	}
     
	// 비밀번호 초기화 db
	@RequestMapping(value = "/admin/admin-user-pwd.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String resetPwd(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		System.out.println(map);
		resultMap = adminService.resetPwd(map);
		return new Gson().toJson(resultMap);
	}

  // 원데이클래스 신청인수 등 현황 조회
  @RequestMapping(value = "/admin/oneday-list.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
  @ResponseBody
  public String currentNumber(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
    HashMap<String, Object> resultMap = new HashMap<String, Object>();
    resultMap = adminService.currentNumber(map);
    return new Gson().toJson(resultMap);
  }
  // 원데이클래스 삭제
  @RequestMapping(value = "/admin/oneday-delete.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
  @ResponseBody
  public String onedayDelete(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
    HashMap<String, Object> resultMap = new HashMap<String, Object>();
    resultMap = adminService.onedayDelete(map);
    return new Gson().toJson(resultMap);
  }
  
  // 원데이클래스 개별조회
  @RequestMapping(value = "/admin/oneday-info.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
  @ResponseBody
  public String onedayInfo(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
    HashMap<String, Object> resultMap = new HashMap<String, Object>();
    resultMap = adminService.onedayInfo(map);
    return new Gson().toJson(resultMap);
  }
}
