//
//  FriendProfileViewController.h
//  twitter
//
//  Created by gilemos on 7/3/19.
//  Copyright © 2019 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

NS_ASSUME_NONNULL_BEGIN

@interface FriendProfileViewController : UIViewController
@property(strong, nonatomic) User *user;

@end

NS_ASSUME_NONNULL_END
