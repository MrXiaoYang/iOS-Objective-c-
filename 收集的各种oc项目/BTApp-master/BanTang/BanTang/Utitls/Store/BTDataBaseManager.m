//
//  RCDataBaseManager.m
//  RCloudMessage
//
//  Created by 杜立召 on 15/6/3.
//  Copyright (c) 2015年 dlz. All rights reserved.
//

#import "BTDataBaseManager.h"
#import "BTDBHelper.h"
#import "BTHomePageData.h"
#import "BTHomeBanner.h"
@implementation BTDataBaseManager

static NSString * const homeTableName = @"HOMETABLE";
static NSString * const bannerTableName = @"BANNERTABLEV2";

+ (BTDataBaseManager*)shareInstance
{
    static BTDataBaseManager* instance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        instance = [[[self class] alloc] init];
        [instance createUserTable];
    });
    return instance;
}

//创建用户存储表
- (void)createUserTable
{
    FMDatabaseQueue *queue = [BTDBHelper getDatabaseQueue];
    if (queue==nil) {
        return;
    }
    [queue inDatabase:^(FMDatabase *db) {
        if (![BTDBHelper isTableOK:homeTableName withDB:db]) {
            NSString *createTableSQL = @"CREATE TABLE HOMETABLE (id integer PRIMARY KEY autoincrement, data blob,page integer)";
            [db executeUpdate:createTableSQL];
        }
        
        if (![BTDBHelper isTableOK:bannerTableName withDB:db]) {
            NSString *createTableSQL = @"CREATE TABLE BANNERTABLEV2 (id integer PRIMARY KEY autoincrement, data blob)";
            [db executeUpdate:createTableSQL];
        }
    }];
    
}

// 插入homePageData
- (void)insertHomePageDataToDB:(BTHomePageData *)pageData page:(NSInteger)page
{
    NSString *insertSql = @"REPLACE INTO HOMETABLE (data, page) VALUES (?, ?)";
    
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:pageData];
    
    FMDatabaseQueue *queue = [BTDBHelper getDatabaseQueue];
    
    [queue inDatabase:^(FMDatabase *db) {
        [db executeUpdate:insertSql,data,[NSNumber numberWithInteger:page]];
    }];
}

// 获取homePageData
- (BTHomePageData *)getPageDataWithPage:(NSInteger)page
{
    __block BTHomePageData * homePageData = nil;
    __block NSData *data = nil;
    FMDatabaseQueue *queue = [BTDBHelper getDatabaseQueue];
    if (queue==nil) {
        return nil;
    }
    [queue inDatabase:^(FMDatabase *db) {
        FMResultSet *rs = [db executeQuery:@"SELECT * FROM HOMETABLE where page = ?",[NSNumber numberWithInteger:page]];
        while ([rs next]) {
            data = [rs dataForColumn:@"data"];
        
            homePageData = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        }
        [rs close];
    }];

    return  homePageData;
}

// 插入bannerData
- (void)inserthomeBannerDataToDB:(NSArray *)pageDataArray
{
    NSString *insertSql = @"REPLACE INTO BANNERTABLEV2 (data) VALUES (?)";

    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:pageDataArray];
    
    FMDatabaseQueue *queue = [BTDBHelper getDatabaseQueue];
    
    [queue inDatabase:^(FMDatabase *db) {
        [db executeUpdate:insertSql,data];
    }];

}
// 获取bannerData
- (NSArray *)getbannerData
{
    __block NSArray *array = nil;
    FMDatabaseQueue *queue = [BTDBHelper getDatabaseQueue];
    if (queue==nil) {
        return nil;
    }
    [queue inDatabase:^(FMDatabase *db) {
        FMResultSet *rs = [db executeQuery:@"SELECT * FROM BANNERTABLEV2"];
        while ([rs next]) {
            NSData *data = [rs dataForColumn:@"data"];
            array = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        }
        [rs close];
    }];
    return array;
}

@end
