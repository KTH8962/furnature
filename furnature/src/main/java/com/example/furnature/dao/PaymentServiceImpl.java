package com.example.furnature.dao;

import java.io.IOException;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.siot.IamportRestClient.IamportClient;
import com.siot.IamportRestClient.exception.IamportResponseException;
import com.siot.IamportRestClient.request.CancelData;
import com.siot.IamportRestClient.response.IamportResponse;
import com.siot.IamportRestClient.response.Payment;

import jakarta.annotation.PostConstruct;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class PaymentServiceImpl implements PaymentService{
	@Value("${imp_key}")
	private String impKey;

    @Value("${imp_secret}")
    private String impSecret;
    
    private IamportClient iamportClient;
	
    @PostConstruct
	public void init() {
        this.iamportClient = new IamportClient(impKey, impSecret);
    }

    // 결제
	@Override
	public IamportResponse<Payment>payment(HashMap<String, Object> map) {
		IamportResponse<Payment> paymentResponse = null;
		String imp_uid = (String) map.get("imp_uid");
		try {
			paymentResponse = this.iamportClient.paymentByImpUid(imp_uid);
			//System.out.println(paymentResponse);
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
		return paymentResponse;
	}

	// 결제 취소
	@Override
	public IamportResponse<Payment> cancel(HashMap<String, Object> map) {
		IamportResponse<Payment> paymentResponse = null;
		String imp_uid = (String) map.get("imp_uid");
		try {
			paymentResponse = this.iamportClient.cancelPaymentByImpUid(new CancelData(imp_uid, true));
			//System.out.println(paymentResponse);
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
		return paymentResponse;
	}

}
