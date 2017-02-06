//
//  TweetTableViewCell.m
//  TwitterDemo
//
//  Created by  Michael Lin on 1/30/17.
//  Copyright © 2017 codepath. All rights reserved.
//

#import "TweetTableViewCell.h"
#import <UIImageView+AFNetworking.h>
#import "ProfileViewController.h"
#import "TwitterClient.h"
#import <MBProgressHUD.h>

@interface TweetTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *handleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timestampLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@end

@implementation TweetTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.nameLabel.text = @"My Twitter Name";
    self.handleLabel.text = @"@somebodysomebodysomebodysomebodysomebodysomebody";
    self.timestampLabel.text = @"4h";
    self.contentLabel.text = @"A really long repeated message. A really long repeated message. A really long repeated message. A really long repeated message.";
    
    // set up profile retweet button action
    self.retweetButton.userInteractionEnabled = YES;
    UITapGestureRecognizer *retweetButtonTapped = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapRetweetButton:)];
    retweetButtonTapped.numberOfTapsRequired = 1;
    [self.retweetButton addGestureRecognizer:retweetButtonTapped];

    // reload data
    [self reloadData];
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)reloadData {
    // assume the tweet model is set.
    self.nameLabel.text = self.tweet.user.name;
    self.handleLabel.text = [NSString stringWithFormat: @"@%@", self.tweet.user.screenname];
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd"];
    self.timestampLabel.text = [df stringFromDate:self.tweet.createdAt];
    
    self.contentLabel.text = self.tweet.text;
    
    //NSLog(@"profileImageUrl: %@", self.tweet.user.profileImageUrl);
    
    [self.profileImageView setImageWithURL:[NSURL URLWithString:self.tweet.user.profileImageUrl]];
    [self.profileImageView setBackgroundColor:[UIColor blueColor]];
    
    [self loadRetweetImage];
}


- (void)tapRetweetButton: (UIGestureRecognizer *)sender {
    NSLog(@"In tapRetweetButton!");
    NSLog(@"the retweeted value before tap is: %@", self.tweet.retweeted ? @"yes" : @"no");
    
    NSDictionary *param = [[NSDictionary alloc] initWithObjectsAndKeys:self.tweet.tweetId, @"id", nil];
    
    NSString *retweetURLString = [NSString stringWithFormat:@"https://api.twitter.com/1.1/statuses/retweet/%@.json", self.tweet.tweetId];
    NSString *unRetweetURLString = [NSString stringWithFormat:@"https://api.twitter.com/1.1/statuses/unretweet/%@.json", self.tweet.tweetId];
    
    if (self.tweet.retweeted) {
        // remove a retweet
        [[TwitterClient sharedInstance] POST:unRetweetURLString parameters:param progress:^(NSProgress * _Nonnull downloadProgress) {
            NSLog(@"doing nothing in progress");
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"retweet removed!");
            
            // Show the sent message
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.label.text = @"Retweet Removed!";
            hud.margin = 10.f;
            [hud setOffset:CGPointMake(0, 150.f)];
            hud.removeFromSuperViewOnHide = YES;
            [hud hideAnimated:YES afterDelay:3];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"failed to remove retweets! message: %@", error.userInfo);
            
            // Show the error message
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.label.text = @"Retweet removing Failed!";
            hud.margin = 10.f;
            [hud setOffset:CGPointMake(0, 150.f)];
            hud.removeFromSuperViewOnHide = YES;
            [hud hideAnimated:YES afterDelay:3];
        }];

    } else {
        // retweet a tweet
        [[TwitterClient sharedInstance] POST:retweetURLString parameters:param progress:^(NSProgress * _Nonnull downloadProgress) {
            NSLog(@"doing nothing in progress");
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"retweet sent!");
            
            // Show the sent message
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.label.text = @"Retweet Sent!";
            hud.margin = 10.f;
            [hud setOffset:CGPointMake(0, 150.f)];
            hud.removeFromSuperViewOnHide = YES;
            [hud hideAnimated:YES afterDelay:3];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"failed to send retweets! message: %@", error.userInfo);
    
            // Show the error message
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.label.text = @"Retweet Failed!";
            hud.margin = 10.f;
            [hud setOffset:CGPointMake(0, 150.f)];
            hud.removeFromSuperViewOnHide = YES;
            [hud hideAnimated:YES afterDelay:3];
        }];

    }
    self.tweet.retweeted = !self.tweet.retweeted;
    [self loadRetweetImage];
    
}

- (void)loadRetweetImage {
    NSLog(@"In loadRetweetImage!");
    if (self.tweet.retweeted) {
        [self.retweetButton setImage:[UIImage imageNamed:@"iconmonstr-retweet-gloden"] forState:UIControlStateNormal];
    } else {
        [self.retweetButton setImage:[UIImage imageNamed:@"iconmonstr-retweet-black"] forState:UIControlStateNormal];
    }
}

@end
