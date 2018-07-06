//
//  User.h
//  twitter
//
//  Created by Leah Xiao on 7/2/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIImageView+AFNetworking.h"

@interface User : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *screenName;
@property (strong, nonatomic) NSNumber *numFollower;
@property (strong, nonatomic) NSNumber *numFollowing;
@property (strong, nonatomic) NSNumber *numTweets;
@property (strong,nonatomic) NSURL *proPicURL;
@property (strong,nonatomic) NSURL *backgroundURL;



//UIImageView *bannerImageView;
//UIImageView *proPicImageView;
//UILabel *UsernameLabel;
//UILabel *handleLabel;
//UILabel *numTweetsLabel;
//UILabel *numFollowingLabel;
//UILabel *numFollowersLabel;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
