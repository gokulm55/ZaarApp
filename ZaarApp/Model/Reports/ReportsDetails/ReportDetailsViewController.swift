//
//  ReportDetailsViewController.swift
//  ZaarApp
//
//  Created by apple on 12/04/21.
//

import UIKit

class ReportDetailsViewController: UIViewController {

    let images = [UIImage(named: "img1"),
                  UIImage(named: "img2"),
                  UIImage(named: "img3"),
                  UIImage(named: "img4"),
                  UIImage(named: "img5"),
                 ]
    let countries = ["LABOR","INVENTORY","EQUIPMENT","TASK","REQUIREMENT","EMERGENCY"]
    
    @IBOutlet weak var reportCollectionView: UICollectionView!
    @IBOutlet weak var reportTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        reportCollectionView.delegate = self
        reportCollectionView.dataSource = self
    }
    


}
extension ReportDetailsViewController: UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ReportDetailsCollectionCell", for: indexPath) as! ReportDetailsCollectionCell
        cell.reportImg.image = images[indexPath.row]
        cell.reportLabel.text = countries[indexPath.row]
        
        return cell
        
    }
    
    
}
