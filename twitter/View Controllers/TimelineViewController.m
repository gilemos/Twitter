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

@interface TimelineViewController () <ComposeViewControllerDelegate, UITableViewDataSource, UITableViewDelegate>

//This property is an array containing all our tweets
@property (strong, nonatomic) NSMutableArray* arrayOfTweets;

//This is the table view for the timeline
@property (weak, nonatomic) IBOutlet UITableView *TimelineTableView;

//This is the refresh control that goes on top and refreshes when you scroll down
@property (strong, nonatomic) UIRefreshControl * refreshControl;

@end

@implementation TimelineViewController

//Method that is called as soon as the screen first lauches. It sets who is the delagate and the data source, sets the refresh control and calls the method to load all out tweet data.
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Adding the refresh
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(beginRefresh:) forControlEvents:UIControlEventValueChanged];
    
    //Setting the delegate and the datasource
    self.TimelineTableView.delegate = self;
    self.TimelineTableView.dataSource =self;
    
    //inserting the refresh at the top
    [self.TimelineTableView insertSubview:self.refreshControl atIndex:0];
    
    //Reloading all our data
    [self reloadEverything];
    
}

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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//This is a method for the refresh control. It is only called by the rerfesh control and its only function is to call the method reload everything so we can reload our tweet data and get more tweets for the timeline
- (void)beginRefresh:(UIRefreshControl *)refreshControl {
    [self reloadEverything];
    
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    UINavigationController *navigationController = [segue destinationViewController];
    ComposeViewController *composeController = (ComposeViewController*)navigationController.topViewController;
    
    composeController.delegate = self;
}



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


-(void)didTweet:(Tweet *) tweet {
    [self.arrayOfTweets addObject:tweet];
    [self.TimelineTableView reloadData];
}

@end
