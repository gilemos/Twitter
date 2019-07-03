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
@property (strong, nonatomic) NSString * idString;
@property (strong, nonatomic) NSString * text;
@property(nonatomic) int favoriteCount;
@property(nonatomic) BOOL favorited;
@property(nonatomic) int retweetCount;
@property(nonatomic) BOOL retweeted;
@property(strong, nonatomic) User *user;
@property(strong, nonatomic) NSString *createdAtString;

// ----- FOR RETWEETS -----
@property (strong, nonatomic) User *retweetedByUser;

// ----- METHODS -----
+ (NSMutableArray *)tweetsWithArray:(NSArray *)dictionaries;
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
