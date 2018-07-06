//
//  TimelineViewController.m
//  twitter
//
//  Created by emersonmalca on 5/28/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "TimelineViewController.h"
#import "APIManager.h"
#import "Tweet.h"
#import "TweetCell.h"
#import "ComposeViewController.h"
#import "LoginViewController.h"
#import "AppDelegate.h"
#import "DetailsViewController.h"
#import "InfiniteScrollActivityView.h"

@interface TimelineViewController () <ComposeViewControllerDelegate, UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>
@property NSArray *tweets;
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *logoutButton;
@property (nonatomic) Boolean isMoreDataLoading;
@property InfiniteScrollActivityView* loadingMoreView;
@property int count;

@end

@implementation TimelineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    
    self.tableview.rowHeight = UITableViewAutomaticDimension;
    self.tableview.estimatedRowHeight = 150;
    
    self.count = 20;
    CGRect frame = CGRectMake(0, self.tableview.contentSize.height, self.tableview.bounds.size.width, InfiniteScrollActivityView.defaultHeight);
    self.loadingMoreView = [[InfiniteScrollActivityView alloc] initWithFrame:frame];
    self.loadingMoreView.hidden = true;
    [self.tableview addSubview:self.loadingMoreView];
    
    UIEdgeInsets insets = self.tableview.contentInset;
    insets.bottom += InfiniteScrollActivityView.defaultHeight;
    self.tableview.contentInset = insets;
    
    self.isMoreDataLoading = false;
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(beginRefresh:) forControlEvents:UIControlEventValueChanged];
    [self.tableview insertSubview:refreshControl atIndex:0];

    [[APIManager shared] getHomeTimelineWithCompletion:^(NSArray *tweets, NSError *error) {
        // completion part
        if (tweets) {
            self.tweets = tweets;
            [self.tableview reloadData];
            
        } else {
            NSLog(@"😫😫😫 Error getting home timeline: %@", error.localizedDescription);
        }
    }count:self.count];

}

    
    
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)beginRefresh:(UIRefreshControl *)refreshControl {
    
    // Create NSURL and NSURLRequest
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]
                                                          delegate:nil
                                                     delegateQueue:[NSOperationQueue mainQueue]];
    session.configuration.requestCachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
    [[APIManager shared] getHomeTimelineWithCompletion:^(NSArray *tweets, NSError *error) {
        if (tweets) {
            NSLog(@"😎😎😎 Successfully loaded home timeline");
            self.tweets = tweets;
            [self.tableview reloadData];
            
        } else {
            NSLog(@"😫😫😫 Error getting home timeline: %@", error.localizedDescription);
        }
    }count:self.count];
    [self.tableview reloadData];
    [refreshControl endRefreshing];
}


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    TweetCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tweetCell" forIndexPath:indexPath];
    [cell setTweet: self.tweets[indexPath.row]];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tweets.count;
}


- (void)didTweet:(Tweet *)tweet {
    NSMutableArray *temp = [NSMutableArray arrayWithArray:self.tweets];
    [temp addObject:tweet];
    [self.tableview reloadData];
    UIRefreshControl *refCont = [[UIRefreshControl alloc] init];
    [self beginRefresh:(refCont)];
}
- (IBAction)logoutIsTapped:(id)sender {
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    appDelegate.window.rootViewController = loginViewController;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
   // if ([segue.identifier isEqualToString: @"settingsTransition"]){
    if([segue.destinationViewController isKindOfClass:[DetailsViewController class] ]){
        UITableViewCell *tappedCell = sender;
        NSIndexPath *indexPath = [self.tableview indexPathForCell:tappedCell];
        Tweet *tweet = self.tweets[indexPath.row];
        DetailsViewController *detailsViewController = [segue destinationViewController];
        detailsViewController.tweet = tweet;
    }
    else{
        UINavigationController *navigationController = [segue destinationViewController];
        ComposeViewController *composeController = (ComposeViewController*)navigationController.topViewController;
        composeController.delegate = self;
    };
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if(!self.isMoreDataLoading){
        // Calculate the position of one screen length before the bottom of the results
        int scrollViewContentHeight = self.tableview.contentSize.height;
        int scrollOffsetThreshold = scrollViewContentHeight - self.tableview.bounds.size.height;

        // When the user has scrolled past the threshold, start requesting
        if(scrollView.contentOffset.y > scrollOffsetThreshold && self.tableview.isDragging) {
             self.count += 20;
            self.isMoreDataLoading = true;
            CGRect frame = CGRectMake(0, self.tableview.contentSize.height, self.tableview.bounds.size.width, InfiniteScrollActivityView.defaultHeight);
            self.loadingMoreView.frame = frame;
            [self.loadingMoreView startAnimating];
            [[APIManager shared] getHomeTimelineWithCompletion:^(NSArray *tweets, NSError *error) {
                if (tweets) {
                    NSLog(@"😎😎😎 Successfully loaded home timeline");
                    self.isMoreDataLoading = NO;
                    self.tweets = tweets;
                    [self.tableview reloadData];
                    [self.loadingMoreView stopAnimating];
                    
                } else {
                    NSLog(@"😫😫😫 Error getting home timeline: %@", error.localizedDescription);
                }
            }count:self.count];
        }
    }
}




@end
