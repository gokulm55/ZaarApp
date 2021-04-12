//
//  UserService.swift
//  ZaarApp
//
//  Created by apple on 26/03/21.
//

import Foundation
struct UserService {
    static var instance = UserService()
    var authToken: String = ""
    var backGround: String = ""
    var user: UserInfo?
    var apiCode: String = ""
    var image: String?
    var userId: String?
    var BgImage: String?
    var isUserLoggedIn: Bool {
        return !authToken.isEmpty
    }
    private init() {
        authToken = DefaultStorage.instance.getToken()
    }
    mutating func logout(){
       
        authToken = ""
        DefaultStorage.instance.removeAll()
        NetworkLayer.defaultController.deletingLocalCacheAttachments()
        
        
        
    }
}
