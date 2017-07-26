//
//  YJDrawerManager.m
//  YJDrawer
//
//  Created by wanyongjian on 2017/6/22.
//  Copyright © 2017年 eco. All rights reserved.
//
#define kAppDelegate [[UIApplication sharedApplication] delegate]

#import "YJDrawerManager.h"

@interface YJDrawerManager ()

@property (nonatomic, strong) UIPanGestureRecognizer *pan;
@property (nonatomic, weak)   UIView *leftView;
@property (nonatomic, weak)   UIViewController *mainViewController;
@end

@implementation YJDrawerManager

+ (instancetype)instance{
    static YJDrawerManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[YJDrawerManager alloc]init];
    });
    return instance;
}

- (void)initController:(UIViewController *)controller andView:(UIView *)view{
    self.mainViewController = controller;
    self.leftView = view;
    
    [UIApplication sharedApplication].delegate.window.rootViewController = self.mainViewController;
    [[UIApplication sharedApplication].delegate.window addSubview:view];
    
    [self.mainViewController.view addGestureRecognizer:self.pan];
}

- (void)showViewWithType:(YJDrawerShowType)type{
    if (!self.mainViewController) { return;}
    
    switch (type) {
        case YJDrawerShowMainWithAnimation:{
            if (!(self.leftView.transform.tx > 0)) { return;}
            [UIView animateWithDuration:0.2 animations:^{
                self.mainViewController.view.transform = CGAffineTransformTranslate([UIApplication sharedApplication].delegate.window.transform, 0,0);
                self.leftView.transform = CGAffineTransformTranslate([UIApplication sharedApplication].delegate.window.transform, 0,0);
            }];
             break;
        }
        case YJDrawerShowLeftWithAnimation:{
            [UIView animateWithDuration:0.2 animations:^{
                self.mainViewController.view.transform   = CGAffineTransformTranslate([UIApplication sharedApplication].delegate.window.transform, KScreenWidth*KMainViewWidthScale, 0);;
                self.leftView.transform = CGAffineTransformTranslate([UIApplication sharedApplication].delegate.window.transform, KScreenWidth*kLeftViewWidthScale, 0);;
            }];
            break;
        }
        case YJDrawerShowMain:{
            self.mainViewController.view.transform = CGAffineTransformTranslate([UIApplication sharedApplication].delegate.window.transform, 0,0);
            self.leftView.transform = CGAffineTransformTranslate([UIApplication sharedApplication].delegate.window.transform, 0,0);
            break;
        }
        case YJDrawerShowleft:{
            self.mainViewController.view.transform   = CGAffineTransformTranslate([UIApplication sharedApplication].delegate.window.transform, KScreenWidth*KMainViewWidthScale, 0);;
            self.leftView.transform = CGAffineTransformTranslate([UIApplication sharedApplication].delegate.window.transform, KScreenWidth*kLeftViewWidthScale, 0);;
            break;
        }
        default:
            break;
    }
}

- (UIPanGestureRecognizer *)pan{
    if (!_pan) {
        _pan = [[UIPanGestureRecognizer alloc]init];
        [_pan addTarget:self action:@selector(panAction:)];
    }
    return _pan;
}

- (void)panEnable{
    if (!self.mainViewController) { return;}
    [self.mainViewController.view addGestureRecognizer:self.pan];
}

- (void)panDisable{
    if (!self.mainViewController) { return;}
    [self.mainViewController.view removeGestureRecognizer:self.pan];
}

- (void)panAction:(UIPanGestureRecognizer *)sender{
    //相对上次每次偏移x/y量
    CGPoint translation = [sender translationInView:sender.view];
    //leftview和mainview偏移
    self.mainViewController.view.transform = CGAffineTransformTranslate(self.mainViewController.view.transform, translation.x, 0);
    self.leftView.transform = CGAffineTransformTranslate(self.leftView.transform, translation.x/3, 0);
    
    //限制偏移量在正确的范围
    CGAffineTransform limitMainViewTransform = CGAffineTransformTranslate([UIApplication sharedApplication].delegate.window.transform, KScreenWidth*KMainViewWidthScale, 0);
    CGAffineTransform limitLeftViewTransform = CGAffineTransformTranslate([UIApplication sharedApplication].delegate.window.transform, KScreenWidth*kLeftViewWidthScale, 0);
    
    if (sender.view.transform.tx > limitMainViewTransform.tx) {
        sender.view.transform   = limitMainViewTransform;
        self.leftView.transform = limitLeftViewTransform;
    }else if (sender.view.transform.tx < 0){
        sender.view.transform = CGAffineTransformTranslate([UIApplication sharedApplication].delegate.window.transform, 0,0);
        self.leftView.transform = CGAffineTransformTranslate([UIApplication sharedApplication].delegate.window.transform, 0,0);
    }
    
    //结束拖拽后复位
    if (sender.state == UIGestureRecognizerStateEnded) {
        [UIView animateWithDuration:0.2f animations:^{
            if (sender.view.transform.tx > KScreenWidth * 0.5) {
                sender.view.transform   = limitMainViewTransform;
                self.leftView.transform = limitLeftViewTransform;
            }else{
                sender.view.transform = CGAffineTransformTranslate([UIApplication sharedApplication].delegate.window.transform, 0,0);
                self.leftView.transform = CGAffineTransformTranslate([UIApplication sharedApplication].delegate.window.transform, 0,0);
            }
        }];
    }
    //清除每次偏移量
    [sender setTranslation:CGPointZero inView:sender.view];
}




- (void)panactiontest{
//    //平移量
//    CGPoint translation = [sender translationInView:sender.view];
//    sender.view.transform = CGAffineTransformTranslate(sender.view.transform, translation.x, 0);
//    self.leftView.transform = CGAffineTransformTranslate(self.leftView.transform, translation.x/3, 0);
//    NSLog(@"-=-=-=-%f",self.leftView.transform.tx);
//    //清除平移
//    [sender setTranslation:CGPointZero inView:sender.view];
//    
//    //右边极限位置
//    CGAffineTransform rightLimitTransform = CGAffineTransformTranslate([UIApplication sharedApplication].delegate.window.transform,KScreenWidth*KLeftWidthScale, 0);
//    
//    CGAffineTransform leftLimitTransform = CGAffineTransformTranslate([UIApplication sharedApplication].delegate.window.transform,0, 0);
//    
//    if (sender.view.transform.tx > rightLimitTransform.tx) {
//        sender.view.transform = rightLimitTransform;
//        self.leftView.transform = CGAffineTransformTranslate([UIApplication sharedApplication].delegate.window.transform, rightLimitTransform.tx/3, 0);
//    }else if (sender.view.transform.tx<0){
//        sender.view.transform = leftLimitTransform;
//        self.leftView.transform = leftLimitTransform;
//    }
//    
//    //拖拽结束
//    if (sender.state == UIGestureRecognizerStateEnded) {
//        [UIView animateWithDuration:0.2 animations:^{
//            if (sender.view.transform.tx > KScreenWidth*0.5) {
//                sender.view.transform = rightLimitTransform;
//                self.leftView.transform = CGAffineTransformTranslate([UIApplication sharedApplication].delegate.window.transform, rightLimitTransform.tx/3, 0);
//            }else{
//                sender.view.transform = leftLimitTransform;
//                self.leftView.transform = leftLimitTransform;
//            }
//        }];
//    }
}
@end
