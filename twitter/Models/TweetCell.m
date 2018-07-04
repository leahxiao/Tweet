//
//  TweetCell.m
//  
//
//  Created by Leah Xiao on 7/2/18.
//

#import "TweetCell.h"

@implementation TweetCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

//self.idStr = dictionary[@"id_str"];
//self.text = dictionary[@"text"];
//self.favoriteCount = [dictionary[@"favorite_count"] intValue];
//self.favorited = [dictionary[@"favorited"] boolValue];
//self.retweetCount = [dictionary[@"retweet_count"] intValue];
//self.retweeted = [dictionary[@"retweeted"] boolValue];


- (void)setTweet:(Tweet *)tweet {
    _tweet = tweet; // the underscore and nme of property means youre accessing the instance vari directly. can only do it internally when youre in the class itself (private) otyherwise it will call the setter forever.
    [self refreshData];
    }

-(void) refreshData{
    self.usernameLabel.text = self.tweet.user.name;
    self.userHandleLabel.text = self.tweet.user.screenName;
    self.dateLabel.text = self.tweet.createdAtString;
    self.tweetLabel.text = self.tweet.text;
    self.retweetLabel.text = [NSString stringWithFormat:@"%i", self.tweet.retweetCount];
    self.favoriteLabel.text = [NSString stringWithFormat:@"%i", self.tweet.favoriteCount];
    
    [self.usernameLabel sizeToFit];
    [self.userHandleLabel sizeToFit];
    [self.dateLabel sizeToFit];
//    [self.tweetLabel sizeToFit];
//    [self.retweetLabel sizeToFit];
//    [self.favoriteLabel sizeToFit];
    
    self.profilePic.image = nil;
    if(self.tweet.proPicURL != nil){
    [self.profilePic setImageWithURL:self.tweet.proPicURL];
     
        
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
    
//    NSLog(@"%@", self.tweetLabel.text);
//    NSLog(@"%@", self.usernameLabel.text);
    
    
}
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
            }
        }];
    }
}




@end
