//
//  HomeSideMenuViewController.swift
//  ZaarApp
//
//  Created by apple on 07/04/21.
//

import UIKit
import SideMenu
enum LeftMenuData: String {
    case TEAM = "TEAM"
    case PHOTOS = "PHOTOS"
    case PLANDOCUMENTS = "PLAN DOCUMENTS"
    case SWITCHPROJECT = "SWITCH PROJECT"
    case LOGOUT = "LOGOUT"
    
}
class HomeSideMenuViewController: UIViewController {

    @IBOutlet weak var homeSideMenuTable: UITableView!
    var leftText: [String] = []
    let leftMenu = [UIImage(systemName: "person.2")?.withTintColor(.white, renderingMode: .alwaysOriginal),
                    UIImage(systemName: "photo.on.rectangle")?.withTintColor(.white, renderingMode: .alwaysOriginal),
                    UIImage(systemName: "doc.on.doc")?.withTintColor(.white, renderingMode: .alwaysOriginal),
                    UIImage(systemName: "arrow.2.circlepath")?.withTintColor(.white, renderingMode: .alwaysOriginal),
                    UIImage(systemName: "arrow.left.circle")?.withTintColor(.white, renderingMode: .alwaysOriginal)]
  
    override func viewDidLoad() {
        super.viewDidLoad()
       
        homeSideMenuTable.delegate = self
        homeSideMenuTable.dataSource = self
        view.backgroundColor = .darkGray
        homeSideMenuTable.backgroundColor = .darkGray
        leftText = ["TEAM","PHOTOS","PLAN DOCUMENTS","SWITCH PROJECT","LOGOUT"]
        // Do any additional setup after loading the view.
    }
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        navigationController?.navigationBar.isHidden = false
//    }
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        navigationController?.navigationBar.isHidden = true
//    }
}
extension HomeSideMenuViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leftMenu.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeSideMenuCell", for: indexPath) as! HomeSideMenuCell
        cell.menuImg.image = leftMenu[indexPath.row]
        cell.menuLabel.text = leftText[indexPath.row]
        cell.backgroundColor = .darkGray
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let leftMenuClick = LeftMenuData(rawValue: leftText[indexPath.row]) else {
            print("not found")
            return
                
        }
        switch leftMenuClick {
        case .TEAM:
            print("Team")
            let secondviewController:UIViewController =  (self.storyboard?.instantiateViewController(withIdentifier: "homeSideMenu") as? TeamViewController)!
            self.navigationController?.pushViewController(secondviewController, animated: true)
        case .PHOTOS:
            print("photos")
        case .PLANDOCUMENTS:
            print("plandocuments")
        case .SWITCHPROJECT:
            print("switch projects")
//            let secondviewController:UIViewController =  (self.storyboard?.instantiateViewController(withIdentifier: "project") as? ProjectListViewController)!
//            self.navigationController?.pushViewController(secondviewController, animated: true)
//            self.dismiss(animated: true, completion: nil)
//            self.dismiss(animated: true, completion: nil)
            
            view.window?.rootViewController?.dismiss(animated: false, completion: nil)
            
//            self.navigationController?.popToRootViewController(animated: true)
//
//            self.dismiss(animated: true) {
//                self.navigationController?.popToRootViewController(animated: true)
//            }
        case .LOGOUT:
            
            print("logout")
       
        }
    }
    
    
}
