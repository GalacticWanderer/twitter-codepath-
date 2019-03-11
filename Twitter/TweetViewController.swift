//
//  TweetViewController.swift
//  Twitter
//
//  Created by Joy Paul on 3/11/19.
//  Copyright © 2019 Dan. All rights reserved.
//

import UIKit

class TweetViewController: UIViewController {
    
    @IBOutlet weak var scrollTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollTextView.becomeFirstResponder()
    }
    
    @IBAction func onCancel(_ sender: UIBarButtonItem) {
        navigationController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func submitTweet(_ sender: UIBarButtonItem) {
        scrollTextView.text.isEmpty ? displayAlert(title: "Text field is empty!", message: "Need some texts to post a tweet.") : postATweet(with: scrollTextView.text)
    }
    
    //func that communicates with TwitterAPICaller class to post a twwet to the api
    func postATweet(with tweetText: String){
        TwitterAPICaller.client?.postTweet(with: scrollTextView.text, success: {
            self.dismiss(animated: true, completion: nil)
        }, failure: { (Error) in
            self.displayAlert(title: "Failed to send tweet!", message: "Coudn't send tweet, something went wrong.")
            print("Error posting the tweet\(Error)")
        })
    }
    
    //alert controller with one action
    func displayAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Okay!", style: .default, handler: nil))
        
        self.present(alert, animated: true)
    }
    
}
