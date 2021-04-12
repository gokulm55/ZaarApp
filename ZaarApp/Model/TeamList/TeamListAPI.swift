//
//  TeamListAPI.swift
//  ZaarApp
//
//  Created by apple on 07/04/21.
//

import Foundation

struct TeamListAPI {
    private let urlKey = URLString()
    let networkLayer = NetworkLayer()

    private struct URLString{
        let ticketList = "/project/get_team"
    }
    func getTeamList(apiCode: String, projectCode: String, success: @escaping (TeamList) -> (), onError: @escaping (Error) -> ()) {
        let params: [String: Any] = ["api_code": apiCode, "project_code": projectCode ]
        networkLayer.postRequest(url: networkLayer.apiV1 + urlKey.ticketList, params: params, headers: [networkLayer.requestConstant.contentType: networkLayer.requestConstant.formURLEncode], success: success, onError: onError)
        
    }
}
struct TeamList: Codable {
    let success, error: Int?
    let teamMembers: [TeamMember]?
    let teamCheck: Int?

    enum CodingKeys: String, CodingKey {
        case success, error
        case teamMembers = "team_members"
        case teamCheck = "team_check"
    }
}

// MARK: - TeamMember
struct TeamMember: Codable {
    let userType, firstName, lastName, phone: String?
    let email, designation, updatedOn: String?

    enum CodingKeys: String, CodingKey {
        case userType = "user_type"
        case firstName = "first_name"
        case lastName = "last_name"
        case phone, email, designation
        case updatedOn = "updated_on"
    }
}
