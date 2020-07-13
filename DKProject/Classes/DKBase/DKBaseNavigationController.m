//
//  DKBaseNavigationController.m
//  AFNetworking
//
//  Created by DawnKing on 2020/7/14.
//

#import "DKBaseNavigationController.h"
#import <DKProject/DKProject.h>

@interface DKBaseNavigationController ()

@end

@implementation DKBaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self.navigationBar setTitleTextAttributes:@{
        NSFontAttributeName:[UIFont pfMediumWithSize:18],
        NSForegroundColorAttributeName:dk_HexColor(DK_COLOR_RED),
    }];
    
    // 设置导航栏按钮间距
    // iOS 13 以后 自定义按钮才生效 默认不设置 leftBarButtonItem 无法对系统按钮生效 需要对 leftBarButtonItem 重新赋值
    // TODO: (后面查一下原因)
    [UINavigationConfig shared].dk_defaultFixSpace = 80;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.childViewControllers.count) { // 如果push进来的不是第一个控制器
        UIBarButtonItem *leftBarButtonItem = [UIBarButtonItem qmui_backItemWithTarget:self action:@selector(pop)];
        viewController.navigationItem.leftBarButtonItem = leftBarButtonItem;
        // 隐藏tabbar
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    // 这句super的push要放在后面, 让viewController可以覆盖上面设置的leftBarButtonItem
    [super pushViewController:viewController animated:animated];
}

- (void)pop {
    [self popViewControllerAnimated:YES];
}

@end
