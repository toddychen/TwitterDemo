//
//  TweetListViewController.m
//  TwitterDemo
//
//  Created by  Michael Lin on 1/30/17.
//  Copyright © 2017 codepath. All rights reserved.
//

#import "TweetListViewController.h"
#import "TweetTableViewCell.h"
#import "TwitterClient.h"
#import "Tweet.h"
#import "TweetDetailViewController.h"
#import "ComposeViewController.h"
#import "ProfileViewController.h"
#import <MBProgressHUD.h>


@interface TweetListViewController () <UITableViewDataSource>

@property (nonatomic, strong) NSArray<Tweet *> *tweets;

@end

@implementation TweetListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"Home";
    
    [self fetchTweets];
    
    // set up table view
    self.tableView.dataSource = self;
    self.tableView.delegate = self;

    self.tableView.estimatedRowHeight = 200;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    UINib *nib = [UINib nibWithNibName:@"TweetTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"TweetTableViewCell"];
    
    // set up navigation bar items
    UIBarButtonItem *newTweetButton = [[UIBarButtonItem alloc] initWithTitle:@"New" style:UIBarButtonItemStylePlain target:self action:@selector(fireComposeView)];
    self.navigationItem.rightBarButtonItem = newTweetButton;
    
    UIBarButtonItem *meButton = [[UIBarButtonItem alloc] initWithTitle:@"Me" style:UIBarButtonItemStylePlain target:self action:@selector(fireMyProfileView)];
    self.navigationItem.leftBarButtonItem = meButton;
    
    
    // set up refresh control
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    refreshControl.backgroundColor = [UIColor orangeColor];
    refreshControl.tintColor = [UIColor whiteColor];
    [refreshControl addTarget:self action:@selector(fetchTweets) forControlEvents:UIControlEventValueChanged];
    [self.tableView setRefreshControl:refreshControl];
    
}


- (void)fireMyProfileView {
    NSLog(@"In fireMyProfileView!");
    ProfileViewController *profileViewController = [[ProfileViewController alloc] initWithNibName:@"ProfileViewController" bundle:nil];
        profileViewController.user = self.user;
    [self.navigationController pushViewController:profileViewController animated:YES];
}

- (void)fireProfileView: (UIGestureRecognizer *)sender {
    NSLog(@"In fireProfileView!");
    ProfileViewController *profileViewController = [[ProfileViewController alloc] initWithNibName:@"ProfileViewController" bundle:nil];
    
    //NSLog(@"view_tag: %@", sender.view.tag);
    profileViewController.user = self.tweets[sender.view.tag].user;
    [self.navigationController pushViewController:profileViewController animated:YES];
}

- (void)fireComposeView {
    NSLog(@"In fireComposeView!");
    ComposeViewController *composeViewController = [[ComposeViewController alloc] initWithNibName:@"ComposeViewController" bundle:nil];
    composeViewController.user = self.user;
    [self.navigationController pushViewController:composeViewController animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tweets.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // set up data and reload date to cell
    TweetTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TweetTableViewCell" forIndexPath:indexPath];
    
    cell.tweet = self.tweets[indexPath.row];
    [cell reloadData];
    
    // set up profile image view action
    cell.profileImageView.userInteractionEnabled = YES;
    cell.profileImageView.tag = indexPath.row;
    UITapGestureRecognizer *profileImageTapped = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fireProfileView:)];
    profileImageTapped.numberOfTapsRequired = 1;
    [cell.profileImageView addGestureRecognizer:profileImageTapped];
    
    return cell;
}

- (void)fetchTweets {
    NSLog(@"In fetchTweets");
    [[TwitterClient sharedInstance] GET:@"1.1/statuses/home_timeline.json" parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"doing nothing in progress");
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"got tweets!");
        [self.tableView.refreshControl endRefreshing];
        self.tweets = [Tweet tweetsWithArray:responseObject];
        
        //NSLog(@"responseObject: %@", responseObject);

        
        for (Tweet *tweet in self.tweets) {
            NSLog(@"my tweets, user.retweeted: %@", tweet.retweeted ? @"yes" : @"no");
        }
        
        
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"failed to get my tweets!");
        [self.tableView.refreshControl endRefreshing];
    }];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    //[self performSegueWithIdentifier:@"TweetDetailViewControllerSegue" sender:[self.tableView cellForRowAtIndexPath:indexPath]];
    
    
    NSLog(@"In didSelectRowAtIndexPath! @%ld", indexPath.row);
    TweetDetailViewController *tweetDetailViewController= [[TweetDetailViewController alloc] initWithNibName:@"TweetDetailViewController" bundle:nil];
    tweetDetailViewController.tweet = self.tweets[indexPath.row];
    [tweetDetailViewController reloadData];
    
    //[self presentViewController:tweetDetailViewController animated:YES completion:nil];
    
    [self.navigationController pushViewController:tweetDetailViewController animated:YES];
    
}



@end
