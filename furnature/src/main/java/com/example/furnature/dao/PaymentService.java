package com.example.furnature.dao;

import java.util.HashMap;

import com.siot.IamportRestClient.response.IamportResponse;
import com.siot.IamportRestClient.response.Payment;

public interface PaymentService {
	// 결제
	IamportResponse<Payment> payment(HashMap<String, Object> map);
	// 결제 취소
	IamportResponse<Payment> cancel(HashMap<String, Object> map);
}
