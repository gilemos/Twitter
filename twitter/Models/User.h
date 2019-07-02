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

//This is the name of the user as he or she was registered in the twitter
@property (strong, nonatomic) NSString *name;

//This is the name of the user that appears for his friends and followers
@property (strong, nonatomic) NSString *screenName;

//This is the link where the photo of the user is
@property(strong, nonatomic) NSString *photoLink;

//This method sets all our properties based on the dictionary that is returned from the API
- (instancetype)initWithDictionary:(NSDictionary *) dictionary;

@end

NS_ASSUME_NONNULL_END
