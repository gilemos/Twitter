//
//  ProfileCell.h
//  twitter
//
//  Created by gilemos on 7/3/19.
//  Copyright © 2019 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProfileCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *coverImage;
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UILabel *screenName;
@property (weak, nonatomic) IBOutlet UILabel *Name;
@property (weak, nonatomic) IBOutlet UILabel *numTweets;
@property (weak, nonatomic) IBOutlet UILabel *numFollowing;
@property (weak, nonatomic) IBOutlet UILabel *numFollowers;
@property (weak, nonatomic) IBOutlet UILabel *userDescription;
@property (strong, nonatomic) User* user;

-(void)refreshData;

@end

NS_ASSUME_NONNULL_END
