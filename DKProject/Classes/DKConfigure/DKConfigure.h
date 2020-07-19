//
//  DKConfigure.h
//  AFNetworking
//
//  Created by DawnKing on 2020/7/9.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#define DKCONFIG [DKConfigure shared]

@interface DKConfigure : NSObject

// MARK: Url
@property (nonatomic, copy) NSString *dkc_developmentUrlString;
@property (nonatomic, copy) NSString *dkc_distributionUrlString;
@property (nonatomic, copy) NSString *dkc_h5DevelopmentUrlString;
@property (nonatomic, copy) NSString *dkc_h5DistributionUrlString;
@property (nonatomic, copy) NSString *dkc_localUrlString;
@property (nonatomic, copy) NSString *dkc_networkMessage;
@property (nonatomic, copy) NSString *dkc_networkData;
@property (nonatomic, copy) NSString *dkc_networkCode;
@property (nonatomic, copy) NSString *dkc_networkRequestRetcodeErrorDomain;
@property (nonatomic, strong) NSDictionary *dkc_defaultRequestHeaderField;
@property (nonatomic, assign) NSInteger dkc_networkSuccessCode;
@property (nonatomic, assign) NSInteger dkc_networkFailureCode;
@property (nonatomic, assign) NSInteger dkc_networkNotLoggedInCode;
@property (nonatomic, assign) NSInteger dkc_networkParameterErrorCode;
@property (nonatomic, assign) NSInteger dkc_networkSystemErrorCode;
@property (nonatomic, copy) NSString *dkc_networkSuccessMsg;
@property (nonatomic, copy) NSString *dkc_networkFailureMsg;
@property (nonatomic, copy) NSString *dkc_networkNotLoggedInMsg;
@property (nonatomic, copy) NSString *dkc_networkParameterErrorMsg;
@property (nonatomic, copy) NSString *dkc_networkSystemErrorMsg;
@property (nonatomic, copy) NSString *dkc_networkDefaultErrorMsg;

// MARK: Color
@property (nonatomic, copy) NSString *dkc_color_main;
@property (nonatomic, copy) NSString *dkc_color_line;
@property (nonatomic, copy) NSString *dkc_color_tableView_background;
@property (nonatomic, copy) NSString *dkc_color_tab_text_select;
@property (nonatomic, copy) NSString *dkc_color_tab_text_unselect;

// MARK: Category
@property (nonatomic, assign) UIRectEdge dk_categoryView_edgesForExtendedLayout;

/// 箭头间距 38
@property (nonatomic, assign) CGFloat dkc_rightArrowImageMargin;
/// 常用间距 10
@property (nonatomic, assign) CGFloat dkc_constMargin;
/// 线条高度 0.5
@property (nonatomic, assign) CGFloat dkc_lineHeight;
/// label 间距 8
@property (nonatomic, assign) CGFloat dkc_labelMargin;
/// 左边距 20
@property (nonatomic, assign) CGFloat dkc_leftMargin;
/// 右边距 20
@property (nonatomic, assign) CGFloat dkc_rightMargin;
/// 上边距 15
@property (nonatomic, assign) CGFloat dkc_topMargin;
/// 下边距 15
@property (nonatomic, assign) CGFloat dkc_bottomMargin;
/// 间距 15
@property (nonatomic, assign) CGFloat dkc_betweenMargin;
/// 小间距 5
@property (nonatomic, assign) CGFloat dkc_littleMargin;

+ (instancetype)shared;

@end

NS_ASSUME_NONNULL_END
