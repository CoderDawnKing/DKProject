//
//  BaseViewModel.m
//  GardenManager
//
//  Created by 王 on 2019/6/17.
//  Copyright © 2019 wisezone. All rights reserved.
//

#import "DKBaseViewModel.h"
#import "DKBaseModel.h"
#import <ReactiveObjC/ReactiveObjC.h>

@interface DKBaseViewModel ()

@end

@implementation DKBaseViewModel

- (instancetype)init {
    if (self = [super init]) {
        _page_no = 1;
        _page_size = 10;
    }
    return self;
}

- (instancetype)initWithModel:(DKBaseModel *)model {
    if (self = [super init]) {
    }
    return self;
}

- (void)__loadData {
    
}

- (void)__loadMoreData {
    
}

- (RACSubject *)loadEnd {
    if (!_loadEnd) {
        _loadEnd = [[RACSubject alloc] init];
    }
    return _loadEnd;
}

- (RACSubject *)loadMoreEnd {
    if (!_loadMoreEnd) {
        _loadMoreEnd = [[RACSubject alloc] init];
    }
    return _loadMoreEnd;
}

- (NSMutableArray *)dataArrayM {
    if (!_dataArrayM) {
        _dataArrayM = [NSMutableArray array];
    }
    return _dataArrayM;
}

- (NSMutableDictionary *)requestParams {
    if (!_requestParams) {
        _requestParams = [NSMutableDictionary dictionary];
    }
    return _requestParams;
}

- (NSDictionary *)defaultParams {
    return @{
             @"page_no":[NSString stringWithFormat:@"%ld",_page_no],
             @"page_size":[NSString stringWithFormat:@"%ld",_page_size]
             };
}

@end
