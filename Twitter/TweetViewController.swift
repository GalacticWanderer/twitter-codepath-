//
//  TweetViewController.swift
//  Twitter
//
//  Created by Joy Paul on 3/11/19.
//  Copyright © 2019 Dan. All rights reserved.
//

import UIKit

class TweetViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var scrollTextView: UITextView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var charCounter: UITextField!
    
    var userInfo = [NSDictionary]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollTextView.becomeFirstResponder()
        //roundsImageView()
        scrollTextView.delegate = self
        aGetReq()
    }
    
    func aGetReq(){
        TwitterAPICaller.client?.getUserDictionariesRequest(success: { (info: NSDictionary) in
            
            let profileImageUrl = URL(string: info["profile_image_url_https"] as! String)
            let data = try? Data(contentsOf: profileImageUrl!)
            
            self.profileImageView.image = UIImage(data: data!)
            
        }, failure: { (Error) in
            print("Error")
        })
    }
    
    func roundsImageView(){
        profileImageView.layer.masksToBounds = false
        profileImageView.layer.cornerRadius = 50
        profileImageView.clipsToBounds = true
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let newText = (textView.text as NSString).replacingCharacters(in: range, with: text)
        let numberOfChars = newText.count
        countTheChars = newText.count
        return numberOfChars < 140    // 10 Limit Value
    }
    
    var countTheChars: Int = 0{
        didSet{
            charCounter.text = "\(countTheChars)"
        }
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
