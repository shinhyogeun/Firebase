//
//  ViewController.swift
//  FacebookAuth
//
//  Created by 신효근 on 2020/09/21.
//

import UIKit
import Firebase
import FBSDKLoginKit

class ViewController: UIViewController, LoginButtonDelegate {
    
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        
        if error == nil{
            if ((result?.isCancelled) != nil){
                return
            }
        }
        
        if let error = error {
            print(error)
            return
        }
        
        let credential = FacebookAuthProvider.credential(withAccessToken: AccessToken.current!.tokenString)
        Auth.auth().signInAndRetrieveData(with: credential) {(authResult, error) in
            if let error = error {
                print("Unable to login to Facebook: error [\(error)]")
                return
            }
            print("Facebook user is signed in \(String(describing: authResult?.user.uid))")
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        let firebaseAuth = Auth.auth()
        do{
            try firebaseAuth.signOut()
        } catch let signOutError as NSError{
            print(signOutError)
        }
        print("안전하게 로그아웃 되었습니다.")
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        handlePrivateLogin()
        if let token = AccessToken.current, !token.isExpired { print("hjk")
        }
    }
    
    private func handlePrivateLogin(){
        let loginButton = FBLoginButton()
        loginButton.delegate = self
        loginButton.permissions = ["public_profile", "email"]
        view.addSubview(loginButton)
        loginButton.frame = CGRect(x: 16, y: 116+60, width: view.frame.width-32, height: 50)
    }

}

