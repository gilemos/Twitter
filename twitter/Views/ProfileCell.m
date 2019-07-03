//
//  ProfileCell.m
//  twitter
//
//  Created by gilemos on 7/3/19.
//  Copyright © 2019 Emerson Malca. All rights reserved.
//

#import "ProfileCell.h"
#import "UIImageView+AFNetworking.h"

@implementation ProfileCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)refreshData {
    self.screenName.text = self.user.screenName;
    self.Name.text = self.user.name;
    self.numTweets.text = [NSString stringWithFormat:@"%li", (long)self.user.tweetsCount];
    self.numFollowing.text = [NSString stringWithFormat:@"%li", (long)self.user.followingCount];
    self.numFollowers.text = [NSString stringWithFormat:@"%li", (long)self.user.followesCount];
    self.userDescription.text = self.user.userDescription;
    
    //Getting the profile and cover image
    NSString *photoLinkString = self.user.photoLink;
    NSString *coverLinkString = self.user.coverLink;
    
    NSURL *photoURL = [NSURL URLWithString:photoLinkString];
    NSURL *coverURL = [NSURL URLWithString:coverLinkString];
    
    [self.profileImage setImageWithURL:photoURL];
    [self.coverImage setImageWithURL:coverURL];
}

@end
