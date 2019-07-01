//
//  TweetCell.h
//  twitter
//
//  Created by gilemos on 7/1/19.
//  Copyright © 2019 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"

NS_ASSUME_NONNULL_BEGIN

@interface TweetCell : UITableViewCell

//The profile picture of the user who wrote the tweet
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;

//The public screen name of the person who wrote the tweet
@property (weak, nonatomic) IBOutlet UILabel *screenNameLabel;

//The name/id of the person who wrote the tweet
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

//The label showing the date when the tweet was published
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

//The label containig the tweet itself
@property (weak, nonatomic) IBOutlet UILabel *tweetLabel;

//The number of replies the tweet got
@property (weak, nonatomic) IBOutlet UILabel *replyNumberLabel;

//The number of retweets the tweet got
@property (weak, nonatomic) IBOutlet UILabel *retweetNumberLabel;

//The number of likes/hearts the tweet got
@property (weak, nonatomic) IBOutlet UILabel *loveNumberLabel;

//The tweet object containing the information about the tweet
@property (strong, nonatomic) Tweet *tweet;

@end

NS_ASSUME_NONNULL_END
