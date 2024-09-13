package com.example.furnature.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.furnature.model.Event;

@Mapper
public interface EventMapper {
	List<Event> selectEmpList(HashMap<String, Object> map);
}
