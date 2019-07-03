//
//  FriendProfileViewController.m
//  twitter
//
//  Created by gilemos on 7/3/19.
//  Copyright © 2019 Emerson Malca. All rights reserved.
//

#import "FriendProfileViewController.h"
#import "ProfileCell.h"

@interface FriendProfileViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *FriendProfileTableView;

@end

@implementation FriendProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.FriendProfileTableView.delegate = self;
    self.FriendProfileTableView.dataSource = self;
}

//This method creates a cell at the index path
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    ProfileCell *cell = (ProfileCell*) [tableView dequeueReusableCellWithIdentifier:@"profilecell" forIndexPath:indexPath];
    cell.user = self.user;
    [cell refreshData];
    return cell;
}

//This method tells how many cells there are
- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
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
