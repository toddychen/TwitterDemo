//
//  ProfileViewController.h
//  TwitterDemo
//
//  Created by Yi Chen on 2/2/17.
//  Copyright © 2017 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
#import "Tweet.h"

@interface ProfileViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *handleLabel;

@property (weak, nonatomic) IBOutlet UILabel *tweetsCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *followingCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *followersCountLabel;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) User *user;
@property (strong, nonatomic) NSArray<Tweet *> *tweets;

@end
