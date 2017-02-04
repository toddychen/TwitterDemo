//
//  ComposeViewController.h
//  TwitterDemo
//
//  Created by Yi Chen on 2/1/17.
//  Copyright © 2017 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface ComposeViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *handleLabel;
@property (weak, nonatomic) IBOutlet UITextView *inputTextView;

@property (strong, nonatomic) User *user;

@end
