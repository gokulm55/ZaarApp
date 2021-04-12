//
//  ReportViewAPI.swift
//  ZaarApp
//
//  Created by apple on 09/04/21.
//

import Foundation

struct ReportViewAPI {
    private let urlKey = URLString()
    let networkLayer = NetworkLayer()

    private struct URLString{
        let ticketList = "/labour_report/view"
        let inventoryList = "/equipment_report/view"
        
    }
    func getTeamList(apiCode: String, projectCode: String, fromDate: String, toDate: String, success: @escaping (LaborReport) -> (), onError: @escaping (Error) -> ()) {
        let params: [String: Any] = ["api_code": apiCode, "project_code": projectCode, "from_date": fromDate, "to_date": toDate ]
        networkLayer.postRequest(url: networkLayer.apiV1 + urlKey.ticketList, params: params, headers: [networkLayer.requestConstant.contentType: networkLayer.requestConstant.formURLEncode], success: success, onError: onError)
        
    }
    func getInventoryList(apiCode: String, projectCode: String, fromDate: String, toDate: String, success: @escaping (EquipmentReport) -> (), onError: @escaping (Error) -> ()) {
        print("myAPI")
        let params: [String: Any] = ["api_code": apiCode, "project_code": projectCode, "from_date": fromDate, "to_date": toDate ]
        networkLayer.postRequest(url: networkLayer.apiV1 + urlKey.inventoryList, params: params, headers: [networkLayer.requestConstant.contentType: networkLayer.requestConstant.formURLEncode], success: success, onError: onError)
        print("myAPIdata",success)

    }

}

struct LaborReport: Codable {
    let success, error: Int
    let message: [Message]
}

// MARK: - Message
struct Message: Codable {
    let id, status, companyID, projectID: String
    let contractorID, shift, engineerID, place: String
    let work, messageDescription, labours, area: String
    let image, audio, video, createdOn: String
    let updatedOn, isDeleted, firstName, cid: String
    let companyName: String

    enum CodingKeys: String, CodingKey {
        case id, status
        case companyID = "company_id"
        case projectID = "project_id"
        case contractorID = "contractor_id"
        case shift
        case engineerID = "engineer_id"
        case place, work
        case messageDescription = "description"
        case labours, area, image, audio, video
        case createdOn = "created_on"
        case updatedOn = "updated_on"
        case isDeleted = "is_deleted"
        case firstName = "first_name"
        case cid
        case companyName = "company_name"
    }
}

// Equipment Report

struct EquipmentReport: Codable {
    let success, error: Int
    let message: [EquipmentMessage]
}

// MARK: - Message
struct EquipmentMessage: Codable {
    let id, status, companyID, projectID: String
    let contractorID, engineerID, equipment, messageDescription: String
    let type, createdOn, updatedOn, viewStatusByCompany: String
    let isDeleted, firstName, cid, companyName: String

    enum CodingKeys: String, CodingKey {
        case id, status
        case companyID = "company_id"
        case projectID = "project_id"
        case contractorID = "contractor_id"
        case engineerID = "engineer_id"
        case equipment
        case messageDescription = "description"
        case type
        case createdOn = "created_on"
        case updatedOn = "updated_on"
        case viewStatusByCompany = "view_status_by_company"
        case isDeleted = "is_deleted"
        case firstName = "first_name"
        case cid
        case companyName = "company_name"
    }
}

