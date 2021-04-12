//
//  ProjectListViewController.swift
//  ZaarApp
//
//  Created by apple on 31/03/21.
//

import UIKit
import SideMenu

class ProjectListViewController: UIViewController {
    
    var menu: SideMenuNavigationController!
    var segueNavText = ""
    @IBOutlet weak var projectTableView: UITableView!
    fileprivate let viewModel: productListViewModel = productListViewModel()
    lazy var footerView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .red
        return view
    }()
    
   
   
    override func viewDidLoad() {
        super.viewDidLoad()
        projectTableView.reloadData()
        sideMenuConfig()
        projectTableView.backgroundColor = UIColor(patternImage: UIImage(named: "bg")!)
        let id = UserService.instance.authToken
        print("myid",id)
        let list = viewModel.UserBrand.count
        print("myproject",list)
        projectTableView.delegate = self
        projectTableView.dataSource = self
       
        viewModel.getProductList(apiCode: id, success: {
            print("data", self.viewModel.UserBrand.count)
            self.projectTableView.reloadData()
            
        }) { (Error) in
            
        }
        
        // Do any additional setup after loading the view.
    }
    
    func sideMenuConfig(){
        
        let secondviewController:UIViewController =  (self.storyboard?.instantiateViewController(withIdentifier: "side") as? SideDrawerVC)!

        //self.navigationController?.pushViewController(secondviewController, animated: true)

        menu = .init(rootViewController: secondviewController)
        SideMenuManager.default.leftMenuNavigationController = menu
        menu.leftSide = true
        menu.statusBarEndAlpha = 0
        //menu.isNavigationBarHidden = true
        menu.menuWidth = view.bounds.width * 0.7
        
        menu.presentationStyle = .menuSlideIn
        //menu.presentationStyle = .viewSlideOutMenuIn

    }
    @objc func menuBarButton(){
       
        self.present(menu, animated: true, completion: nil)

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
       // navigationItem.title = "sample Project"
        let leftBarBtn = UIBarButtonItem(image: UIImage(systemName: "sidebar.left"), style: .plain, target: self, action: #selector(menuBarButton))
        navigationItem.leftBarButtonItem = leftBarBtn
        let rightBarBtn = UIBarButtonItem(image: (UIImage(systemName: "plus")), style: .plain, target: self, action: #selector(addAction))
        navigationItem.rightBarButtonItem = rightBarBtn
      
        projectTableView.tableFooterView = footerView
        
        
    }
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        navigationController?.navigationBar.isHidden = true
//    }
    @objc func addAction(){
        print("add action")
        
        let alert = UIAlertController(title: "PROJECT GUIDE", message: "Lauching this missile will destroy the entire universe. Is this what you intended to do?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Create Project", style: .default, handler: {_ in
            print("create project")
            let vc = CreateProjectViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }))
        alert.addAction(UIAlertAction(title: "Don't show again", style: .default, handler: {_ in
            print("dont show again")
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: {_ in
            print("cancel")
        }))
        self.present(alert, animated: true, completion: nil)
        
    }
    
   
    
    @IBAction func createProject(_ sender: Any) {
        print("create project")
    }
}
extension ProjectListViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.UserBrand.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ProjectListCell
        
        let data = viewModel.UserBrand[indexPath.row]
        
        cell.projectTitle.text = data.projectName
        cell.projectDiscription.text = data.city
        
       //

        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        segueNavText = "mydata"
        performSegue(withIdentifier: "HomeView", sender: self)
        
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "HomeView" {
            if let destinationVC = segue.destination as? HomeViewController {
                destinationVC.myNavtitle = segueNavText
            }
        }
    }
    
}
