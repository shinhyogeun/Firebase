//
//  ViewController.swift
//  Database2
//
//  Created by 신효근 on 2020/09/23.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth
import GoogleSignIn

class ViewController: UIViewController, GIDSignInUIDelegate {

    var ref:DatabaseReference!
    var index:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        handleGoogleLogin()
        
    }
    
    private func handleGoogleLogin(){
        let loginButton = GIDSignInButton()
        GIDSignIn.sharedInstance()?.uiDelegate = self
        view.addSubview(loginButton)
        loginButton.frame = CGRect(x: 16, y: 176, width: self.view.frame.width-32, height: 50)
    }
    
    @IBAction func create(with:UIStoryboardSegue){
        guard let key =
                ref.child("user").child(Auth.auth().currentUser!.uid).child("post")
                .childByAutoId().key else{return}
        
        let post = ["index" : String(self.index),
                    "uid" : Auth.auth().currentUser?.uid,
                    "author" : Auth.auth().currentUser?.email,
                    "title" : "My Dog",
                    "body" : "Dummy Blog Post"]
        
        let childUpdate = ["/users2/\(Auth.auth().currentUser!.uid)/posts/\(key)" : post]
        ref.updateChildValues(childUpdate)
        index += 1
    }
    
    @IBAction func read(with:UIStoryboardSegue){
        
    }
    @IBAction func update(with:UIStoryboardSegue){
        
    }
    @IBAction func delete(with:UIStoryboardSegue){
        
    }
    @IBAction func signOut(with: UIStoryboardSegue){
        GIDSignIn.sharedInstance()?.disconnect()
    }

}

