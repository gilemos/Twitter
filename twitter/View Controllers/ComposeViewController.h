//
//  ComposeViewController.h
//  
//
//  Created by gilemos on 7/1/19.
//


#import <UIKit/UIKit.h>
#import "Tweet.h"

NS_ASSUME_NONNULL_BEGIN

@protocol ComposeViewControllerDelegate
@required
-(void)didTweet:(Tweet *) tweet;
@end

@interface ComposeViewController : UIViewController

@property (nonatomic, weak) id<ComposeViewControllerDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
