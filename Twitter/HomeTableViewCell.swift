//
//  HomeTableViewCell.swift
//  Twitter
//
//  Created by Joy Paul on 3/4/19.
//  Copyright © 2019 Dan. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell{

    
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var tweet: UILabel!
    @IBOutlet weak var reTweetButton: UIButton!
    @IBOutlet weak var favButton: UIButton!
    @IBOutlet weak var reTweetCountLabel: UILabel!
    @IBOutlet weak var favoriteCountLabel: UILabel!
    
    
    var favorited: Bool = false
    var reTweeted: Bool = false
    var tweetID: Int!
    var favoriteCount: Int!
    var reTweetCount: Int!
    
    func setRetweeted(isReTweeted: Bool){
        if(isReTweeted){
            reTweetButton.setImage(UIImage(named: "retweet-icon-green"), for: UIControl.State.normal)
            reTweetButton.isEnabled = false
        } else{
            reTweetButton.setImage(UIImage(named: "retweet-icon"), for: UIControl.State.normal)
            reTweetButton.isEnabled = true
        }
    }
    
    func setFavorited(isFavorited: Bool){
        favorited = isFavorited
        isFavorited ? favButton.setImage(UIImage(named: "favor-icon-red"), for: UIControl.State.normal):
                    favButton.setImage(UIImage(named: "favor-icon"), for: UIControl.State.normal)
    }
    
    @IBAction func didRetweet(_ sender: UIButton) {
        if reTweetButton.isEnabled {
            TwitterAPICaller.client?.reTweet(with: tweetID, success: {
                self.setRetweeted(isReTweeted: true)
            }, failure: { (Error) in
                print("error retweeting!")
            })
        }
    }
    
    @IBAction func didFavorite(_ sender: UIButton) {
        let toBeFavorited = !favorited
        
        if(toBeFavorited){
            TwitterAPICaller.client?.favoriteTweet(with: tweetID, success: {
                self.setFavorited(isFavorited: true)
                
            }, failure: { (Error) in
                print("Failed to favorite")
            })
        }else{
            TwitterAPICaller.client?.unFavoriteTweet(with: tweetID, success: {
                self.setFavorited(isFavorited: false)
                
            }, failure: { (Error) in
                print("Failed to unfavorite")
            })
        }
    }
}
