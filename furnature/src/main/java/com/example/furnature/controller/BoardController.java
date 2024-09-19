package com.example.furnature.controller;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.furnature.dao.BoardService;
import com.google.gson.Gson;

@Controller
public class BoardController {
	@Autowired
	BoardService boardService;
	// 게시글 목록
	@RequestMapping("/board/board.do")
	public String boardList(Model model) throws Exception{
		return "/board/board-list";
	}
	// 게시글 작성
	@RequestMapping("/board/board-insert.do") 
    public String boardInsert(Model model) throws Exception{

        return "/board/board-insert";
    }
	
	// 게시글 목록 db
	@RequestMapping(value = "/board/board-list.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String searchBoard(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = boardService.searchBoardList(map);
		return new Gson().toJson(resultMap);
	}
	// 게시글 작성
	@RequestMapping(value = "/board/board-add.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String board_add(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap 
			= new HashMap<String, Object>();
		resultMap = boardService.addBoard(map);
		
		return new Gson().toJson(resultMap);
	}
	// 게시글 삭제
	@RequestMapping(value = "/board/board-remove.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String board_remove(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap 
			= new HashMap<String, Object>();
		resultMap = boardService.removeBoard(map);
		
		return new Gson().toJson(resultMap);
	}
}
