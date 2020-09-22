//
//  ViewController.swift
//  GoogleAuth
//
//  Created by 신효근 on 2020/09/19.
//

import UIKit
import Firebase
import GoogleSignIn

class ViewController: UIViewController{

    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance()?.presentingViewController = self
        
        handleGoogleSingIn()
    }
    
    private func handleGoogleSingIn(){
        let loginButton = GIDSignInButton()
        view.addSubview(loginButton)
        loginButton.frame = CGRect(x: 16, y: 116+16, width: view.frame.width-32, height: 50)
    }
    
    @IBAction func signOut(button:UIButton){
        let firebaseAuth = Auth.auth()
        do{
            try firebaseAuth.signOut()
            GIDSignIn.sharedInstance()?.disconnect()
        }catch let signOutError as NSError{
           print("Error signing out: @", signOutError)
        }
    }

}

