//
//  projectListViewModel.swift
//  ZaarApp
//
//  Created by apple on 31/03/21.
//

import Foundation
class productListViewModel{
    private let apiService = projectListAPI()
    var UserBrand: [Project] = []
    func getProductList(apiCode:String,  success: @escaping () -> (), onError: @escaping(String) -> ()){
        apiService.userSearch(apiCode: apiCode, success: { [self] (response) in
            if response.success == 1{
                self.UserBrand = response.projects!
                UserDefaults.standard.setValue(UserBrand[0].code, forKey: "projectList")
                success()
                print("userBrand", UserBrand[0].code)
                
            }else{
                
            }
            
            print("count",response)
        }) { (error) in
            
            onError(error.localizedDescription)
        }
    }
}
