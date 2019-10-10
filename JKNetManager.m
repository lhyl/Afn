//
//  JKNetManager.m
//
//  Created by sjk on 2019/5/10.
//  Copyright © 2019 sjk. All rights reserved.
//

#import "JKNetManager.h"
#import "JKNetStatusManager.h"
static AFHTTPSessionManager * sessionManager = nil;
@interface JKNetManager()
@property(nonatomic, strong) AFHTTPSessionManager * manager;
@end

@implementation JKNetManager
+ (id)POST:(NSString *)URLString
                    parameters:(id)parameters
                      progress:(void (^)(NSProgress * _Nonnull))uploadProgress
                       success:(void (^)(NSURLSessionDataTask * _Nonnull, id _Nullable))success
                       failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure
{
    if ([[JKNetStatusManager manager] getNetWorkStatus] == netStatusNo) {
        NSError * error = [[NSError alloc] initWithDomain:NSCocoaErrorDomain code:-1 userInfo:@{NSLocalizedDescriptionKey:@"没有网络"}];
        failure(nil, error);
        return nil;
    }
    return [[JKNetManager  sharedSessionManager] POST:URLString parameters:parameters progress:uploadProgress success:success failure:failure];
}
- (id)POST:(NSString *)URLString
                    parameters:(id)parameters
                      progress:(void (^)(NSProgress * _Nonnull))uploadProgress
                       success:(void (^)(NSURLSessionDataTask * _Nonnull, id _Nullable))success
                       failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure
{
    if ([[JKNetStatusManager manager] getNetWorkStatus] == netStatusNo) {
        NSError * error = [[NSError alloc] initWithDomain:NSCocoaErrorDomain code:-1 userInfo:@{NSLocalizedDescriptionKey:@"没有网络"}];
        failure(nil, error);
        return nil;
    }
    return [self.manager POST:URLString parameters:parameters progress:uploadProgress success:success failure:failure];
}
-(__autoreleasing id)GET:(NSString *)URLString parameters:(id)parameters progress:(void (^)(NSProgress * _Nonnull))downloadProgress success:(void (^)(NSURLSessionDataTask * _Nonnull, id _Nullable))success failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure
{
    if ([[JKNetStatusManager manager] getNetWorkStatus] == netStatusNo) {
        NSError * error = [[NSError alloc] initWithDomain:NSCocoaErrorDomain code:-1 userInfo:@{NSLocalizedDescriptionKey:@"没有网络"}];
        failure(nil, error);
        return nil;
    }
    return [self.manager GET:URLString parameters:parameters progress:downloadProgress success:success failure:failure];
}
+(instancetype)manager
{
    JKNetManager *manager = [[[self class] alloc] init];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html",nil];
    return manager;
}
+(AFHTTPSessionManager *)sharedSessionManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sessionManager = [AFHTTPSessionManager manager];
    });
    return sessionManager;
}
-(instancetype)init
{
    if (self = [super init]) {
        self.manager = [JKNetManager  sharedSessionManager];
        self.responseSerializer = self.manager.responseSerializer;
        self.requestSerializer = self.manager.requestSerializer;
    }
    return self;
}
@end
