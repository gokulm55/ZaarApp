//
//  ReportViewModel.swift
//  ZaarApp
//
//  Created by apple on 09/04/21.
//

import Foundation
class ReportViewModel{
    private let apiService = ReportViewAPI()
    var ReportList: [Message] = []
    var Equipment: [EquipmentMessage] = []
    
    func getReportList(apiCode: String, projectCode: String, fromDate: String, toDate: String, success: @escaping () -> (), onError: @escaping(String) -> ()){
        apiService.getTeamList(apiCode: apiCode, projectCode: projectCode, fromDate: fromDate, toDate: toDate, success: { (response) in
            if response.success == 1{
                self.ReportList = response.message
                print("model",self.ReportList.count)
                success()
            } else {
                print("error")
            }
        }) { (error) in
            onError(error.localizedDescription)
        }
    }
//    func getInventoryList(apiCode: String, projectCode: String, fromDate: String, toDate: String, success: @escaping () -> (), onError: @escaping(String) -> ()){
//        apiService.getInventoryList(apiCode: apiCode, projectCode: projectCode, fromDate: fromDate, toDate: toDate, success: { (response) in
//            print("myresponse")
//            if response.success == 1{
//                self.Equipment = response.equipmentReport
//                print("model",self.Equipment.count)
//                success()
//            } else {
//                print("error")
//            }
//        }) { (error) in
//            onError(error.localizedDescription)
//        }
//    }
    
    func getInventoryDataList(apiCode: String, projectCode: String, fromDate: String, toDate: String, success: @escaping () -> (), onError: @escaping(String) -> ()){
        apiService.getInventoryList(apiCode: apiCode, projectCode: projectCode, fromDate: fromDate, toDate: toDate, success: { (response) in
            print(response)
            if response.success == 1{
                self.Equipment = response.message
                print("model", self.Equipment.count)
                success()
            }
            
        }) {(error) in
            print("model Error",error)
            onError.self(error.localizedDescription)
        }
    }
}
