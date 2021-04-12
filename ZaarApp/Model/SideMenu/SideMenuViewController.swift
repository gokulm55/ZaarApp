//
//  SideMenuViewController.swift
//  ZaarApp
//
//  Created by apple on 01/04/21.
//

import UIKit


class SideMenuViewController: UITableViewController{

    //@IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        //tableView.delegate = self
       // tableView.dataSource = self
        
        tableView.backgroundColor = .gray
        
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "menu", for: indexPath) as! SideMenuCell
        cell.menuLabel.text = "Text"
        cell.menuImage.image = #imageLiteral(resourceName: "zaar_logo")
        // Configure the cell..
        return cell
    }
   
    

}

