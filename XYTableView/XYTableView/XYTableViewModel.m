//
//  XYTableViewModel.m
//  XYTableView
//
//  Created by htouhui on 2018/7/7.
//  Copyright © 2018年 htouhui. All rights reserved.
//

#import "XYTableViewModel.h"
#import "MJExtension.h"

@interface XYTableViewModel ()


@property (nonatomic, assign) NSInteger totalPage; //!< 总页数

@end

@implementation XYTableViewModel

- (instancetype)initWithParams:(NSDictionary *)params completionBlock:(void(^)(id response))completionBlock
{
    if (self = [super init]) {
        self.params = params ? params.mutableCopy : @{}.mutableCopy;
        self.dataSource = @[].mutableCopy;
        self.totalPage = 1;
        self.currentPage = 1;
        self.completionBlcok = completionBlock;
    }
    return self;
}

#pragma mark - 加载数据 子类可以重新该方法 进行数据解析处理
- (void)loadPage:(NSInteger)pageNum isPullDown:(BOOL)isPullDown
{
    // 网路请求
}

#pragma mark - 上拉加载
-(void)loadNextPageCompletionBlock:(void(^)(BOOL isMore))completionBlock
{
    self.isRefresh = NO;
    self.refreshCompletionBlcok = completionBlock;
    if (self.currentPage < self.totalPage) {
        self.currentPage ++;
        [self loadPage:self.currentPage isPullDown:NO];
    }else
    {
        // 没有更多数据
        dispatch_async(dispatch_get_main_queue(), ^{
            !completionBlock ? : completionBlock(NO);
        });
    }
}

#pragma maek - 下拉刷新
-(void)refreshCompletionBlock:(void(^)(BOOL isMore))completionBlock
{
    self.isRefresh = YES;
    self.currentPage = 1;
    self.refreshCompletionBlcok = completionBlock;
    [self loadPage:self.currentPage isPullDown:YES];
}

@end
