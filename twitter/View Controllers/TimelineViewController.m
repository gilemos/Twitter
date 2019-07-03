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
#import "UIImageView+AFNetworking.h"
#import "ComposeViewController.h"
#import "AppDelegate.h"
#import "LoginViewController.h"
#import "TweetDetailsViewController.h"
#import "FriendProfileViewController.h"

@interface TimelineViewController () <ComposeViewControllerDelegate, UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSMutableArray* arrayOfTweets;
@property (weak, nonatomic) IBOutlet UITableView *TimelineTableView;
@property (strong, nonatomic) UIRefreshControl * refreshControl;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *logoutButton;

@end

@implementation TimelineViewController

#pragma mark - Flow of the app
//Method that is called as soon as the screen first lauches. It sets who is the delegate and the data source, sets the refresh control and calls the method to load all out tweet data.
- (void)viewDidLoad {
    [super viewDidLoad];
    //Adding the refresh
    [self setRefreshControl];
    
    //Setting the delegate and the datasource
    self.TimelineTableView.delegate = self;
    self.TimelineTableView.dataSource =self;
    
    //Reloading all the data
    [self reloadEverything];
}

#pragma mark - table view protocols
//This method creates a cell at the index path
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    TweetCell *cell = (TweetCell *) [tableView dequeueReusableCellWithIdentifier:@"tweetCell" forIndexPath:indexPath];
    Tweet *curTweet = self.arrayOfTweets[indexPath.row];
    cell.tweet = curTweet;
    [cell refreshData];
    return cell;
}

//This method tells how many cells there are
- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrayOfTweets.count;
}


#pragma mark - Helper Methods
//This method is responsible for stablishing network connection and loading/reloading all our tweet data
-(void)reloadEverything {
    // Get timeline
    [[APIManager shared] getHomeTimelineWithCompletion:^(NSArray *tweets, NSError *error) {
        //in case we were able to stablish network connection
        if (tweets) {
            NSLog(@"😎😎😎 Successfully loaded home timeline");
            //printing all texts from the tweets to NSLog so we can see what is going on
            for (Tweet *tweet in tweets) {
                NSString *text = tweet.text;
                NSLog(@"%@", text);
            }
            //Building out array of tweets
            self.arrayOfTweets = tweets;
            //In case the network connection fails
        } else {
            NSLog(@"😫😫😫 Error getting home timeline: %@", error.localizedDescription);
        }
        //End refreshing
        [self.refreshControl endRefreshing];
        
        //Reload data once we stablish the connection
        [self.TimelineTableView reloadData];
    }];
}

-(void)setRefreshControl{
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(beginRefresh:) forControlEvents:UIControlEventValueChanged];
    [self.TimelineTableView insertSubview:self.refreshControl atIndex:0]; //inserting the refresh at the top
}

//This is a method for the refresh control. It is only called by the rerfesh control and its only function is to call the method reload everything so we can reload our tweet data and get more tweets for the timeline
- (void)beginRefresh:(UIRefreshControl *)refreshControl {
    [self reloadEverything];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//Adds a new tweet to the array of tweets and reloads data
-(void)didTweet:(Tweet *) tweet {
    [self.arrayOfTweets addObject:tweet];
    [self.TimelineTableView reloadData];
}

#pragma mark - Navigation
//This method defines what to do when you click in the logout buttom. It leaves the view controller and goes back to the log in screen
- (IBAction)logout:(id)sender {
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    appDelegate.window.rootViewController = loginViewController;
    [[APIManager shared] logout];
}

// Prepares to go to the next screen
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    //----- Going to the composer
    if([[segue identifier] isEqualToString:@"segueToCompose"]) {
    [self ComposerSegue:segue];
    }
    else if([[segue  identifier] isEqualToString:@"segueToTweetDetails"]) {
    //-----Going to tweetDetails
    [self TweetDetailsSegue:segue sender:sender];
    }
}

#pragma mark - Helper methods for navigation
-(void)ComposerSegue:(UIStoryboardSegue *)segue{
    UINavigationController *navigationController = [segue destinationViewController];
    ComposeViewController *composeController = (ComposeViewController*)navigationController.topViewController;
    composeController.delegate = self;
}

-(void)TweetDetailsSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    TweetCell *tappedCell = sender;
    Tweet *curTweet = tappedCell.tweet;
    TweetDetailsViewController *tweetdetailsViewController = [segue destinationViewController];
    [tweetdetailsViewController setTweet:curTweet];
}

@end
