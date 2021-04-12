//
//  SideDrawerVC.swift
//  ZaarApp
//
//  Created by apple on 01/04/21.
//

import UIKit
import SideMenu
import WebKit
import SafariServices
enum LeftMenuItems: String {
    case FAQ = "FAQ"
    case SETTINGS = "SETTINGS"
    case LOGOUT = "LOGOUT"
    
}
class SideDrawerVC: UIViewController,UITableViewDelegate, UITableViewDataSource {
   
    let webView = WKWebView()
    @IBOutlet weak var tableMenu: UITableView!
    
    var leftMenuImage = [UIImage(systemName: "questionmark.circle")?.withTintColor(.white, renderingMode: .alwaysOriginal),
                         UIImage(systemName: "gear")?.withTintColor(.white,renderingMode: .alwaysOriginal),
                         UIImage(systemName: "arrow.left.circle")?.withTintColor(.white,renderingMode: .alwaysOriginal)]
    var leftMenu: [String] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .darkGray
        leftMenu = ["FAQ","SETTINGS","LOGOUT"]
        tableMenu.delegate = self
        tableMenu.dataSource = self
       
        // Do any additional setup after loading the view.
    }
    
    
   
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leftMenu.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.backgroundColor = .darkGray
        let cell = tableMenu.dequeueReusableCell(withIdentifier: "sideMenu", for: indexPath) as! SideMenuCell
        
//        let lblTitle : UILabel = cell.contentView.viewWithTag(101) as! UILabel
//        let imgIcon : UIImageView = cell.contentView.viewWithTag(100) as! UIImageView
//
//         imgIcon.image = UIImage(systemName: "gear")
//        lblTitle.text = "MyText"
        cell.backgroundColor = .darkGray
        cell.textTitle.text = leftMenu[indexPath.row]
        cell.img.image = leftMenuImage[indexPath.row]
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let leftMenuItem = LeftMenuItems(rawValue: leftMenu[indexPath.row]) else {
            print("not found")
            return
        }
        switch leftMenuItem {
        case .FAQ:
           let vc = WebViewController()
            //vc.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(vc, animated: true)
            //self.present(vc, animated: true, completion: nil)
            
           
//            let secondviewController:UIViewController =  (self.storyboard?.instantiateViewController(withIdentifier: "forget") as? WebViewController)!
//
//            self.navigationController?.pushViewController(WebViewController(), animated: true)
            //performSegue(withIdentifier: "webView", sender: self)
            print("faq")
        case .SETTINGS:
            print("settings")
        case .LOGOUT:
            print("logout")
            guard let LoginView = storyboard?.instantiateViewController(withIdentifier: "login") as? ViewController else {return}
            LoginView.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(LoginView, animated: true)
            UserService.instance.logout()
      
        }
        
    }
    
   

}
