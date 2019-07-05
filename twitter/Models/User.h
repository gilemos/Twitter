//
//  User.h
//  twitter
//
//  Created by gilemos on 7/1/19.
//  Copyright © 2019 Emerson Malca. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface User : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *screenName;
@property(strong, nonatomic) NSString *photoLink;
@property(strong, nonatomic) NSString *coverLink;
@property(strong, nonatomic) NSString *userDescription;
@property(nonatomic) NSInteger followesCount;
@property(nonatomic) NSInteger followingCount;
@property(nonatomic) NSInteger tweetsCount;

//This method sets all our properties based on the dictionary that is returned from the API
- (instancetype)initWithDictionary:(NSDictionary *) dictionary;

@end

NS_ASSUME_NONNULL_END
