//
//  LeftView.m
//  YJDrawer
//
//  Created by wanyongjian on 2017/6/21.
//  Copyright © 2017年 eco. All rights reserved.
//

#import "LeftView.h"
#import "YJDrawerManager.h"
#define kBackgroundColor [UIColor colorWithRed:13.f / 255.f green:184.f / 255.f blue:246.f / 255.f alpha:1]

static NSString *const resue = @"use";
@interface LeftView() <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) NSArray <NSArray *> *dataArray;
@property (nonatomic, strong) UIImageView *imageView;
@end

@implementation LeftView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height) style:UITableViewStylePlain];
        self.tableview.backgroundColor = kBackgroundColor;
        self.tableview.delegate = self;
        self.tableview.dataSource = self;
        [self addSubview:self.tableview];
        
        self.tableview.tableHeaderView = self.imageView;
        self.tableview.tableFooterView = [[UIView alloc]init];
    }
    
    return self;
}

- (UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.tableview.frame.size.width,280)];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.clipsToBounds = YES;
        [_imageView setImage:[UIImage imageNamed:@"leftview_bg"]];
    }
    return _imageView;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:resue];
    if (!cell) {
     
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:resue];
        cell.backgroundColor = kBackgroundColor;
        cell.textLabel.textColor = [UIColor whiteColor];
    }
    cell.textLabel.text = self.dataArray[indexPath.row][1];
    cell.imageView.image = self.dataArray[indexPath.row][0];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    //返回主界面
    [[YJDrawerManager instance] showViewWithType:YJDrawerShowMainWithAnimation];
}
#pragma mark - get方法
- (NSArray *)dataArray{
    if (!_dataArray) {
        _dataArray = @[ @[[UIImage imageNamed:@"leftview_shop"],@"我的商城"],
                        @[[UIImage imageNamed:@"leftview_purse"],@"QQ钱包"],
                        @[[UIImage imageNamed:@"leftview_decorate"],@"个性装扮"],
                        @[[UIImage imageNamed:@"leftview_favorite"],@"我的收藏"],
                        @[[UIImage imageNamed:@"leftview_album"],@"我的相册"],
                        @[[UIImage imageNamed:@"leftview_file"],@"我的文件"]
                      ];
    }
    return _dataArray;
}
@end
