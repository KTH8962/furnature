package com.example.furnature.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.furnature.mapper.ProductMapper;

@Service
public class ProductServiceImpl implements ProductService{
	@Autowired
	ProductMapper productmapper;
	
	
}
