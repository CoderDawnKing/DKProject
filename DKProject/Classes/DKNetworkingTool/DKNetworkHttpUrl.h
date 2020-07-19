//
//  DKNetworkHttpUrl.h
//  GardenManager
//
//  Created by 王 on 2019/6/14.
//  Copyright © 2019 wisezone. All rights reserved.
//

#import <DKProject/DKConfigure.h>

#ifdef DEBUG
#define DK_BaseUrl [[NSUserDefaults standardUserDefaults] valueForKey:DK_UrlStringUserDefault]?:DK_DevelopmentUrlString
#else
#define DK_BaseUrl DK_DistributionUrlString
#endif

#ifdef DEBUG
#define DK_BaseH5Url [[NSUserDefaults standardUserDefaults] valueForKey:DK_H5UrlStringUserDefault]?:DK_H5DevelopmentUrlString
#else
#define DK_BaseH5Url DK_H5DistributionUrlString
#endif

/// 测试接口地址
#define DK_DevelopmentUrlString DKCONFIG.dkc_developmentUrlString
/// 正式接口地址
#define DK_DistributionUrlString DKCONFIG.dkc_distributionUrlString

/// h5测试接口地址
#define DK_H5DevelopmentUrlString DKCONFIG.dkc_h5DevelopmentUrlString
/// h5正式接口地址
#define DK_H5DistributionUrlString DKCONFIG.dkc_h5DistributionUrlString

/// 本地接口地址
#define DK_LocalUrlString DKCONFIG.dkc_localUrlString


/// 当前地址
#define DK_UrlStringUserDefault @"DK_UrlStringUserDefault"
/// 当前h5地址
#define DK_H5UrlStringUserDefault @"DK_H5UrlStringUserDefault"

/// 替换 model 属性名称 用于 response 如不需要可以使用 request.responseObject 获取返回参数
#define DK_Network_Massage DKCONFIG.dkc_networkMessage
#define DK_Network_Data DKCONFIG.dkc_networkData
#define DK_Network_Code DKCONFIG.dkc_networkCode

#define NetworkRequestRetcodeErrorDomain DKCONFIG.dkc_networkRequestRetcodeErrorDomain
