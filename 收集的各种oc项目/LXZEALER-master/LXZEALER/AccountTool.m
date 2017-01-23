//
//  AccountTool.m
//  LXZEALER
//
//  Created by Lonely Stone on 16/1/27.
//  Copyright © 2016年 LonelyStone. All rights reserved.
//

#import "AccountTool.h"

@implementation AccountTool

+ (void)saveUserInformation:(User *)user {
    
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:user];
    
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"user"];
}

+ (User*)getUserInformation {
    
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"user"];
    
    User *user = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    
    return user;
}

+ (void)deleteUserInfomation {
    
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"user"];
}
@end
