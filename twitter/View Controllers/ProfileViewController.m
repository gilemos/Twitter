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

#pragma mark - View lifecycle
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
    [cell refreshData];
    return cell;
}

//This method tells how many cells there are
- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

#pragma mark - helper methods
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
    }];
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
