//
//  ProfileViewController.m
//  twitter
//
//  Created by Leah Xiao on 7/6/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "ProfileViewController.h"
#import "User.h"
#import "APIManager.h"
@interface ProfileViewController ()

@end

//@property (weak, nonatomic) IBOutlet UIImageView *bannerImageView;
//@property (weak, nonatomic) IBOutlet UIImageView *proPicImageView;
//@property (weak, nonatomic) IBOutlet UILabel *UsernameLabel;
//@property (weak, nonatomic) IBOutlet UILabel *handleLabel;
//@property (weak, nonatomic) IBOutlet UILabel *numTweetsLabel;
//@property (weak, nonatomic) IBOutlet UILabel *numFollowingLabel;
//@property (weak, nonatomic) IBOutlet UILabel *numFollowersLabel;

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[APIManager shared] ownProfileInfo:^(User *user, NSError *error){
        // completion part
        if(user) {
            self.UsernameLabel.text = user.name;
            self.handleLabel.text = user.screenName;
            self.numTweetsLabel.text = user.name;
          //  [NSString stringWithFormat:@"%i", self.tweet.retweetCount]
            self.numFollowingLabel.text = [NSString stringWithFormat:@"%@", user.numFollowing];
            self.numFollowersLabel.text = [NSString stringWithFormat:@"%@", user.numFollower];
            self.numTweetsLabel.text = [NSString stringWithFormat:@"%@", user.numTweets];
            
            self.proPicImageView.image = nil;
            if(user.proPicURL != nil){
                [self.proPicImageView setImageWithURL:user.proPicURL];
            }
            self.proPicImageView.layer.masksToBounds = YES;
            self.proPicImageView.layer.cornerRadius = self.proPicImageView.frame.size.width / 2;
            
            self.bannerImageView.image = nil;
            if(user.backgroundURL != nil){
                [self.bannerImageView setImageWithURL:user.backgroundURL];
            }
            
            
//            NSString *proPicUrl = dictionary[@"profile_image_url_https"];
//            self.proPicURL = [NSURL URLWithString:proPicUrl];
//
//
//            NSString *backUrl = dictionary[@"profile_banner_url"];
//            self.backgroundURL = [NSURL URLWithString:backUrl];
            
            
        } else {
            NSLog(@"😫😫😫 Error getting home timeline: %@", error.localizedDescription);
        }
    }];
    
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // [self.backgroundURL setImageWithURL: self.backgroundURL];
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
