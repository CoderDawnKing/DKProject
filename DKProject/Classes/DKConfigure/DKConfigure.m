//
//  DKConfigure.m
//  AFNetworking
//
//  Created by DawnKing on 2020/7/9.
//

#import "DKConfigure.h"

@implementation DKConfigure

+ (instancetype)shared {
    static DKConfigure *configure;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        configure = [[DKConfigure alloc] init];
    });
    return configure;
}

- (instancetype)init {
    if (self = [super init]) {
        [self initDefaultConfigure];
    }
    return self;
}

- (void)initDefaultConfigure {
    self.dkc_developmentUrlString = @"";
    self.dkc_distributionUrlString = @"";
    self.dkc_h5DevelopmentUrlString = @"";
    self.dkc_h5DistributionUrlString = @"";
    self.dkc_localUrlString = @"";
    self.dkc_networkMessage = @"msg";
    self.dkc_networkData = @"data";
    self.dkc_networkCode = @"code";
    self.dkc_networkRequestRetcodeErrorDomain = @"com.DKProject.app.Request";
    self.dkc_defaultRequestHeaderField = @{};
    self.dkc_networkSuccessCode = 1;
    self.dkc_networkFailureCode = 0;
    self.dkc_networkNotLoggedInCode = -11;
    self.dkc_networkParameterErrorCode = -1;
    self.dkc_networkSystemErrorCode = -4;
    self.dkc_networkSuccessMsg = @"请求成功";
    self.dkc_networkFailureMsg = @"请求失败";
    self.dkc_networkNotLoggedInMsg = @"用户未登录，请先登录";
    self.dkc_networkParameterErrorMsg = @"参数错误";
    self.dkc_networkSystemErrorMsg = @"系统错误";
    self.dkc_networkDefaultErrorMsg = @"请稍后再试";
    
    self.dkc_color_main = @"#FF5555";
    self.dkc_color_line = @"#EEEEEE";
    self.dkc_color_tableView_background = @"#F5F5F5";
    self.dkc_color_tab_text_select = @"#FC575A";
    self.dkc_color_tab_text_unselect = @"#838383";
    
    self.dk_categoryView_edgesForExtendedLayout = UIRectEdgeNone;
    
    self.dkc_rightArrowImageMargin = 38.f;
    self.dkc_constMargin = 10.0f;
    self.dkc_lineHeight = 1.f;
    self.dkc_labelMargin = 8.0f;
    self.dkc_leftMargin = 20.0f;
    self.dkc_rightMargin = 20.0f;
    self.dkc_topMargin = 15.0f;
    self.dkc_bottomMargin = 15.0f;
    self.dkc_betweenMargin = 15.0f;
    self.dkc_littleMargin = 5.0f;
}

@end
