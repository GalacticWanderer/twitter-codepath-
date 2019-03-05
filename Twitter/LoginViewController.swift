//
//  LoginViewController.swift
//  Twitter
//
//  Created by Joy Paul on 3/4/19.
//  Copyright © 2019 Dan. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        roundsButton()
    }
    
    //name says all
    func roundsButton(){
        loginButton.layer.borderWidth = 1
        loginButton.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        loginButton.layer.cornerRadius = 25
    }
    
    //checks if user already logged in. If key doesn't exit yet, no error will be thrown
    override func viewDidAppear(_ animated: Bool) {
        UserDefaults.standard.bool(forKey: "isLoggedIn") == true ? self.performSegue(withIdentifier: "loginToHome", sender: self) : nil
    }
    
    //makes api call to backend, requests log in and writes to Userdefaults
    @IBAction func loginButton(_ sender: UIButton) {
        let authAPI = "https://api.twitter.com/oauth/request_token"
        TwitterAPICaller.client?.login(url: authAPI, success: {
            print("Success")
            UserDefaults.standard.set(true, forKey: "isLoggedIn")
            self.performSegue(withIdentifier: "loginToHome", sender: self)
        }, failure: { (error) in
            print("Error occoured->> \(error)")
        })
    }
    

}
