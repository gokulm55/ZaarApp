//
//  HomeViewController.swift
//  ZaarApp
//
//  Created by apple on 05/04/21.
//

import UIKit
import SideMenu

class HomeViewController: UIViewController {

    var sideMenu: SideMenuNavigationController!
    @IBOutlet weak var bacgroundView: UIView!
    var myNavtitle = ""
    
    let countries = ["LABOR","INVENTORY","EQUIPMENT","TASK","REQUIREMENT","EMERGENCY"]
    let images = [UIImage(named: "labour"),
                  UIImage(named: "material"),
                  UIImage(named: "equipment"),
                  UIImage(named: "task"),
                  UIImage(named: "requirements"),
                  UIImage(named: "warning"),]
    @IBOutlet weak var collectionView: UICollectionView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
       

        print("myNav", myNavtitle)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        sideMenuConfig()
//        let width = (view.frame.size.width - 20) / 3
//        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
//        layout.itemSize = CGSize(width: width, height: width)
        self.collectionView?.backgroundColor = UIColor(patternImage: UIImage(named: "bg")!)
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.isHidden = false
       // navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.isTranslucent = true

        let leftBarBtn = UIBarButtonItem(image: UIImage(systemName: "line.horizontal.3"), style: .plain, target: self, action: #selector(menuBarButton))
        let rightBarBtn = UIBarButtonItem(image: UIImage(systemName: "cloud.sun"), style: .plain, target: self, action: #selector(menuBarButton))
        navigationItem.leftBarButtonItem = leftBarBtn
        navigationItem.rightBarButtonItem = rightBarBtn
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    func sideMenuConfig(){
        
        let secondviewController:UIViewController =  (self.storyboard?.instantiateViewController(withIdentifier: "HomeSide") as? HomeSideMenuViewController)!

        //self.navigationController?.pushViewController(secondviewController, animated: true)

        sideMenu = .init(rootViewController: secondviewController)
        SideMenuManager.default.leftMenuNavigationController = sideMenu
        sideMenu.leftSide = true
        sideMenu.statusBarEndAlpha = 0
        //menu.isNavigationBarHidden = true
        sideMenu.menuWidth = view.bounds.width * 0.7
        
        sideMenu.presentationStyle = .menuSlideIn
        //menu.presentationStyle = .viewSlideOutMenuIn

    }
    @objc func menuBarButton(){
        print("home view")
        self.present(sideMenu, animated: true, completion: nil)
       
    }

}
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return countries.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeViewCell", for: indexPath) as! HomeViewCell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeViewCell", for: indexPath) as! HomeViewCell
        cell.homeText.text = countries[indexPath.row]
        cell.homeImage.image = images[indexPath.row]
        
        cell.bgView.layer.borderWidth = 1
        cell.bgView.layer.borderColor = UIColor.systemGray3.cgColor
        cell.bgView.layer.cornerRadius = 40
       
       // cell.bgView.layer.masksToBounds = true;
        return cell
    }
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let cell = collectionView.cellForItem(at: indexPath)
//        self.performSegue(withIdentifier: "reportDetails", sender: cell)
//
//    }
////
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (collectionView.frame.size.width - 10) / 2
        return CGSize(width: size, height: size)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 35, left: 0, bottom: 15, right: 0)
    }
    
   
    
}

