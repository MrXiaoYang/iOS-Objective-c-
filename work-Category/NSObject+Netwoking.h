//
//  NSObject+Netwoking.h

//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>

@interface NSObject (Netwoking)

+ (id)GET:(NSString *)path parameters:(NSDictionary *)parameters progress:(void(^)(NSProgress *downloadProgress))downloadProgress completionHandler:(void(^)(id responseObj, NSError *error))completionHandler;

+ (id)POST:(NSString *)path parameters:(NSDictionary *)parameters progress:(void(^)(NSProgress *downloadProgress))downloadProgress completionHandler:(void(^)(id responseObj, NSError *error))completionHandler;

@end









