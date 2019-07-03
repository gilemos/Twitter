//
//  TweetDetailsViewController.h
//  twitter
//
//  Created by gilemos on 7/2/19.
//  Copyright © 2019 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"

NS_ASSUME_NONNULL_BEGIN

@interface TweetDetailsViewController : UIViewController
@property (weak, nonatomic) Tweet * tweet;
@end

NS_ASSUME_NONNULL_END
