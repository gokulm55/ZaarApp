//
//  EmailVerifyViewController.swift
//  ZaarApp
//
//  Created by apple on 08/04/21.
//

import UIKit

class EmailVerifyViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func resetPasswordAction(_ sender: Any) {
    }
    
    @IBAction func backAction(_ sender: Any) {
      dismiss(animated: true, completion: nil)
    }
}
