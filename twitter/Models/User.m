//
//  User.m
//  twitter
//
//  Created by Leah Xiao on 7/2/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "User.h"

//@property (strong, nonatomic) NSString *name;
//@property (strong, nonatomic) NSString *screenName;
//@property (strong, nonatomic) NSNumber *numFollower;
//@property (strong, nonatomic) NSNumber *numFollowing;
//@property (strong, nonatomic) NSNumber *numTweets;
//@property (strong,nonatomic) NSURL *proPicURL;
//@property (strong,nonatomic) NSURL *backgroundURL;

@implementation User
- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        self.name = dictionary[@"name"];
        self.screenName = dictionary[@"screen_name"];
        self.numFollower = dictionary[@"followers_count"];
        self.numFollowing = dictionary[@"friends_count"];
        self.numTweets = dictionary[@"statuses_count"];
      //  self.numFollower = dictionary[@"name"];
        
        NSString *proPicUrl = dictionary[@"profile_image_url_https"];
         self.proPicURL = [NSURL URLWithString:proPicUrl];

        
        NSString *backUrl = dictionary[@"profile_banner_url"];
        self.backgroundURL = [NSURL URLWithString:backUrl];
       

         
//         NSString *proPicUrl = userDictionary[@"profile_image_url_https"];
//         self.proPicURL = [NSURL URLWithString:proPicUrl];

         //        self.backgroundURL = dictionary[@"profile_background_image_url_https"];
        
//        self.profilePic.image = nil;
//        if(self.tweet.proPicURL != nil){
//            [self.profilePic setImageWithURL:self.tweet.proPicURL];
        
        // Initialize any other properties
    }
    return self;
}
@end
