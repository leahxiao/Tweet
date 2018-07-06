//
//  ComposeViewController.m
//  twitter
//
//  Created by Leah Xiao on 7/3/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "ComposeViewController.h"
#import "Tweet.h"
#import "APIManager.h"

@interface ComposeViewController () <ComposeViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextView *tweetText;
@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)closeButtonIsTapped:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

- (IBAction)tweetButtonIsPressed:(id)sender {
    NSString *tweetWritten = self.tweetText.text;
    [[APIManager shared] makeTweet:tweetWritten completion:^(Tweet *tweet, NSError *error) {
        if(error){
            NSLog(@"error");
        }
        else{
            [self.delegate didTweet:tweet];
            [self dismissViewControllerAnimated:true completion:nil];
        }
    }];
//    [[APIManager shared] makeTweet:@"This is my tweet 😀" completion:^(Tweet *tweet, NSError *error) {
//        if(error){
//            NSLog(@"Error composing Tweet: %@", error.localizedDescription);
//        }
//        else{
//            [self.delegate didTweet:tweet];
//            NSLog(@"Compose Tweet Success!");
//        }
//    }];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UINavigationController *navigationController = [segue destinationViewController];
    ComposeViewController *composeController = (ComposeViewController*)navigationController.topViewController;
    composeController.delegate = self;

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)didTweet:(Tweet *)tweet {
}

@end

