//
//  ComposeViewController.m
//  TwitterDemo
//
//  Created by Yi Chen on 2/1/17.
//  Copyright © 2017 codepath. All rights reserved.
//

#import "ComposeViewController.h"
#import <UIImageView+AFNetworking.h>
#import "TwitterClient.h"
#import <MBProgressHUD.h>
#import "ProfileViewController.h"

@interface ComposeViewController ()

@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self reloadData];
    
    UIBarButtonItem *tweetButton = [[UIBarButtonItem alloc] initWithTitle:@"Tweet" style:UIBarButtonItemStylePlain target:self action:@selector(fireTweet)];
    self.navigationItem.rightBarButtonItem = tweetButton;
}

- (void)fireTweet {
    NSLog(@"In fireTweet");
    NSLog(@"status: %@", self.inputTextView.text);
    
    NSDictionary *param = [[NSDictionary alloc] initWithObjectsAndKeys:self.inputTextView.text, @"status", nil];
    
    [[TwitterClient sharedInstance] POST:@"1.1/statuses/update.json" parameters:param progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"doing nothing in progress");
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"tweet sent!");
        
        // Show the sent message
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.label.text = @"Tweet Sent!";
        hud.margin = 10.f;
        [hud setOffset:CGPointMake(0, 150.f)];
        hud.removeFromSuperViewOnHide = YES;
        [hud hideAnimated:YES afterDelay:3];
        
        // move to my profile view
        ProfileViewController *profileViewController = [[ProfileViewController alloc] initWithNibName:@"ProfileViewController" bundle:nil];
        profileViewController.user = self.user;
        [[self navigationController] popViewControllerAnimated:YES];
        
        //[self.navigationController pushViewController:profileViewController animated:YES];
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"failed to send tweets! message: %@", error.userInfo);
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)loadPlaceholderData {
    self.nameLabel.text = @"Yi Chen";
    self.handleLabel.text = @"@yicyahoo";
    self.inputTextView.text = @"Some input has been written here.";
    [self.profileImageView setBackgroundColor:[UIColor blueColor]];
}

- (void)reloadData {
    self.nameLabel.text = self.user.name;
    self.handleLabel.text = [NSString stringWithFormat: @"@%@", self.user.screenname];
    self.inputTextView.text = @"";
    
    NSLog(@"profileImageUrl: %@", self.user.profileImageUrl);
    [self.profileImageView setImageWithURL:[NSURL URLWithString:self.user.profileImageUrl]];
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
