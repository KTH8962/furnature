package com.example.furnature.controller;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.example.furnature.dao.ProductService;

@Controller
public class ProductController {
	@Autowired
	ProductService productService;
	
	
	
}
