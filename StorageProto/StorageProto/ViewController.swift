//
//  ViewController.swift
//  StorageProto
//
//  Created by 신효근 on 2020/10/05.
//

import UIKit
import GoogleSignIn

class ViewController: UIViewController,GIDSignInUIDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        handleGoogleLogin()
    }

    private func handleGoogleLogin(){
        let loginButton = GIDSignInButton()
        GIDSignIn.sharedInstance()?.uiDelegate = self
        view.addSubview(loginButton)
        loginButton.frame = CGRect(x: 16, y: 176, width: view.frame.width - 32, height: 50)
    }
    
    @IBAction func signOut(with : UIStoryboardSegue){
        GIDSignIn.sharedInstance()?.disconnect()
    }

    
    @IBAction func upload(_ sender: UIButton) {
        
    }
    
    @IBAction func download(_ sender: UIButton) {
        
    }
    
}

