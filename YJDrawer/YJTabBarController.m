//
//  YJTabBarController.m
//  YJDrawer
//
//  Created by wanyongjian on 2017/6/21.
//  Copyright © 2017年 eco. All rights reserved.
//

#import "YJTabBarController.h"
#import "MessageController.h"
#import "ContactController.h"
#import "NewsController.h"
#import "YJDrawerManager.h"

@interface YJTabBarController () <UITabBarControllerDelegate>

@end

@implementation YJTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    NewsController *news = [[NewsController alloc]init];
//    UINavigationController *navNews = [[UINavigationController alloc]initWithRootViewController:news];
//    navNews.tabBarItem.title = @"动态";
//    navNews.tabBarItem.image = [UIImage imageNamed:@"tabbar_news"];
//    
//    MessageController *message = [[MessageController alloc]init];
//    UINavigationController *navMessgae = [[UINavigationController alloc]initWithRootViewController:message];
//    navMessgae.tabBarItem.title = @"消息";
//    navMessgae.tabBarItem.image = [UIImage imageNamed:@"tabbar_message"];
//    //    navMessgae.tabBarItem.badgeValue = @"123";
//    
//    ContactController *contact = [[ContactController alloc]init];
//    UINavigationController *navContact = [[UINavigationController alloc]initWithRootViewController:contact];
//    navContact.tabBarItem.title = @"联系";
//    navContact.tabBarItem.image = [UIImage imageNamed:@"tabbar_contacts"];
    
    
//    [self addChildViewController:navMessgae];
//    [self addChildViewController:navContact];
//    [self addChildViewController:navNews];
    self.delegate = self;

    [self addchildControllerWithClass:NSClassFromString(@"MessageController") andTitle:@"消息" andImg:@"tabbar_message"];
    [self addchildControllerWithClass:NSClassFromString(@"ContactController") andTitle:@"联系" andImg:@"tabbar_contacts"];
    [self addchildControllerWithClass:NSClassFromString(@"NewsController") andTitle:@"动态" andImg:@"tabbar_news"];
}

#pragma mark -

/**
 添加控制器

 @param class
 @param title
 @param imageName
 */
- (void)addchildControllerWithClass:(Class)class andTitle:(NSString *)title andImg:(NSString *)imageName{
    
    UIViewController *news = [[class alloc]init];
    UINavigationController *navNews = [[UINavigationController alloc]initWithRootViewController:news];
    navNews.tabBarItem.title = title;
    navNews.tabBarItem.image = [UIImage imageNamed:imageName];
    [self addChildViewController:navNews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    if ([viewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *nav = (UINavigationController*)viewController;
        UIViewController *selCon = nav.viewControllers.firstObject;
        
        //选中消息页响应手势
        //否则不响应
        if ([selCon isKindOfClass:[MessageController class]]) {
            NSLog(@"---消息类---");
            [[YJDrawerManager instance] panEnable];
        }else{
            NSLog(@"---非消息类---");
            [[YJDrawerManager instance] panDisable];
        }
    }
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
