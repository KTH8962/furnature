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

@Controller
public class AdminController {
	@Autowired
	AdminService adminService;
	
	@RequestMapping("/admin.do")
	public String userList(Model model) throws Exception{
		model.addAttribute("activePage", "admin");
		return "/admin/adminUser";
	}
	
	@RequestMapping("/adminEditor.do")
	public String userEdit(Model model) throws Exception{
		model.addAttribute("activePage", "admin");
		return "/admin/adminUserEditor";
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
	public String removeUser(Model model, @RequestParam HashMap<String, Object> map, @RequestParam("removeList") String[] removeList) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		List<String> removes = new ArrayList<>();
		for(String remove : removeList) {
			removes.add(remove);
		}
		map.put("removeList", removes);
		map.remove("removeList[]");
		resultMap = adminService.removeUserList(map);
		return new Gson().toJson(resultMap);
	}
}
