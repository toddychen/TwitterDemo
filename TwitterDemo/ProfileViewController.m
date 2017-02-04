//
//  ProfileViewController.m
//  TwitterDemo
//
//  Created by Yi Chen on 2/2/17.
//  Copyright © 2017 codepath. All rights reserved.
//

#import "ProfileViewController.h"
#import "TwitterClient.h"
#import "TweetTableViewCell.h"
#import <UIImageView+AFNetworking.h>

@interface ProfileViewController ()

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //[self loadPlaceholderData];

    [self fetchUserAndTweets];
    
    // set up table view
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    self.tableView.estimatedRowHeight = 200;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    UINib *nib = [UINib nibWithNibName:@"TweetTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"TweetTableViewCell"];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadPlaceholderData {
    self.nameLabel.text = @"Yi Chen";
    self.handleLabel.text = @"@yicyahoo";
    self.tweetsCountLabel.text = @"123";
    self.followingCountLabel.text = @"456";
    self.followersCountLabel.text = @"789";
    
    [self.profileImageView setBackgroundColor:[UIColor orangeColor]];
    [self.backgroundImageView setBackgroundColor:[UIColor blueColor]];
}

- (void)reloadData {
    // assume the tweet model is set.
    self.nameLabel.text = self.user.name;
    self.handleLabel.text = [NSString stringWithFormat: @"@%@", self.user.screenname];
    self.tweetsCountLabel.text = [NSString stringWithFormat: @"%@", self.user.statusesCount];
    self.followingCountLabel.text = [NSString stringWithFormat: @"%@", self.user.followingCount];
    self.followersCountLabel.text = [NSString stringWithFormat: @"%@", self.user.followersCount];
    
    
    //NSLog(@"profileImageUrl: %@", self.tweet.user.profileImageUrl);
    
    [self.profileImageView setImageWithURL:[NSURL URLWithString:self.user.profileImageUrl]];
    
    if (self.user.backgroundImageUrl != [NSNull null]) {
        [self.backgroundImageView setImageWithURL:[NSURL URLWithString:self.user.backgroundImageUrl]];
    }
    
}


- (void)fetchUserAndTweets {
    NSLog(@"In fetchUserAndTweets");
    NSLog(@"screen_name: %@", self.user.screenname);
    
    NSDictionary *param = [[NSDictionary alloc] initWithObjectsAndKeys:self.user.screenname, @"screen_name", nil];
    
    [[TwitterClient sharedInstance] GET:@"/1.1/statuses/user_timeline.json" parameters:param progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"doing nothing in progress");
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"got user and tweets!");
        
        self.tweets = [Tweet tweetsWithArray:responseObject];

        /*
        for (Tweet *tweet in self.tweets) {
            NSLog(@"my tweets. user.name: %@, user.screenname: %@, createdAt: %@",
                //tweet.text,
                tweet.user.name, tweet.user.screenname, tweet.createdAt);
        }
        */
        
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"failed to get my tweets!");
    }];
    
    [self reloadData];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tweets.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TweetTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TweetTableViewCell" forIndexPath:indexPath];
    
    cell.tweet = self.tweets[indexPath.row];
    [cell reloadData];
    
    return cell;
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
