//
//  TweetDetailViewController.m
//  TwitterDemo
//
//  Created by Yi Chen on 1/31/17.
//  Copyright © 2017 codepath. All rights reserved.
//

#import "TweetDetailViewController.h"
#import <UIImageView+AFNetworking.h>

@interface TweetDetailViewController ()

@end

@implementation TweetDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Tweet";
    
    [self reloadData];
    //[self loadPlaceholderData];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)loadPlaceholderData {
    self.nameLabel.text = @"Yi Chen";
    self.handleLabel.text = @"@yicyahoo";
    self.timestampLabel.text = @"2017-02-01";
    
    self.contentLabel.text = @"This is a really long tweet. This is a really long tweet. This is a really long tweet. This is a really long tweet. This is a really long tweet.";
    self.retweetCountLabel.text = @"123";
    self.favoriteCountLabel.text = @"45";
    
    [self.profileImageView setBackgroundColor:[UIColor blueColor]];
}

- (void)reloadData {
    self.nameLabel.text = self.tweet.user.name;
    self.handleLabel.text = [NSString stringWithFormat: @"@%@", self.tweet.user.screenname];
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd"];
    self.timestampLabel.text = [df stringFromDate:self.tweet.createdAt];
    
    self.contentLabel.text = self.tweet.text;
    self.retweetCountLabel.text = @"123";
    self.favoriteCountLabel.text = @"45";
    
    //NSLog(@"profileImageUrl: %@", self.tweet.user.profileImageUrl);
    [self.profileImageView setImageWithURL:[NSURL URLWithString:self.tweet.user.profileImageUrl]];

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
