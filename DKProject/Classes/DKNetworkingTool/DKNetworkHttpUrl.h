//
//  DKNetworkHttpUrl.h
//  GardenManager
//
//  Created by 王 on 2019/6/14.
//  Copyright © 2019 wisezone. All rights reserved.
//


#if DEBUG
#define DK_BaseUrl [[NSUserDefaults standardUserDefaults] valueForKey:DK_UrlStringUserDefault]?:DK_DevelopmentUrlString
#else
#define DK_BaseUrl DK_DistributionUrlString
#endif

#if DEBUG
#define DK_BaseH5Url [[NSUserDefaults standardUserDefaults] valueForKey:DK_H5UrlStringUserDefault]?:DK_H5DevelopmentUrlString
#else
#define DK_BaseH5Url DK_H5DistributionUrlString
#endif

/// 测试接口地址
#define DK_DevelopmentUrlString @""
/// 正式接口地址
#define DK_DistributionUrlString @""

/// h5测试接口地址
#define DK_H5DevelopmentUrlString @""
/// h5正式接口地址
#define DK_H5DistributionUrlString @""

/// 本地接口地址
#define DK_LocalUrlString @""


/// 当前地址
#define DK_UrlStringUserDefault @"DK_UrlStringUserDefault"
/// 当前h5地址
#define DK_H5UrlStringUserDefault @"DK_H5UrlStringUserDefault"




