//
//  LoginViewModel.swift
//  ZaarApp
//
//  Created by apple on 26/03/21.
//

import Foundation
import UIKit
struct LoginViewModel {
    private let apiService = LoginAPI()
    
    func validateLoginForm(userName: String, password: String, success: @escaping () -> (), onError: @escaping(String) ->()) {
        apiService.validateUser(email: userName, password: password, success: { (response) in
            print("userid",response.data?.apiCode)
            print("response", response)
            if let token = response.data?.apiCode, !token.isEmpty {
                self.saveUserInfo(info: response)
                success()
            } else {
               print("error")
            }
        }) { (error) in
            onError(error.localizedDescription)
            print("error",error)
        }
    }
    private func saveUserInfo(info: LoginResponse) {
        DefaultStorage.instance.saveToken(token: info.data?.apiCode ?? "")
        DefaultStorage.instance.saveUserInfo(user: info)
        UserService.instance.authToken = info.data?.apiCode ?? ""
        UserService.instance.user = DefaultStorage.instance.getUserInfo()
        UserService.instance.userId = info.data?.userID
    }
    
}

//   user.name = defaults.string(forKey: DefaultKeys.User.name) ?? ""
struct UserInfo {
    var firstName = ""
    var lastName = ""
    var phone = ""
    var userType = 0
    var userId = 0
    var apiCode = 0
    
}
