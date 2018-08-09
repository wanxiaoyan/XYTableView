//
//  XYTableView.m
//  XYTableView
//
//  Created by htouhui on 2018/7/7.
//  Copyright © 2018年 htouhui. All rights reserved.
//

#import "XYTableView.h"
#import "XYTableViewCell.h"
#import "MJRefresh.h"

#import "XYCellBaseModel.h"
#import "XYSectionBaseModel.h"

@implementation XYTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style tabelModel:(XYTableViewModel *)tableViewMdoel
{
    if (self = [super initWithFrame:frame style:style]) {
        
        self.tableViewModel = tableViewMdoel;
        self.delegate = self;
        self.dataSource = self;
    }
    
    return self;
}

#pragma mark - 直接加载加载
- (void)refresh
{
    [self.tableViewModel refreshCompletionBlock:^(BOOL isMore) {
        [self reloadData];
    }];
}

#pragma mark - 下拉刷新
- (void)tableViewHeaderBeginRefreshing
{
    __weak typeof(self) weakSelf = self;
    self.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{

        [weakSelf.tableViewModel refreshCompletionBlock:^(BOOL isMore) {
            [weakSelf reloadData];
            // 结束刷新动画
            [weakSelf stopRefreshingAnimationWithIsMore:isMore];
        }];
    }];
    
    [self.mj_header beginRefreshing];
}

#pragma mark - 上拉加载
- (void)tableViewFooterBeginRefreshing
{
    __weak typeof(self) weakSelf = self;
    self.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakSelf.tableViewModel loadNextPageCompletionBlock:^(BOOL isMore) {
            [weakSelf reloadData];
            // 结束刷新动画
            [weakSelf stopRefreshingAnimationWithIsMore:isMore];
        }];
    }];
}

#pragma mark - 结束刷新动画
- (void)stopRefreshingAnimationWithIsMore:(BOOL)isMore
{
    if ([self.mj_header isRefreshing]) {
        [self.mj_header endRefreshing];
        [self.mj_footer resetNoMoreData];
    }
    
    if ([self.mj_footer isRefreshing]) {
        [self.mj_footer endRefreshing];
        if (!isMore) {
            [self.mj_footer endRefreshingWithNoMoreData];
        }else
        {
            [self.mj_footer resetNoMoreData];;
        }
    }
}

#pragma mark - tableViewDelegate代理方法

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.tableViewModel.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    XYSectionBaseModel *sectionModel = self.tableViewModel.dataSource[section];
    return sectionModel.cellModelArr.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    XYSectionBaseModel *sectionModel = self.tableViewModel.dataSource[section];
    if (sectionModel.headerHeight > 0) {
        return sectionModel.headerHeight;
    }
    return 0.000001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    XYSectionBaseModel *sectionModel = self.tableViewModel.dataSource[section];
    if (sectionModel.footerHeight > 0) {
        return sectionModel.headerHeight;
    }
    return 0.000001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XYSectionBaseModel *sectionModel = self.tableViewModel.dataSource[indexPath.section];
    XYCellBaseModel *model = sectionModel.cellModelArr[indexPath.row];
    return model.cellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Class cellClass = [XYTableViewCell class];
    
    if (self.cellClassAtIndexPath) {
        cellClass = self.cellClassAtIndexPath(indexPath);
    }
    
    NSString *str = [NSString stringWithUTF8String:class_getName(cellClass)];
    XYTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    XYSectionBaseModel *sectionModel = self.tableViewModel.dataSource[indexPath.section];
    XYCellBaseModel *model = sectionModel.cellModelArr[indexPath.row];
    [cell setupCellWithModel:model];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.xy_delegate respondsToSelector:@selector(xy_tableView:didSelectRowAtIndexPath:)]) {
        [self.xy_delegate xy_tableView:tableView didSelectRowAtIndexPath:indexPath];
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.xy_delegate respondsToSelector:@selector(xy_tableView:willDisplayCell:forRowAtIndexPath:)]) {
        [self.xy_delegate xy_tableView:tableView willDisplayCell:cell forRowAtIndexPath:indexPath];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if ([self.xy_delegate respondsToSelector:@selector(xy_scrollViewDidScroll:)]) {
        [self.xy_delegate xy_scrollViewDidScroll:scrollView];
    }
}

#pragma mark - setter
- (void)setIsNeedPullUpToRefreshAction:(BOOL)isNeedPullUpToRefreshAction
{
    _isNeedPullUpToRefreshAction = isNeedPullUpToRefreshAction;
    
    if (_isNeedPullUpToRefreshAction) {
        [self tableViewFooterBeginRefreshing];
    }
}

- (void)setIsNeedPullDownToRefreshAction:(BOOL)isNeedPullDownToRefreshAction
{
    _isNeedPullDownToRefreshAction = isNeedPullDownToRefreshAction;
    if (_isNeedPullDownToRefreshAction) {
        [self tableViewHeaderBeginRefreshing];
    }
}

@end
