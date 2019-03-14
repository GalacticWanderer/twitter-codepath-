//
//  ProfileViewController.swift
//  Twitter
//
//  Created by Joy Paul on 3/13/19.
//  Copyright © 2019 Dan. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var handlerName: UILabel!
    @IBOutlet weak var tagLine: UILabel!
    @IBOutlet weak var number_of_tweets: UILabel!
    @IBOutlet weak var numberFollowing: UILabel!
    @IBOutlet weak var followersCount: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        getUserInfo()
    }
 
    @IBAction func onBackPressed(_ sender: UIBarButtonItem) {
        navigationController?.dismiss(animated: true, completion: nil)
    }
    
    func getUserInfo(){
        TwitterAPICaller.client?.getUserDictionariesRequest(success: {(userInfo: NSDictionary) in
            
            let profileImageUrl = URL(string: userInfo["profile_image_url_https"] as! String)
            let data = try? Data(contentsOf: profileImageUrl!)
            self.profileImageView.image = UIImage(data: data!)
            
            self.handlerName.text = userInfo["screen_name"] as? String
            self.tagLine.text = userInfo["description"] as? String
            
            let tweets = userInfo["statuses_count"] as! Int
            self.number_of_tweets.text = "Total tweets: \(tweets)"
            
            let following = userInfo["following"] as! Int
            self.numberFollowing.text = "Total followers: \(following)"
            
            let followers = userInfo["followers_count"] as! Int
            self.followersCount.text = "Total Following: \(followers)"
            
        }, failure: { (Error) in
            print(Error)
        })
    }
    

}
