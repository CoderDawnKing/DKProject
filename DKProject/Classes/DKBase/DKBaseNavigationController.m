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

    
    // 设置导航栏按钮间距
    // iOS 13 以后 自定义按钮才生效 默认不设置 leftBarButtonItem 无法对系统按钮生效 需要对 leftBarButtonItem 重新赋值
    // 不知道为什么间距少了 8 的距离,好像是 QMUIKit 默认加了 8 的间距, 后面查一下原因
    // TODO: (后面查一下原因) 因为不走 setLeftBarButtonItem 方法了
    [UINavigationConfig shared].dk_defaultFixSpace = dk_defaultSpace + 8;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.childViewControllers.count) { // 如果push进来的不是第一个控制器
        // 设置自定义返回按钮并调用 pop 方法
        UIBarButtonItem *leftBarButtonItem = [UIBarButtonItem qmui_itemWithImage:dk_BundleImage(@"nav_icon_back") target:self action:@selector(pop)];
        viewController.navigationItem.leftBarButtonItem = leftBarButtonItem;
    }
    
    // 这句super的push要放在后面, 让viewController可以覆盖上面设置的leftBarButtonItem
    [super pushViewController:viewController animated:animated];
}

- (void)pop {
    if ([self.dk_delegate respondsToSelector:@selector(dk_leftBarButtonItemPopViewController)]) {
        BOOL isPop = [self.dk_delegate dk_leftBarButtonItemPopViewController];
        if (!isPop) return;
    }
    [self popViewControllerAnimated:YES];
}



@end
