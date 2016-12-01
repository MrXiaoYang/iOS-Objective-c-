//
//  User.m
//  LXZEALER
//
//  Created by Lonely Stone on 16/1/27.
//  Copyright © 2016年 LonelyStone. All rights reserved.
//

#import "User.h"

@implementation User

- (void)encodeWithCoder:(NSCoder *)aCoder {
    
    [aCoder encodeObject:self.name forKey:@"name"];
    
    [aCoder encodeObject:self.userDescription forKey:@"userDescription"];
    
    [aCoder encodeObject:self.gender forKey:@"gender"];
    
    [aCoder encodeObject:self.avatar_large forKey:@"avatar_large"];
    
    [aCoder encodeObject:@(self.id) forKey:@"id"];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    
    self = [super init];
    
    if (self) {
        
        self.id = [[aDecoder decodeObjectForKey:@"id"] integerValue];
        
        self.name = [aDecoder decodeObjectForKey:@"name"];
        
        self.userDescription = [aDecoder decodeObjectForKey:@"userDescription"];
        
        self.gender = [aDecoder decodeObjectForKey:@"gender"];
        
        self.avatar_large = [aDecoder decodeObjectForKey:@"avatar_large"];
    }
    return self;
}
@end
