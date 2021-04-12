//
//  RegisterViewController.swift
//  ZaarApp
//
//  Created by apple on 29/03/21.
//

import UIKit
import SideMenu

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var firstNameText: UITextField!
    
    @IBOutlet weak var lastNameText: UITextField!
    
    @IBOutlet weak var passwordText: UITextField!
    
    
    @IBOutlet weak var phoneText: UITextField!
    
    @IBOutlet weak var companyText: UITextField!
    
    @IBOutlet weak var countryText: UITextField!
    

    @IBOutlet weak var checkImage: UIImageView!
    
    
    @IBOutlet weak var registerButton: UIButton!
    
    var isChecked = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textProperties()
        
        let CheckImage = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
            checkImage.isUserInteractionEnabled = true
            checkImage.addGestureRecognizer(CheckImage)
        
//        checkButton.backgroundColor = .white
//        checkButton.setImage(UIImage(systemName: "checkmark"), for: UIControl.State.selected)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
        navigationController?.hidesBarsOnSwipe = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @objc func imageTapped() {
       // open your camera controller here
        print("tapped")
        print("tapped")
        if isChecked {
            checkImage.image = UIImage(named: "check-box")
            print("true")
        }else{
            checkImage.image = UIImage(named: "blank-check-box")
            print("false")
        }
        
        isChecked = !isChecked
     }
  
   
    @IBAction func registerBtnAction(_ sender: Any) {
    }
    func textProperties(){
        emailText.placeHolderTextColor = .white
        firstNameText.placeHolderTextColor = .white
        lastNameText.placeHolderTextColor = .white
        passwordText.placeHolderTextColor = .white
        phoneText.placeHolderTextColor = .white
        companyText.placeHolderTextColor = .white
        countryText.placeHolderTextColor = .white
    }
    @IBAction func signInButton(_ sender: Any) {
        
        print("tappedbtn")
        self.dismiss(animated: true, completion: nil)
        
    }
}
