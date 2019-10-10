//
//  JKNetStatusManager.h
//
//  Created by sjk on 2019/5/10.
//  Copyright © 2019 sjk. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef enum eNetStatus{
    netStatusWifi = 1,
    netStatusMobil = 2,
    netStatusUnkonw = 3,
    netStatusNo = 4,
    netStatusImpossible = 5,
} netStatus;
@interface JKNetStatusManager : NSObject
+(instancetype)manager;
-(void)listeningToNetStatus;
-(netStatus)getNetWorkStatus;
@end

NS_ASSUME_NONNULL_END
