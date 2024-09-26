package com.example.furnature.dao;

import java.io.IOException;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.siot.IamportRestClient.IamportClient;
import com.siot.IamportRestClient.exception.IamportResponseException;
import com.siot.IamportRestClient.response.IamportResponse;
import com.siot.IamportRestClient.response.Payment;

@Service
public class PaymentServiceImpl implements PaymentService{
	@Value("${imp_key}")
	private static String impKey;

    @Value("${imp_secret}")
    private static String impSecret;
    
    private IamportClient iamportClient;
	
	public PaymentServiceImpl() {
        this.iamportClient = new IamportClient(impKey, impSecret);
    }

	@Override
	public HashMap<String, Object> payment(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		try {
			IamportResponse<Payment> paymentResponse = iamportClient.paymentByImpUid((String)map.get("imp_uid"));
			System.out.println(paymentResponse);
			resultMap.put("payment", paymentResponse);
			//TODO : 처리 로직
		} catch (IamportResponseException e) {
			System.out.println(e.getMessage());
			
			switch(e.getHttpStatusCode()) {
			case 401 :
				//TODO : 401 Unauthorized 
				break;
			case 404 :
				//TODO : imp_123412341234 에 해당되는 거래내역이 존재하지 않음
			 	break;
			case 500 :
				//TODO : 서버 응답 오류
				break;
			}
		} catch (IOException e) {
			//서버 연결 실패
			e.printStackTrace();
		}
		return resultMap;
	}

}
