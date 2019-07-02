//
//  Tweet.h
//  twitter
//
//  Created by gilemos on 7/1/19.
//  Copyright © 2019 Emerson Malca. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

NS_ASSUME_NONNULL_BEGIN

@interface Tweet : NSObject


// ---- GENERAL PROPERTIES -----

//This property is an unique identifier for the tweet in string format
@property (strong, nonatomic) NSString * idString;

//This property contains the text of the tweet
@property (strong, nonatomic) NSString * text;

//This property shows the number of favourites that the tweet has
@property(nonatomic) int favoriteCount;

//This property indicated wheater the tweet is favourited (the little heart is red) or not
@property(nonatomic) BOOL favorited;

//This property shows the number of times the tweet was retweeted
@property(nonatomic) int retweetCount;

//This property shows wheater the tweet was retweeted or not
@property(nonatomic) BOOL retweeted;

//This property indicates who is the user that created the tweet. It includes the name and screen name of the
//user
@property(strong, nonatomic) User *user;

//This property is a string with the date when the tweet was published
@property(strong, nonatomic) NSString *createdAtString;



// ----- FOR RETWEETS -----

//This property indicates the user who retweeted the tweet
@property (strong, nonatomic) User *retweetedByUser;


// ----- METHODS -----
+ (NSMutableArray *)tweetsWithArray:(NSArray *)dictionaries;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
