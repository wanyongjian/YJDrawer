//
//  YJDrawerManager.h
//  YJDrawer
//
//  Created by wanyongjian on 2017/6/22.
//  Copyright © 2017年 eco. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef  NS_ENUM(NSUInteger, YJDrawerShowType){
    YJDrawerShowMainWithAnimation,
    YJDrawerShowLeftWithAnimation,
    YJDrawerShowMain,
    YJDrawerShowleft
};

static CGFloat const KMainViewWidthScale = 0.75;
static CGFloat const kLeftViewWidthScale = 0.25;
@interface YJDrawerManager : NSObject

+ (instancetype)instance;
- (void)showViewWithType:(YJDrawerShowType)type;
- (void)panEnable;
- (void)panDisable;
- (void)initController:(UIViewController *)controller andView:(UIView *)view;
@end
