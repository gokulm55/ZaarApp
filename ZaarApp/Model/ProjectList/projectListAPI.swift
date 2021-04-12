//
//  projectListAPI.swift
//  ZaarApp
//
//  Created by apple on 31/03/21.
//

import Foundation
struct projectListAPI {
    let networkLayer = NetworkLayer()
    private let urlKey = URLString()
    private struct URLString{
        let project = "/project/get_projects"
    }
    func userSearch(apiCode: String, success: @escaping (projectListResponse) -> (), onError: @escaping(Error) -> ()){
    let params: [String: Any] = [
        "api_code": apiCode
        ]
        networkLayer.postRequest(url: networkLayer.apiV1 +  urlKey.project, params: params, headers: [networkLayer.requestConstant.contentType: networkLayer.requestConstant.formURLEncode], success: success, onError: onError)

    }
}

struct projectListResponse: Codable {
    let success, error: Int?
    let projects: [Project]?

    public init(success: Int?, error: Int?, projects: [Project]?){
        self.success = success
        self.error = error
        self.projects = projects
    }
    enum CodingKeys: String, CodingKey {
        case success, error
        case projects = "Projects"
    }
}

// MARK: - Project
struct Project: Codable {
    let code, projectName, address, city: String?
    let state, country, updatedOn, unseenTaskCount: String?
    let unseenRequirementCount: String?

    enum CodingKeys: String, CodingKey {
        case code
        case projectName = "project_name"
        case address, city, state, country
        case updatedOn = "updated_on"
        case unseenTaskCount = "unseen_task_count"
        case unseenRequirementCount = "unseen_requirement_count"
    }
    
    public init(code: String?, projectName: String?, address: String?, city: String?, state: String?, country: String?, updatedOn: String?, unseenTaskCount: String?, unseenRequirementCount: String?){
        self.code = code
        self.projectName = projectName
        self.address = address
        self.city = city
        self.state = state
        self.country = country
        self.updatedOn = updatedOn
        self.unseenTaskCount = unseenTaskCount
        self.unseenRequirementCount = unseenRequirementCount
    }
}

