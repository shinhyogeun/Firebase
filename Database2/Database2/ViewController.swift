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
        //우리가 데이터를 데이터 베이스에 저장할 위치 만들기위해 키를 생성한다. 그 키자리에 넣을거다.(끝없이 생길 수 있다면! autoId가 필요하다)
        guard let key =
                ref.child("users")
                .childByAutoId().key else{
                    return
                }
        // post는 저장할 데이터의 구조이다.
        let post = ["index" : String(self.index),
                    "uid" : Auth.auth().currentUser?.uid,
                    "author" : Auth.auth().currentUser?.email,
                    "title" : "My Dog",
                    "body" : "Dummy Blog Post"]
        //[위치:무엇을]
        let childUpdate = ["/users/\(Auth.auth().currentUser!.uid)/posts3/\(key)" : post,
                           "/users/posts2/\(key)" : post]
        //저장해라!
        ref.updateChildValues(childUpdate)
        index += 1
    }
    
    @IBAction func read(with:UIStoryboardSegue){
        let postRef : DatabaseQuery! = ref.child("users").child(Auth.auth().currentUser!.uid).child("posts").queryOrdered(byChild: "/index")
        postRef.observeSingleEvent(of: DataEventType.value) { (snapshot, key) in
            let group = DispatchGroup()
            let children : NSEnumerator = snapshot.children
            group.enter()
            for (child) in children {
                let childSnapShot = child as? DataSnapshot
                let childPost : NSDictionary = (childSnapShot?.value as? NSDictionary)!
                print("CHILD KEY: [\(childSnapShot?.key ?? "")]")
                for (key, value) in childPost{
                    print("\(key) : \(value) \n")
                }
            }
            group.leave()
            group.notify(queue: .main){
            }
        }
        
    }
    @IBAction func update(with:UIStoryboardSegue){
        let postRef : DatabaseReference! = ref.child("users").child(Auth.auth().currentUser!.uid).child("posts")
        postRef.observeSingleEvent(of: DataEventType.value) { (snapshot, key) in
            let group = DispatchGroup()
            let childCount : NSEnumerator = snapshot.children
            var count : Int = 0
            group.enter()
            for (_) in childCount{
                count += 1
            }
            
            let children : NSEnumerator = snapshot.children
            for (child) in children{
                count -= 1
                let childSnapShot = child as? DataSnapshot
                postRef.child(childSnapShot!.key).child("index").setValue(String(count))
            }
            
            group.leave()
            group.notify(queue: .main){
                
            }
            
            
            
            
            
            
        }
        
    }
    @IBAction func delete(with:UIStoryboardSegue){
        
    }
    @IBAction func signOut(with: UIStoryboardSegue){
        GIDSignIn.sharedInstance()?.disconnect()
    }

}

