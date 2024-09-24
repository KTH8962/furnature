package com.example.furnature.controller;

import java.io.IOException;

import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

import com.siot.IamportRestClient.IamportClient;
import com.siot.IamportRestClient.exception.IamportResponseException;
import com.siot.IamportRestClient.request.CancelData;
import com.siot.IamportRestClient.response.IamportResponse;
import com.siot.IamportRestClient.response.Payment;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@RestController
public class PaymentController {
	
	private IamportClient iamportClient;

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
