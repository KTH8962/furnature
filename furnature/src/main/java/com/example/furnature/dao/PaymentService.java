package com.example.furnature.dao;

import org.springframework.stereotype.Service;

import com.siot.IamportRestClient.IamportClient;

@Service
public class PaymentService {
	
	private static final String API_KEY = "2547521225544270";
    private static final String API_SECRET = "m9t32DK2cjfLX6Fo2NUVcAsQySGqEO1GUBbnpXX1mUBHyxUGE0qqiSopsGbPwsSmYyfHjFrYs79ajDuw";
    private IamportClient iamportClient;
	
	public PaymentService() {
        this.iamportClient = new IamportClient(API_KEY, API_SECRET);
    }

}
