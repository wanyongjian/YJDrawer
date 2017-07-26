//
//  MessageController.m
//  YJDrawer
//
//  Created by wanyongjian on 2017/6/21.
//  Copyright © 2017年 eco. All rights reserved.
//

#import "MessageController.h"
#import "YJDrawerManager.h"
@interface MessageController ()

@property (strong, nonatomic) UISegmentedControl *segCon;
@property (strong, nonatomic) UISearchBar *search;
@property (strong, nonatomic) UITapGestureRecognizer *gestureTap;
@end

@implementation MessageController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    self.segCon = [[UISegmentedControl alloc]initWithItems:@[@"消息",@"列表"]];
    self.segCon.frame = (CGRect){self.segCon.frame.origin.x,self.segCon.frame.origin.y,120,self.segCon.frame.size.height};
    self.segCon.selectedSegmentIndex = 1;
    [self.segCon addTarget:self action:@selector(segmentChanged:) forControlEvents:UIControlEventValueChanged];
    self.navigationItem.titleView = self.segCon;
    
    self.search = [[UISearchBar alloc]init];
    self.search.frame = CGRectMake(0, 0, KScreenWidth, 44);
    self.search.placeholder = @"搜索";
    [self.tableView addSubview:self.search];
    
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]init];
//    tap.numberOfTapsRequired = 1;
//    [tap addTarget:self action:@selector(taped:)];
//    [self.view addGestureRecognizer:tap];
    [self.view addGestureRecognizer:self.gestureTap];
    
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.search resignFirstResponder];
}
- (void)segmentChanged:(UISegmentedControl*)seg{
    NSLog(@"%ld",seg.selectedSegmentIndex);
    if (seg.selectedSegmentIndex == 0) {
        [[YJDrawerManager instance] showViewWithType:YJDrawerShowMainWithAnimation];
//        [[YJDrawerManager instance] showViewWithType:YJDrawerShowMain];
    }else{
        [[YJDrawerManager instance] showViewWithType:YJDrawerShowLeftWithAnimation];
//        [[YJDrawerManager instance] showViewWithType:YJDrawerShowleft];
    }
}

- (UITapGestureRecognizer *)gestureTap{
    if (!_gestureTap) {
        _gestureTap = [[UITapGestureRecognizer alloc]init];
        [_gestureTap addTarget:self action:@selector(tapped:)];
    }
    return _gestureTap;
}

- (void)tapped:(UITapGestureRecognizer*)sender{
    if (self.search.isFirstResponder) {
        [self.search resignFirstResponder];
    }
    
    [[YJDrawerManager instance] showViewWithType:YJDrawerShowMainWithAnimation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 0;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}

- (void)taped:(UITapGestureRecognizer *)ges{
    
    
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
