package com.example.furnature.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.furnature.model.Sample;

@Mapper
public interface SampleMapper {
	List<Sample> selectEmpList(HashMap<String, Object> map);
}
