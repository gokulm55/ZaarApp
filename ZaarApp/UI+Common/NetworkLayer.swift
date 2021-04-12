//
//  NetworkLayer.swift
//  ZaarApp
//
//  Created by apple on 26/03/21.
//

import Foundation
import Alamofire

struct NetworkLayer {
    
    struct APIStrings {
        let projectName = "Zaar"
        let noInternet = "Internet unavailable"
        let invalidData = "Invalid Dataa"
        let serialization = "Unable to serialize Data"
        let responseError = "Unknown error occured"
        let successMessage = "Response successful"
    }
    struct RequestConstants {
        let contentType = "Content-Type"
        let formURLEncode = "application/x-www-form-urlencoded"
        let multiPartForm = "multipart/form-data"
        let accept = "Accept"
        let applicationJSON = "application/json"
        let authorization = "Authorization"
        let deviceType = "deviceType"
        let device = "iOS"
    }
    struct ErrorCode {
        let serialization = 1001
        let responseError = 1002
    }
    
   // http://demo.techzarinfo.com/zaarapp/console/api/user/login
   // let baseURL: String = "https://dashboard.netwoglobal.com/"
    let baseURL: String = "https://console.zaarapp.com/"
    let apiV1: String = "api"
    let apiString = APIStrings()
    let errorCode = ErrorCode()
    let requestConstant = RequestConstants()
    static var defaultController = NetworkLayer()
    //login
    func postRequest<T: Codable>(url:String, params: [String: Any]? = nil, headers: [String: String]? = nil ,success: @escaping (T) -> (), onError: @escaping(Error) -> ()) {
        self.isInternetAvailable(available: {
            
            let url = self.baseURL + url
            
           // var defaultHeaders: [String : String] = [requestConstant.accept:requestConstant.applicationJSON]
            let customHeaders: HTTPHeaders = [requestConstant.accept:requestConstant.applicationJSON]
            AF.request(url, method: .post, parameters: params, headers: customHeaders).responseJSON { (responseData) in
                self.responseData(responseData: responseData, success: success, onError: onError)
                print("res",url)
            }
        }, onError: onError)
    }
    //get Product list
//    func postRequest<T: Codable>(url: String, params: [String: Any]? = nil, headers: [String: String]? = nil, success: @escaping (T) -> (), onError: @escaping(Error) -> ()){
//
//        self.isInternetAvailable(available: {
//            let url = self.baseURL + url
//            let customHeaders: HTTPHeaders = [requestConstant.accept:requestConstant.applicationJSON]
//            AF.request(url, method: .post, parameters: params, headers: customHeaders).responseJSON{ (responseData) in
//                self.responseData(responseData: responseData, success: success, onError: onError)
//            }
//
//            
//        }, onError: onError)
//    }
    
    
    func getCustomHeader(headers: [String: String]? = nil) -> [String : String] {
        let token = UserService.instance.authToken
        var defaultHeaders: [String : String] = [requestConstant.accept:requestConstant.applicationJSON]
        if !token.isEmpty {
            defaultHeaders[requestConstant.authorization] = "Bearer \(token)"
            // defaultHeaders[requestConstant.deviceType] = requestConstant.device
        }
        if let header = headers {
            for (key,value) in header {
                defaultHeaders[key] = value
            }
        }
        return defaultHeaders
    }
    fileprivate func responseData<T: Codable>(responseData: AFDataResponse<Any>, success: @escaping (T) -> (), onError: @escaping(Error) -> ()) {
        
        print("Response result:", responseData.result)
        print("Response datassss:", responseData.data )
        print("Error :", responseData.result )
        if let data = responseData.data {
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .formatted(DateFormatter.iso8601Full)
                let genericModel = try decoder.decode(T.self, from: data)
                success(genericModel)
            } catch let error {
                print(error)
                onError(self.getSerializationError())
            }
        } else if let error = responseData.error {
            onError(error)
        } else {
            onError(self.getInvalidData())
        }
    }
    
    fileprivate func isInternetAvailable(available: @escaping () -> (), onError: @escaping(Error) -> ()) {
        if let isInternetAvailable = try? Reachability().isReachable , isInternetAvailable {
            available()
        } else {
            onError(self.getError(code: URLError.Code.notConnectedToInternet.rawValue, message:  apiString.noInternet))
        }
    }
    func getSerializationError() -> Error {
        return self.getError(code: errorCode.serialization, message: apiString.serialization)
    }
    func getInvalidData() -> Error {
        return self.getError(code: URLError.Code.badServerResponse.rawValue, message: apiString.invalidData)
    }
    
    func getResponseError(message: String?) -> Error {
        return self.getError(code: errorCode.responseError, message: message ??  apiString.responseError)
    }
    
    fileprivate func getError(code: Int, message: String) -> Error {
        return NSError(domain:apiString.projectName, code:code, userInfo:[NSLocalizedDescriptionKey: message])
    }
    func deletingLocalCacheAttachments(){
        let fileManager = FileManager.default
        let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        do {
            let fileURLs = try fileManager.contentsOfDirectory(at: documentsURL, includingPropertiesForKeys: nil)
            if fileURLs.count > 0{
                for fileURL in fileURLs {
                    try fileManager.removeItem(at: fileURL)
                }
            }
        } catch {
            print("Error while enumerating files \(documentsURL.path): \(error.localizedDescription)")
        }
    }
    

}
extension DateFormatter {
    static let iso8601Full: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        return formatter
    }()
}
