//
//  DetailsViewController.h
//  twitter
//
//  Created by Leah Xiao on 7/4/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"
#import "User.h"
#import "APIManager.h"

@interface DetailsViewController : UIViewController
@property (nonatomic, strong) Tweet *tweet;

@end
