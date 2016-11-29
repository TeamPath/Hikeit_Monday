//
//  LoginViewController.swift
//  Hikeit2
//
//  Created by Will Carty on 11/23/16.
//  Copyright © 2016 Andrew Noble. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import GoogleSignIn

class LoginViewController: UIViewController, GIDSignInUIDelegate {
    
    var ref: FIRDatabaseReference!
    var navBar: UINavigationBar = UINavigationBar()
    
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var signInButton: UIButton!

    
    @IBOutlet weak var GooglesignInButton: GIDSignInButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavBarToTheView()
        
        ref = FIRDatabase.database().reference()
        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "Artboard 1.png")
        self.view.insertSubview(backgroundImage, at: 0)
        
        GIDSignIn.sharedInstance().uiDelegate = self
        
        // Uncomment to automatically sign in the user.
        GIDSignIn.sharedInstance().signInSilently()
        
        //TODO(developer) Configure the sign-in button look/feel
        GooglesignInButton.colorScheme = GIDSignInButtonColorScheme.dark
        GooglesignInButton.style = GIDSignInButtonStyle.iconOnly
    }
    
    @IBAction func signInTouchUpIn(_ sender: Any) {
        let alert = UIAlertController(title: "Error", message: "Houston we have a problem", preferredStyle: .alert)
      
        FIRAuth.auth()?.signIn(withEmail: emailField.text!, password: passwordField.text!, completion: { (user, error) in
            if error != nil {
                print(error!.localizedDescription)
                alert.addAction(UIAlertAction(title: "Try again", style: .default, handler: {(alert: UIAlertAction!) in print("Testing")}))
               
                self.present(alert, animated: true, completion: nil)
            } else {
                print("User Logged in..")
             self.performSegue(withIdentifier: "LoggedInSegue", sender: self)
            }
        })
    
    }
    func setNavBarToTheView() {
        self.navBar.frame = CGRect(x: 0.0, y: 0.0, width: 320.0, height: 0.0)  // Here you can set you Width and Height for your navBar
        self.navBar.backgroundColor = (UIColor.black)
        self.view.addSubview(navBar)
    }
}


