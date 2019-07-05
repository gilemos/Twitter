//
//  Tweet.m
//  twitter
//
//  Created by gilemos on 7/1/19.
//  Copyright © 2019 Emerson Malca. All rights reserved.
//

#import "Tweet.h"

@implementation Tweet

#pragma mark - Initialization methods
// This method initializes the properties based on the dictionary returned from the API
- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        [self retweetCheckWithDictionary:dictionary];
        self.idString = dictionary[@"id_str"];
        self.text = dictionary[@"text"];
        self.favoriteCount = [dictionary[@"favorite_count"] intValue];
        self.favorited = [dictionary[@"favorited"] boolValue];
        self.retweetCount = [dictionary[@"retweet_count"] intValue];
        self.retweeted = [dictionary[@"retweeted"] boolValue];
        
        //Initializing the user
        NSDictionary *user = dictionary[@"user"];
        self.user = [[User alloc] initWithDictionary:user];
        
        //Formatting and setting createdAtString and tweetDate
        [self DateFormattingWithDictionary:dictionary];
    }
    return self;
}

//This method returns an array of all tweets initialized with an array of tweet dictionaries
+ (NSMutableArray *)tweetsWithArray:(NSArray *)dictionaries{
    NSMutableArray *tweets = [NSMutableArray array];
    for (NSDictionary *dictionary in dictionaries) {
        Tweet *tweet = [[Tweet alloc] initWithDictionary:dictionary];
        [tweets addObject:tweet];
    }
    return tweets;
}

#pragma mark - Helper Methods
-(void)retweetCheckWithDictionary:(NSDictionary *)dictionary {
    // Is this a re-tweet?
    NSDictionary *originalTweet = dictionary[@"retweeted_status"];
    //If it is a retweet, then set the property retweeted by user
    if(originalTweet != nil){
        NSDictionary *userDictionary = dictionary[@"user"];
        self.retweetedByUser = [[User alloc] initWithDictionary:userDictionary];
        // Change tweet to original tweet
        dictionary = originalTweet;
    }
}

-(void)DateFormattingWithDictionary:(NSDictionary *)dictionary {
    //The original string is in the format “Wed Aug 27 13:08:45 +0000 2008”
    NSString *createdAtOriginalString = dictionary[@"created_at"];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    // Configuring the input format to parse the date string
    formatter.dateFormat = @"E MMM d HH:mm:ss Z y";
    // Converting String to Date format
    NSDate *date = [formatter dateFromString:createdAtOriginalString];
    // Configuring output format
    formatter.dateStyle = NSDateFormatterShortStyle;
    formatter.timeStyle = NSDateFormatterNoStyle;
    self.createdAtString = [formatter stringFromDate:date];
    self.tweetDate = date;
}


@end
