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
    NSLog(@"the retweeted value is: %@", self.tweet.retweeted ? @"yes" : @"no");
    self.tweet.retweeted = !self.tweet.retweeted;
    [self loadRetweetImage];
    
}

- (void)loadRetweetImage {
    NSLog(@"In loadRetweetImage!");
    if (self.tweet.retweeted) {
        [self.retweetButton setImage:[UIImage imageNamed:@"iconmonstr-retweet-gloden"] forState:UIControlStateNormal];
        //[self.retweetButton setImage:[UIImage imageNamed:@"iconmonstr-retweet-gloden"]];
    } else {
        [self.retweetButton setImage:[UIImage imageNamed:@"iconmonstr-retweet-black"] forState:UIControlStateNormal];
        //[self.retweetButton.imageView setImage:[UIImage imageNamed:@"iconmonstr-retweet-black"]];
    }
}

@end
