//
//  BaseViewModel.h
//  GardenManager
//
//  Created by 王 on 2019/6/17.
//  Copyright © 2019 wisezone. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RACSubject;

NS_ASSUME_NONNULL_BEGIN

typedef void(^RequestSucess_Block)(void);
typedef void(^RequestResultBlock)(id object);

@class DKBaseModel;

@protocol DKBaseViewModelProtocol <NSObject>

- (instancetype)initWithModel:(DKBaseModel *)model;

- (void)__loadData;
- (void)__loadMoreData;

@end

typedef enum : NSUInteger {
    RefreshEnd_HasMoreData = 1,
    RefreshEnd_HasNoMoreData,
} RefreshEnd;

typedef NS_ENUM(NSInteger, UploadImageState) {
    UploadImageFailed   = 0,
    UploadImageSuccess  = 1
};

@interface DKBaseViewModel : NSObject<DKBaseViewModelProtocol>{
    NSInteger _page_no;
    NSInteger _page_size;
}

@property (nonatomic, strong) NSMutableDictionary *requestParams;
@property (nonatomic, strong) NSDictionary *defaultParams;

@property (nonatomic, strong) NSData *bodyData;

- (BOOL)validatePhone:(NSString *)phone;

@property (nonatomic, strong) RACSubject *loadEnd;
@property (nonatomic, strong) RACSubject *loadMoreEnd;

@property (nonatomic, strong) NSMutableArray *dataArrayM;

@property (nonatomic, assign) NSInteger total;

@end

NS_ASSUME_NONNULL_END
