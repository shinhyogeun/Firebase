//
//  PhoneNumberLogInViewController.swift
//  PhoneAuth
//
//  Created by 신효근 on 2020/09/23.
//

import UIKit
import FirebaseAuth
class PhoneNumberLogInViewController: UIViewController {
    @IBOutlet weak var phone: UITextField!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
// Do any additional setup after loading the view.
    }
    @IBAction func verifyPhoneNumber(sender:UIButton){
        print("about to verify phone")
        PhoneAuthProvider.provider().verifyPhoneNumber(phone.text!, uiDelegate: nil) { (verificationID, error) in
            print("verify completion invoked")
            if let error = error{
                print(error)
                return
            }
            print("verify phone")
            UserDefaults.standard.set(verificationID, forKey: "authVerificationID")
            
            self.performSegue(withIdentifier: "PhoneVerification", sender: nil)
        }
    }
}
