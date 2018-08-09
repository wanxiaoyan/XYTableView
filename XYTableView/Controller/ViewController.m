//
//  ViewController.m
//  XYTableView
//
//  Created by htouhui on 2018/8/8.
//  Copyright © 2018年 htouhui. All rights reserved.
//

#import "ViewController.h"
#import "XYTableView.h"
#import "UserTableViewCell.h"

#import "UserViewModel.h"

@interface ViewController ()

@property (nonatomic, strong) XYTableView *userTableView;
@property (nonatomic, strong) UserViewModel *userViewModel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configuerTableView];
}

#pragma mark - Configuer
- (void)configuerTableView
{
    self.userViewModel = [[UserViewModel alloc] initWithParams:@{} completionBlock:nil];
    self.userTableView = [[XYTableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain tabelModel:self.userViewModel];
    
    // 下拉刷新 上拉加载
    self.userTableView.isNeedPullDownToRefreshAction = YES;
    self.userTableView.isNeedPullUpToRefreshAction = YES;

    // 返回cell类型
    self.userTableView.cellClassAtIndexPath = ^Class(NSIndexPath *indexPath) {
        return [UserTableViewCell class];
    };
    
    // 注册cell
    [self.userTableView registerNib:[UINib nibWithNibName:@"UserTableViewCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass([UserTableViewCell class])];
    
    if (@available(iOS 11.0, *)) {
        self.userTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else
    {
        if ([self respondsToSelector:@selector(automaticallyAdjustsScrollViewInsets)]) {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
    }
    
    [self.view addSubview:self.userTableView];
}


@end
