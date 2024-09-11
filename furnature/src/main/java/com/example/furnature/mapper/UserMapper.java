package com.example.furnature.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.furnature.model.User;

@Mapper
public interface UserMapper {
	List<User> selectUser(HashMap<String, Object> map);
}
