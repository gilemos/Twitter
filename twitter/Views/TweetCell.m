//
//  TweetCell.m
//  twitter
//
//  Created by gilemos on 7/1/19.
//  Copyright © 2019 Emerson Malca. All rights reserved.
//

#import "TweetCell.h"
#import "User.h"
#import "Tweet.h"
#import "UIImageView+AFNetworking.h"
#import "APIManager.h"
#import "DateTools.h"

@implementation TweetCell

#pragma mark - View lifecycle
- (void)awakeFromNib {
    [super awakeFromNib];
    self.profileTapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didTapPicture:)];
}

#pragma mark - Button functions (like, retweet and reply)
//Function for tapping the like buttom
- (IBAction)didTapLike:(id)sender {
    //If it not favorited yet
    if(self.tweet.favorited == NO) {
        self.tweet.favorited = YES;
        self.tweet.favoriteCount += 1;
        self.isFavourited.selected = YES;
        [[APIManager shared] favorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully favorited the following Tweet: %@", tweet.text);
            }
        }];
    }
    //If it is favourited
    else {
        self.tweet.favorited = NO;
        self.tweet.favoriteCount -= 1;
        self.isFavourited.selected = NO;
        [[APIManager shared] unFavorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                NSLog(@"Error unfavoriting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully unfavorited the following Tweet: %@", tweet.text);
            }
        }];
    }
    [self refreshData];
}

//Function for retweeting
- (IBAction)tapRetweet:(id)sender {
    //If it is not retweeted yet
    if(self.tweet.retweeted == NO) {
        self.tweet.retweeted = YES;
        self.tweet.retweetCount += 1;
        self.isRetweeted.selected = YES;
        [[APIManager shared] retweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully favorited the following Tweet: %@", tweet.text);
            }
        }];
    }
    //If it is retweeted
    else {
        self.tweet.retweeted = NO;
        self.tweet.retweetCount -= 1;
        self.isRetweeted.selected = NO;
        
        [[APIManager shared] unRetweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                NSLog(@"Error unfavoriting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully unfavorited the following Tweet: %@", tweet.text);
            }
        }];
    }
    [self refreshData];
}

- (IBAction)didTapPicture:(id)sender {
    [self.delegate tweetCell:self didTap:self.tweet.user];
}


#pragma mark - helper methods
//Refreshing the data of the tweet
-(void) refreshData {
    User *user = self.tweet.user;
    self.screenNameLabel.text = user.name;
    self.nameLabel.text = [NSString stringWithFormat:@"@%@", user.screenName];
    self.dateLabel.text = self.tweet.createdAtString;
    self.tweetLabel.text = self.tweet.text;
    self.loveNumberLabel.text = [NSString stringWithFormat:@"%d",self.tweet.favoriteCount];
    self.retweetNumberLabel.text = [NSString stringWithFormat:@"%d", self.tweet.retweetCount];
    self.timeAgoLabel.text = self.tweet.tweetDate.shortTimeAgoSinceNow;
    
    //Getting the profile image
    NSString *photoLinkString = user.photoLink;
    NSURL *photoURL = [NSURL URLWithString:photoLinkString];
    [self.profileImage setImageWithURL:photoURL];
    
    //Putting action in picture
    [self.profileImage addGestureRecognizer:self.profileTapGestureRecognizer];
    [self.profileImage setUserInteractionEnabled:YES];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end
