//
//  LoginAPI.swift
//  ZaarApp
//
//  Created by apple on 26/03/21.
//

import Foundation
struct LoginAPI {
    let networkLayer = NetworkLayer()
    private let urlKey = URLString()
    private struct URLString{
        let login = "/user/login"
        
    }
    func validateUser(email: String, password: String, success: @escaping (LoginResponse) -> (), onError: @escaping(Error) -> ()) {
        let loginParam: [String: Any] = [
            "username": email,
            "password": password,
            "uid": "12345"
        ]
        networkLayer.postRequest(url: networkLayer.apiV1 + urlKey.login, params: loginParam, headers: [networkLayer.requestConstant.contentType: networkLayer.requestConstant.formURLEncode], success: success, onError: onError)
    }
    
}
    struct LoginResponse: Codable {
        let success, error, resendMail: Int?
        let data: LoginDataClass?
        
        public init(success: Int?, error: Int?, resendMail: Int?, data: LoginDataClass?){
            self.success = success
            self.error = error
            self.resendMail = resendMail
            self.data = data
        }

        enum CodingKeys: String, CodingKey {
            case success, error
            case resendMail = "resend_mail"
            case data
        }
    }

    // MARK: - DataClass
    struct LoginDataClass: Codable {
        let firstName, lastName, userType, userID: String?
        let apiCode, gmtTime, companyName: String?

        enum CodingKeys: String, CodingKey {
            case firstName = "first_name"
            case lastName = "last_name"
            case userType = "user_type"
            case userID = "user_id"
            case apiCode = "api_code"
            case gmtTime = "gmt_time"
            case companyName = "company_name"
        }
        public init(firstName: String?, lastName: String?, userType: String?, userID: String?, apiCode: String?, gmtTime: String?, companyName: String?){
            self.firstName = firstName
            self.lastName = lastName
            self.userType = userType
            self.userID = userID
            self.apiCode = apiCode
            self.gmtTime = gmtTime
            self.companyName = companyName
        }
    }
