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

@interface ComposeViewController () <ComposeViewControllerDelegate, UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *tweetText;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (strong, nonatomic) NSString *tweetContent;
@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tweetText.delegate = self;
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

- (void)textViewDidChange:(UITextView *)textView {
    if (textView.text.length < 141) {
        self.countLabel.text = [NSString stringWithFormat:@"%lu",140 - textView.text.length];
        self.tweetContent = textView.text;
    } else {
        textView.text = self.tweetContent;
    }
}

//- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
//
//    int characterLimit = 140;
//
//    // Construct what the new text would be if we allowed the user's latest edit
//    NSString *newText = [self.tweetText.text stringByReplacingCharactersInRange:range withString:text];
//
//    // TODO: Update Character Count Label
//    //self.countLabel.text = [NSString stringWithFormat:@"%@",140 - tweetText.text.length]; ;
//
//    // The new text should be allowed? True/False
//    return newText.length < characterLimit;
//}

@end

