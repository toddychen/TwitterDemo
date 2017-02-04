//
//  LoginViewController.m
//  TwitterDemo
//
//  Created by Yi Chen on 1/30/17.
//  Copyright © 2017 codepath. All rights reserved.
//

#import "LoginViewController.h"
#import "TwitterClient.h"
#import "TweetListViewController.h"
#import "TweetDetailViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (IBAction)onLogin:(id)sender {
    [[TwitterClient sharedInstance] loginWithCompletion:^(User *user, NSError *error) {
        if (user != nil) {
            // present tweets view
            NSLog(@"login successful! Welcome %@", user.name);
            TweetListViewController *tweetListViewController = [[TweetListViewController alloc] initWithNibName:@"TweetListViewController" bundle:nil];
            tweetListViewController.user = user;
            
            UINavigationController *navCtrl = [[UINavigationController alloc] initWithRootViewController:tweetListViewController];
            [self presentViewController:navCtrl animated:YES completion:nil];
            
            
        } else {
            // present error view
            NSLog(@"login failed!");
        }
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
