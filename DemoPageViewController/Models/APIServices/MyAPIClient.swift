//
//  MyAPIClient.swift
//  DemoPageViewController
//
//  Created by Đinh Ngọc Vũ on 10/9/18.
//  Copyright © 2018 GEM. All rights reserved.
//

import Foundation
import Alamofire
import Stripe

class MyAPIClient: NSObject, STPEphemeralKeyProvider {
    static var sharedClient: MyAPIClient = {
        let client = MyAPIClient()
        return client
    }()
    var baseURLString: String? = nil
    var baseURL: URL {
        if let urlString = self.baseURLString, let url = URL(string: urlString) {
            return url
        } else {
            fatalError()
        }
    }
    
    func completeCharge(_ result: STPPaymentResult,
                        amount: Int,
                        shippingAddress: STPAddress?,
                        shippingMethod: PKShippingMethod?,
                        completion: @escaping STPErrorBlock) {
        let url = self.baseURL.appendingPathComponent("charge")
        var params: [String: Any] = [
            "source": result.source.stripeID,
            "amount": amount,
            "metadata": [
                // example-ios-backend allows passing metadata through to Stripe
                "charge_request_id": "B3E611D1-5FA1-4410-9CEC-00958A5126CB",
            ],
            ]
        params["shipping"] = STPAddress.shippingInfoForCharge(with: shippingAddress, shippingMethod: shippingMethod)
        Alamofire.request(url, method: .post, parameters: params)
            .validate(statusCode: 200..<300)
            .responseString { response in
                switch response.result {
                case .success:
                    completion(nil)
                case .failure(let error):
                    completion(error)
                }
        }
    }

    
    func createCustomerKey(withAPIVersion apiVersion: String, completion: @escaping STPJSONResponseCompletionBlock) {
        let url = self.baseURL.appendingPathComponent("ephemeral_keys")
        Alamofire.request(url, method: .post, parameters: [
            "api_version": apiVersion,
            "customer_id": "cus_DlWxNEL1kzjX1S"
            ])
            .validate(statusCode: 200..<300)
            .responseJSON { responseJSON in
                switch responseJSON.result {
                case .success(let json):
                    print(json)
                    completion(json as? [String: AnyObject], nil)
                case .failure(let error):
                    completion(nil, error)
                }
        }
    }
}
