//
//  DBHelper.m
//  RCloudMessage
//
//  Created by 杜立召 on 15/5/22.
//  Copyright (c) 2015年 RongCloud. All rights reserved.
//

#import "BTDBHelper.h"
#import "FMDatabase.h"
#import "FMDatabaseQueue.h"
@implementation BTDBHelper

static FMDatabaseQueue *databaseQueue = nil;

+ (FMDatabaseQueue *)getDatabaseQueue
{
    if (!databaseQueue) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentDirectory = [paths objectAtIndex:0];
        NSString *dbPath = [documentDirectory stringByAppendingPathComponent:@"user.sqlite"];
        databaseQueue = [FMDatabaseQueue databaseQueueWithPath:dbPath];
    }
    
    return databaseQueue;
    
}

+ (BOOL) isTableOK:(NSString *)tableName withDB:(FMDatabase *)db
{
    BOOL isOK = NO;
    
    FMResultSet *rs = [db executeQuery:@"select count(*) as 'count' from sqlite_master where type ='table' and name = ?", tableName];
    while ([rs next])
    {
        NSInteger count = [rs intForColumn:@"count"];
        
        if (0 == count)
        {
            isOK =  NO;
        }
        else
        {
            isOK = YES;
        }
    }
    [rs close];
    
    return isOK;
}

@end
