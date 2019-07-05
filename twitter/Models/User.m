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
    self = [super init];
    if (self) {
        self.name = dictionary[@"name"];
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
@end


