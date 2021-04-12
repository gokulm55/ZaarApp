//
//  DefaultStorage.swift
//  ZaarApp
//
//  Created by apple on 31/03/21.
//


import Foundation

struct DefaultStorage {
    static let instance = DefaultStorage()
    
    struct DefaultKeys {
        struct User {
            
            static let firstName = "first_name"
            static let lastName = "last_name"
            static let userType = "user_type"
            static let userId = "user_id"
            static let apiCode = "api_code"
            static let getTime = "get_time"
            static let companyName = "company_name"
           
        }
    }
  
    private var defaults: UserDefaults
    
    private init() {
        defaults = UserDefaults.standard
    }
    
    func saveToken(token: String) {
        setValue(value: token, key: DefaultKeys.User.apiCode)
    }
    
    func getToken() -> String {
        return defaults.string(forKey: DefaultKeys.User.apiCode) ?? ""
    }
    func saveUserInfo(user: LoginResponse) {
        setValue(value: user.data?.firstName, key: DefaultKeys.User.firstName)
        setValue(value: user.data?.lastName, key: DefaultKeys.User.lastName)
        setValue(value: user.data?.userType, key: DefaultKeys.User.userType)
        setValue(value: user.data?.userID, key: DefaultKeys.User.userId)
        setValue(value: user.data?.apiCode, key: DefaultKeys.User.apiCode)
        setValue(value: user.data?.gmtTime, key: DefaultKeys.User.getTime)
        setValue(value: user.data?.companyName, key: DefaultKeys.User.companyName)
    }
    
    func getUserInfo() -> UserInfo {
        var user = UserInfo()
        user.firstName = defaults.string(forKey: DefaultKeys.User.firstName) ?? ""
        user.lastName = defaults.string(forKey: DefaultKeys.User.lastName) ?? ""
        user.lastName = defaults.string(forKey: DefaultKeys.User.lastName) ?? ""
        user.userType = defaults.integer(forKey: DefaultKeys.User.userType)
        user.userId = defaults.integer(forKey: DefaultKeys.User.userId)
        return user
    }
    
    func removeAll() {
        let keys = Array(defaults.dictionaryRepresentation().keys)
        let restoreKeys: [String] = [] // Add keys that should be retained after logout
        for key in keys {
            if !restoreKeys.contains(key) {
                defaults.removeObject(forKey: key)
            }
        }
    }
    
    fileprivate func setValue(value: Any?, key: String) {
        defaults.set(value, forKey: key)
        defaults.synchronize()
    }
    
}
