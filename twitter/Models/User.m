//
//  User.m
//  twitter
//
//  Created by gilemos on 7/1/19.
//  Copyright © 2019 Emerson Malca. All rights reserved.
//

#import "User.h"

@implementation User

//This method sets all our properties based on the dictionary that is returned from the API
- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    //Calling the "pseudo-constructor" of the mother class
    self = [super init];
    //If the memory allocation did not fail, proceed
    if (self) {
        //NSLog(@"self worked");
        //NSLog([NSString stringWithFormat:@"%@", dictionary]);
        self.name = dictionary[@"name"];
        //NSLog(self.name);
        self.screenName = dictionary[@"screen_name"];
        self.photoLink = dictionary[@"profile_image_url_https"];
        self.coverLink = dictionary[@"profile_banner_url"];
        self.followesCount = [dictionary[@"followers_count"] integerValue];
        self.followingCount = [dictionary[@"friends_count"] integerValue];
        self.tweetsCount = [dictionary[@"statuses_count"] integerValue];
        self.userDescription = dictionary[@"description"];
    }
    return self;
}


// TO DO: USER STUFF
/*
+ (User *)UserWithArray:(NSArray *)dictionaries{
    for (NSDictionary *dictionary in dictionaries) {
        User *curUser = [[User alloc] initWithDictionary:dictionary];
        return curUser;
    }
    return nil;
}
 */
@end


