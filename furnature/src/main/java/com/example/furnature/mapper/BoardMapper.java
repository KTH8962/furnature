package com.example.furnature.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.furnature.model.Board;

@Mapper
public interface BoardMapper {
	List<Board> selectBoardList(HashMap<String, Object> map);
}
