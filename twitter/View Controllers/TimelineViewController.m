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

@interface TimelineViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSArray* arrayOfTweets;
@property (weak, nonatomic) IBOutlet UITableView *TimelineTableView;

@end

@implementation TimelineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.TimelineTableView.delegate = self;
    self.TimelineTableView.dataSource =self;
    
    //Adding the refresh
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(beginRefresh:) forControlEvents:UIControlEventValueChanged];
    
    [self.TimelineTableView insertSubview:refreshControl atIndex:0];
    
    // Get timeline
    [[APIManager shared] getHomeTimelineWithCompletion:^(NSArray *tweets, NSError *error) {
        if (tweets) {
            NSLog(@"😎😎😎 Successfully loaded home timeline");
            for (Tweet *tweet in tweets) {
                NSString *text = tweet.text;
                NSLog(@"%@", text);
            }
            
            self.arrayOfTweets = tweets;
            
            [refreshControl endRefreshing];
            
            
        } else {
            NSLog(@"😫😫😫 Error getting home timeline: %@", error.localizedDescription);
        }
        
        [self.TimelineTableView reloadData];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    TweetCell *cell = (TweetCell *) [tableView dequeueReusableCellWithIdentifier:@"tweetCell" forIndexPath:indexPath];
    
    
    Tweet *curTweet = self.arrayOfTweets[indexPath.row];
    
    User *curUser = curTweet.user;
    
    cell.screenNameLabel.text = curUser.screenName;
    
    cell.nameLabel.text = curUser.name;
    
    cell.dateLabel.text = curTweet.createdAtString;
    
    cell.tweetLabel.text = curTweet.text;
    
    cell.loveNumberLabel.text = [NSString stringWithFormat:@"%d",curTweet.favoriteCount];
    
    cell.retweetNumberLabel.text = [NSString stringWithFormat:@"%d", curTweet.retweetCount];
    
    //Getting the profile image
    
    NSString *photoLinkString = curUser.photoLink;
    
    NSURL *photoURL = [NSURL URLWithString:photoLinkString];
    
    [cell.profileImage setImageWithURL:photoURL];
    
    return cell;
    
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrayOfTweets.count;
}


@end
