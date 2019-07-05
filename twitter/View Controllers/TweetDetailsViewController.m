//
//  TweetDetailsViewController.m
//  twitter
//
//  Created by gilemos on 7/2/19.
//  Copyright © 2019 Emerson Malca. All rights reserved.
//

#import "TweetDetailsViewController.h"
#import "TweetCell.h"
#import "FriendProfileViewController.h"
#import "Tweet.h"
#import "User.h"

@interface TweetDetailsViewController () <UITableViewDataSource, UITableViewDelegate, TweetCellDelegate>
@property (weak, nonatomic) IBOutlet UITableView *TweetDetailsTableView;
@end

@implementation TweetDetailsViewController

#pragma mark - View lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    //Setting the delegate and the datasource
    self.TweetDetailsTableView.delegate = self;
    self.TweetDetailsTableView.dataSource = self;
}

#pragma mark - table view protocols
//This method creates a cell at the index path
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    TweetCell *cell = (TweetCell *) [tableView dequeueReusableCellWithIdentifier:@"tweetCell" forIndexPath:indexPath];
    cell.delegate = self;
    cell.tweet = self.tweet;
    [cell refreshData];
    return cell;
}

//This method tells how many cells there are
- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

#pragma mark - Navigation
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    Tweet *curTweet = self.tweet;
    User *curUser = curTweet.user;
    FriendProfileViewController *friendsProfileViewController = [segue destinationViewController];
    [friendsProfileViewController setUser:curUser];
}

- (void)tweetCell:(TweetCell *)tweetCell didTap:(User *)user{
    [self performSegueWithIdentifier:@"friendProfileSegue" sender:user];
}

@end
