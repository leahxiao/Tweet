//
//  DetailsViewController.m
//  twitter
//
//  Created by Leah Xiao on 7/4/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "DetailsViewController.h"
#import "Tweet.h"
#import "User.h"
#import "UIImageView+AFNetworking.h"
#import "APIManager.h"
#import "TweetCell.h"



@interface DetailsViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *proPicImageView;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *handleLabel;
@property (weak, nonatomic) IBOutlet UILabel *tweetLabel;
//@property (nonatomic, strong) Tweet *tweet;
@property (weak, nonatomic) IBOutlet UIButton *retweetButton;
//@property (weak, nonatomic) IBOutlet UILabel *retweetLabel;

@property (weak, nonatomic) IBOutlet UIButton *favoriteButton;
//@property (weak, nonatomic) IBOutlet UILabel *favoriteLabel;

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.usernameLabel.text = self.tweet.user.name;
    self.handleLabel.text = self.tweet.user.screenName;
    self.tweetLabel.text = self.tweet.text;
    
//    self.retweetLabel.text = [NSString stringWithFormat:@"%i", self.tweet.retweetCount];
//    self.favoriteLabel.text = [NSString stringWithFormat:@"%i", self.tweet.favoriteCount];
    [self.retweetButton setTitle:[NSString stringWithFormat:@"%i", self.tweet.retweetCount] forState:UIControlStateNormal];
    //    self.favoriteLabel.text = [NSString stringWithFormat:@"%i", self.tweet.favoriteCount];
    [self.favoriteButton setTitle:[NSString stringWithFormat:@"%i", self.tweet.retweetCount] forState:UIControlStateNormal];
    
    
    self.proPicImageView.image = nil;
    if(self.tweet.proPicURL != nil){
        [self.proPicImageView setImageWithURL:self.tweet.proPicURL];
    }
        
        if(self.tweet.favorited){
            UIImage *image = [UIImage imageNamed:@"favor-icon-red"];
            [self.favoriteButton setImage:image forState:UIControlStateNormal];
        }
        else if (!self.tweet.favorited) {
            UIImage *image = [UIImage imageNamed:@"favor-icon"];
            [self.favoriteButton setImage:image forState:UIControlStateNormal];
        }


        if(self.tweet.retweeted){
            UIImage *image = [UIImage imageNamed:@"retweet-icon-green"];
            [self.retweetButton setImage:image forState:UIControlStateNormal];
        }
        else if(!self.tweet.retweeted){
            UIImage *image = [UIImage imageNamed:@"retweet-icon"];
            [self.retweetButton setImage:image forState:UIControlStateNormal];
        }

}


//  tweetcell
- (IBAction)didTapFavorite:(id)sender {
    // TODO: Update the local tweet model

    if(self.tweet.favorited){
        self.tweet.favoriteCount -= 1;
        self.tweet.favorited = NO;
        [self setTweet:self.tweet];
        [[APIManager shared] unfavorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully favorited the following Tweet: %@", tweet.text);
                    UIImage *image = [UIImage imageNamed:@"favor-icon"];
                    [self.favoriteButton setImage:image forState:UIControlStateNormal];
//                self.favoriteLabel.text = [NSString stringWithFormat:@"%i", self.tweet.favoriteCount];
                [self.favoriteButton setTitle:[NSString stringWithFormat:@"%i", self.tweet.favoriteCount] forState:UIControlStateNormal];
            }
        }];
    }

    else{
        self.tweet.favorited = YES;
        self.tweet.favoriteCount += 1;
        [self setTweet:self.tweet];
        [[APIManager shared] favorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully favorited the following Tweet: %@", tweet.text);
                UIImage *image = [UIImage imageNamed:@"favor-icon-red"];
                [self.favoriteButton setImage:image forState:UIControlStateNormal];
//                self.favoriteLabel.text = [NSString stringWithFormat:@"%i", self.tweet.favoriteCount];
                    [self.favoriteButton setTitle:[NSString stringWithFormat:@"%i", self.tweet.favoriteCount] forState:UIControlStateNormal];
            }
        }];
        
        
    }

    // TODO: Update cell UI
    // TODO: Send a POST request to the POST favorites/create endpoint
}

- (IBAction)didTapRetweet:(id)sender {
    if(self.tweet.retweeted){
        self.tweet.retweetCount -= 1;
        self.tweet.retweeted = NO;
        [self setTweet:self.tweet];
        [[APIManager shared] unretweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                NSLog(@"Error retweeting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully retweeted the following Tweet: %@", tweet.text);
                UIImage *image = [UIImage imageNamed:@"retweet-icon"];
                [self.retweetButton setImage:image forState:UIControlStateNormal];
//                 self.retweetLabel.text = [NSString stringWithFormat:@"%i", self.tweet.retweetCount];
                [self.retweetButton setTitle:[NSString stringWithFormat:@"%i", self.tweet.retweetCount] forState:UIControlStateNormal];
            }
        }];
    }


    else{
        self.tweet.retweeted = YES;
        self.tweet.retweetCount += 1;
        [self setTweet:self.tweet];
        [[APIManager shared] retweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                NSLog(@"Error ret tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully ret the following Tweet: %@", tweet.text);
                UIImage *image = [UIImage imageNamed:@"retweet-icon-green"];
                [self.retweetButton setImage:image forState:UIControlStateNormal];
//                self.retweetLabel.text = [NSString stringWithFormat:@"%i", self.tweet.retweetCount];
                [self.retweetButton setTitle:[NSString stringWithFormat:@"%i", self.tweet.retweetCount] forState:UIControlStateNormal];
            }
        }];
  }


    // Do any additional setup after loading the view.
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
