//
//  ViewController.swift
//  ZaarApp
//
//  Created by apple on 26/03/21.
//

import UIKit
import WebKit

class ViewController: UIViewController {

    fileprivate var viewModel: LoginViewModel = LoginViewModel()
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    //Error
    @IBOutlet weak var emalErrorLabel: UILabel!
    @IBOutlet weak var passwordErrorLabel: UILabel!
    //Buttons
    @IBOutlet weak var forgetBtn: UIButton!
    @IBOutlet weak var registerBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        enablePassword()
       
        // Do any additional setup after loading the view
//        emalErrorLabel.isHidden = false
//        passwordErrorLabel.isHidden = false
        passwordErrorLabel.text = "Enter Valid Password"
        emalErrorLabel.text = "Enter valid Email"
        
        self.emailText.text = "vivek.techzar@gmail.com"
        self.passwordText.text = "987654321"
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func submitAction(_ sender: Any) {
        ActivityLoader.show()
        viewModel.validateLoginForm(userName: emailText.text!, password: passwordText.text!, success: {
            ActivityLoader.hide()
            print("success")
            //self.performSegue(withIdentifier: "productList", sender: self)

            let secondviewController:UIViewController =  (self.storyboard?.instantiateViewController(withIdentifier: "project") as? ProjectListViewController)!
            self.navigationController?.pushViewController(secondviewController, animated: true)
            //
            //        self.navigationController?.pushViewController(secondviewController, animated: true)

        }) {(error) in
            print("error1",error)
        }
//        let secondviewController:UIViewController =  (self.storyboard?.instantiateViewController(withIdentifier: "project") as? ProjectListViewController)!
//
//        self.navigationController?.pushViewController(secondviewController, animated: true)
    }
    
    
    @IBAction func forgetAction(_ sender: Any) {
        self.performSegue(withIdentifier: "forgot", sender: self)
        
    }
    
    @IBAction func registerAction(_ sender: Any) {
//        self.performSegue(withIdentifier: "forget", sender: self)
        let VC1 = self.storyboard?.instantiateViewController(withIdentifier: "forget") as! RegisterViewController
        VC1.modalPresentationStyle = .fullScreen
        self.present(VC1, animated:true, completion: nil)

    }
    func enablePassword(){
        passwordText.enablePasswordToggle()
//        emailText.setIcon((UIImage(systemName: "person")?.withRenderingMode(.alwaysOriginal))!)
//        passwordText.setIcon((UIImage(systemName: "lock")?.withRenderingMode(.alwaysOriginal))!)
        
    }
    
    
}
extension UITextField {
fileprivate func setPasswordToggleImage(_ button: UIButton) {
    if(isSecureTextEntry){
        button.setImage(UIImage(systemName: "eye")?.withRenderingMode(.alwaysOriginal), for: .normal)
    }else{
        button.setImage(UIImage(systemName: "eye.slash")?.withRenderingMode(.alwaysOriginal), for: .normal)

    }
}
//
func enablePasswordToggle(){
    let button = UIButton(type: .custom)
    setPasswordToggleImage(button)
    button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -16, bottom: 0, right: 0)
    button.frame = CGRect(x: CGFloat(self.frame.size.width - 25), y: CGFloat(5), width: CGFloat(25), height: CGFloat(25))
    button.addTarget(self, action: #selector(self.togglePasswordView), for: .touchUpInside)
    self.rightView = button
    self.rightViewMode = .always
}
@IBAction func togglePasswordView(_ sender: Any) {
    self.isSecureTextEntry = !self.isSecureTextEntry
    setPasswordToggleImage(sender as! UIButton)
}
    
    
}
