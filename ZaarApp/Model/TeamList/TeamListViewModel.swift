//
//  TeamListViewModel.swift
//  ZaarApp
//
//  Created by apple on 07/04/21.
//

import Foundation
//
//  TeamViewModel.swift
//  ZaarApp
//
//  Created by apple on 07/04/21.
//

class TeamListViewModel{
    private let apiService = TeamListAPI()
    var UserDetail: [TeamMember] = []
    func getTeamList(apiCode: String, projectCode: String, success: @escaping () -> (), onError: @escaping(String) -> ()){
        apiService.getTeamList(apiCode: apiCode, projectCode: projectCode, success: { (response) in
            if response.success == 1{
                self.UserDetail = response.teamMembers!
                success()
            }else{
                print("error")
            }
        }) { (error) in
            onError(error.localizedDescription)
        }
    }
    
}
