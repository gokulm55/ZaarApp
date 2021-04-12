//
//  TeamViewController.swift
//  ZaarApp
//
//  Created by apple on 07/04/21.
//

import UIKit
import MessageUI

class TeamViewController: UIViewController, MFMessageComposeViewControllerDelegate, MFMailComposeViewControllerDelegate {
    

    @IBOutlet weak var teamTableView: UITableView!
    let viewModel: TeamListViewModel = TeamListViewModel()
    let productlist: productListViewModel = productListViewModel()
    let mylist =  UserDefaults.standard.value(forKey: "projectList")
    let id = UserService.instance.authToken
    var mobile: String?
    var callTag: String?
  
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        teamTableView.delegate = self
        teamTableView.dataSource = self
        UINavigationBar.appearance().tintColor = .white
        
        //ActivityLoader.show()
        
        // Do any additional setup after loading the view.
        fetchData {
            DispatchQueue.main.async {
                self.teamTableView.reloadData()
            }
           
        }
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    func fetchData(compliton: @escaping () -> Void){
        viewModel.getTeamList(apiCode: id, projectCode: mylist as! String, success: {
            compliton()
        }){ (error) in
            
            print(error)
        }
    }
    
        
}
extension TeamViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.UserDetail.count

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TeamViewCell", for: indexPath) as! TeamViewCell
        
        let data = viewModel.UserDetail[indexPath.row]
        print("all data",data)
        cell.nameLabel.text = data.firstName! + data.lastName!
        cell.discriptionLabel.text = data.designation
        cell.mailIdLabel.text = data.email
        
        cell.messageButton.tag = indexPath.row
        cell.callButton.tag = indexPath.row
    
        cell.messageButton.addTarget(self, action: #selector(messageAction(_:)), for: .touchUpInside)
        cell.callButton.addTarget(self, action: #selector(callAction(_:)), for: .touchUpInside)
        return cell
       
    }
    @objc func messageAction(_ sender: UIButton){
        let indexpath = IndexPath(row: sender.tag, section: 0)
        let cell = teamTableView.cellForRow(at: indexpath) as! TeamViewCell
        let message = viewModel.UserDetail[indexpath.row].email
        if sender == cell.messageButton{
            print("message",message!)
            
            if MFMailComposeViewController.canSendMail() {
                let mail = MFMailComposeViewController()
                mail.mailComposeDelegate = self
                mail.setToRecipients([message!])
                mail.setMessageBody("<p>Awesome tutorial!</p>", isHTML: true)
                
                present(mail, animated: true)
                
            }
        }
        
        
    }
    
    @objc func callAction(_ sender: UIButton){
        let indexPath = IndexPath(row: sender.tag, section: 0)
        let cell = teamTableView.cellForRow(at: indexPath) as! TeamViewCell
        let phoneno = viewModel.UserDetail[indexPath.row].phone
        if sender == cell.callButton{
            print("phone",phoneno!)
            print("cell",sender.tag)
            if let url = URL(string: "tel://\(phoneno ?? "")"),
            UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
        
       
        
       
    }
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        controller.dismiss(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
}
