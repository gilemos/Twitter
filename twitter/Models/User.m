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
        self.name = dictionary[@"name"];
        self.screenName = dictionary[@"screen_name"];
        self.photoLink = dictionary[@"profile_image_url_https"];
    }
    
    return self;
}
@end


