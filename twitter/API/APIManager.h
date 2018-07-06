//
//  APIManager.h
//  twitter
//
//  Created by emersonmalca on 5/28/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "BDBOAuth1SessionManager.h"
#import "BDBOAuth1SessionManager+SFAuthenticationSession.h"
#import "Tweet.h"

@interface APIManager : BDBOAuth1SessionManager

+ (instancetype)shared;


- (void)getHomeTimelineWithCompletion:(void(^)(NSArray *tweets, NSError *error))completion count:(int)count;
//- (void)getHomeTimelineWithCompletion:(void(^)(NSArray *tweets, NSError *error))completion;
// You don’t need to make any changes to this, but as you want to support other API requests to get a users timeline, favorite a tweet, retweet, add a function for each API request.
-(void)makeTweet:(NSString *)text completion:(void (^)(Tweet *, NSError *))completion;
- (void)favorite:(Tweet *)tweet completion:(void (^)(Tweet *, NSError *))completion;
- (void)unfavorite:(Tweet *)tweet completion:(void (^)(Tweet *, NSError *))completion;
- (void)retweet:(Tweet *)tweet completion:(void (^)(Tweet *, NSError *))completion;
- (void)unretweet:(Tweet *)tweet completion:(void (^)(Tweet *, NSError *))completion;
@end
