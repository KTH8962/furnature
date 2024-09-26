package com.example.furnature.controller;

import java.io.IOException;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.example.furnature.dao.PaymentServiceImpl;
import com.google.gson.Gson;
import com.siot.IamportRestClient.IamportClient;
import com.siot.IamportRestClient.exception.IamportResponseException;
import com.siot.IamportRestClient.request.CancelData;
import com.siot.IamportRestClient.response.IamportResponse;
import com.siot.IamportRestClient.response.Payment;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@RestController
public class PaymentController {
	@Autowired
	PaymentServiceImpl paymentService;
	
	private IamportClient iamportClient;
	
	@PostMapping("/payment/test.dox")
	public String editUser(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		System.out.println(map);
		resultMap = paymentService.payment(map);
		return new Gson().toJson(resultMap);		
	}
    ///IamportClient 객체 생성
    public PaymentController() {
        this.iamportClient = new IamportClient("2547521225544270", "m9t32DK2cjfLX6Fo2NUVcAsQySGqEO1GUBbnpXX1mUBHyxUGE0qqiSopsGbPwsSmYyfHjFrYs79ajDuw");
    }

    @PostMapping("/payment/verification/{imp_uid}")
    private IamportResponse<Payment> paymentByImpUid(@PathVariable("imp_uid") String imp_uid) throws IamportResponseException, IOException {
        return iamportClient.paymentByImpUid(imp_uid);
    }
    
    @PostMapping("/payment/cancel/{imp_uid}")
    private IamportResponse<Payment> cancelPaymentByImpUid(@PathVariable("imp_uid") String imp_uid) throws IamportResponseException, IOException {
        return iamportClient.cancelPaymentByImpUid(new CancelData(imp_uid, true));
    }
}
