//
//  JKNetStatusManager.m
//
//  Created by sjk on 2019/5/10.
//  Copyright © 2019 sjk. All rights reserved.
//

#import "JKNetStatusManager.h"
#import "AFNetworking.h"


static JKNetStatusManager * manager;

@interface JKNetStatusManager ()
@property(nonatomic, assign) netStatus netWorkStatus;
@end
@implementation JKNetStatusManager
+(instancetype)manager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[[self class] alloc] init];
    });
    return manager;
}
-(netStatus)getNetWorkStatus
{
    return self.netWorkStatus;
}
-(void)listeningToNetStatus
{
    // 1.获得网络监控的管理者
    AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
    
    // 2.设置网络状态改变后的处理
    [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status)
    {
        // 当网络状态改变了, 就会调用这个block
        
        if (status == AFNetworkReachabilityStatusReachableViaWiFi) {
            NSLog(@"已连接Wi-Fi网络");
            self.netWorkStatus = netStatusWifi;
        }else if (status == AFNetworkReachabilityStatusReachableViaWWAN){
            NSLog(@"已连接蜂窝移动网络");
            self.netWorkStatus = netStatusMobil;
        }else if (status == AFNetworkReachabilityStatusUnknown){
            NSLog(@"已连接未知网络");
            self.netWorkStatus = netStatusUnkonw;
        }else if (status == AFNetworkReachabilityStatusNotReachable){
            NSLog(@"没有网络(断网)");
            self.netWorkStatus = netStatusNo;
        }
        else
        {
            NSLog(@"网络异常");
            self.netWorkStatus = netStatusImpossible;
        }
    }];
    [mgr startMonitoring];
}
@end
