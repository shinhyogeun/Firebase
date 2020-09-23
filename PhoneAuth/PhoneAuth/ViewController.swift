//
//  ViewController.swift
//  PhoneAuth
//
//  Created by 신효근 on 2020/09/22.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        handlePhoneVerificationLogin()
        
    }

    private func handlePhoneVerificationLogin(){
        let loginButton = UIButton()
        loginButton.backgroundColor = .red
        loginButton.setTitle("hihi", for: [])
        loginButton.addTarget(self, action: #selector(self.loginPhoneNumber(loginButton:)), for: UIControl.Event.touchUpInside)
        view.addSubview(loginButton)
        loginButton.frame = CGRect(x: 16, y: 116, width: view.frame.width-32, height: 50)
        
    }
    @IBAction func loginPhoneNumber(loginButton:UIButton){
        self.performSegue(withIdentifier: "EmailLinkSignIn", sender: nil)
    }
    
    @IBAction func verifyAndSignInPhone(segue:UIStoryboardSegue){
        let phoneVerifyController = segue.source as! PhoneNumberVerifyViewController
        let verificationCode:String = phoneVerifyController.verificationId.text!
        guard let verificationID = UserDefaults.standard.string(forKey: "authVerificationID") else { return print("여기가 이상해") }
        
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: verificationID, verificationCode: verificationCode)
        
        Auth.auth().signIn(with: credential) { (authResult, error) in
            if let error = error {
                print("Unable to login with Phone : error[\(error)]")
                return
            }
            print("Phone Number user is signed in \(String(describing: authResult?.user.uid)))")
        }
    }

}

