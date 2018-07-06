//
//  InfiniteScrollActivityView.h
//  
//
//  Created by Leah Xiao on 7/5/18.
//

#import <UIKit/UIKit.h>

@interface InfiniteScrollActivityView : UIView

@property (class, nonatomic, readonly) CGFloat defaultHeight;

- (void)startAnimating;
- (void)stopAnimating;


@end
