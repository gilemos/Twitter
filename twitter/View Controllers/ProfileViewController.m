//
//  ProfileViewController.m
//  twitter
//
//  Created by gilemos on 7/3/19.
//  Copyright © 2019 Emerson Malca. All rights reserved.
//

#import "ProfileViewController.h"
#import "ProfileCell.h"
#import "APIManager.h"
#import "User.h"
#import "UIImageView+AFNetworking.h"

@interface ProfileViewController () <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *profileTableView;
@property (strong, nonatomic) User* user;

@end

@implementation ProfileViewController

#pragma mark - flow of the app
- (void)viewDidLoad {
    [super viewDidLoad];
    // Setting the delegate and the datasource
    self.profileTableView.delegate = self;
    self.profileTableView.dataSource = self;
    
}


#pragma mark - Table View Protocols

//This method creates a cell at the index path
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    ProfileCell *cell = (ProfileCell*) [tableView dequeueReusableCellWithIdentifier:@"profilecell" forIndexPath:indexPath];
    [self callForUser];
    cell.user = self.user;
    [self refreshDataFromCell:cell];
    return cell;
}

//This method tells how many cells there are
- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

-(void)callForUser {
    [[APIManager shared] getUserWithCompletion:^(NSDictionary *userDictionary, NSError *error) {
        //in case we were able to stablish network connection
        if (userDictionary) {
            NSLog(@"😎😎😎 GOT USER");
            self.user = [[User alloc] initWithDictionary:userDictionary];
            //In case the network connection fails
        } else {
            NSLog(@"😫😫😫 Error getting home timeline: %@", error.localizedDescription);
        }
        [self.profileTableView reloadData];
    }];
}

-(void)refreshDataFromCell:(ProfileCell*)cell{
    cell.screenName.text = self.user.screenName;
    cell.Name.text = self.user.name;
    cell.numTweets.text = [NSString stringWithFormat:@"%li", (long)self.user.tweetsCount];
    cell.numFollowing.text = [NSString stringWithFormat:@"%li", (long)self.user.followingCount];
    cell.numFollowers.text = [NSString stringWithFormat:@"%li", (long)self.user.followesCount];
    cell.userDescription.text = self.user.userDescription;
    
    //Getting the profile and cover image
    NSString *photoLinkString = self.user.photoLink;
    NSString *coverLinkString = self.user.coverLink;
    
    NSURL *photoURL = [NSURL URLWithString:photoLinkString];
    NSURL *coverURL = [NSURL URLWithString:coverLinkString];
    
    [cell.profileImage setImageWithURL:photoURL];
    [cell.coverImage setImageWithURL:coverURL];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
