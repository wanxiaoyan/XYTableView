//
//  XYTableViewModel.h
//  XYTableView
//
//  Created by htouhui on 2018/7/7.
//  Copyright © 2018年 htouhui. All rights reserved.
//
//  网路数据处理Model

#import <Foundation/Foundation.h>

@interface XYTableViewModel : NSObject

@property (nonatomic, strong) NSMutableDictionary *params; //!< 请求参数
@property (nonatomic, assign) BOOL isRefresh; //!< 如果是，表示下拉刷新，否则上拉加载
@property (nonatomic, assign) NSInteger currentPage; //!< 当前页数
@property (nonatomic, strong) id responseObject; //!< 请求返回的数据
@property (nonatomic, strong) NSMutableArray *dataSource; //!< 数据源 二维数组
@property (nonatomic, copy) void(^refreshCompletionBlcok)(BOOL isMore);// !< 数据请求完成回调
@property (nonatomic, copy) void(^completionBlcok)(id response);// !< 数据请求完成回调

/**
 初始化

 @param params 请求参数
 @return XYTableViewModel
 */
- (instancetype)initWithParams:(NSDictionary *)params completionBlock:(void(^)(id response))completionBlock;


/**
 加载数据 子类可以重新该方法 进行数据解析处理

 @param pageNum 页码
 @param isPullDown 是否是下拉刷新
 */
- (void)loadPage:(NSInteger)pageNum isPullDown:(BOOL)isPullDown;

/**
 上拉加载
 */
- (void)loadNextPageCompletionBlock:(void(^)(BOOL isMore))completionBlock;

/**
 下拉刷新
 */
- (void)refreshCompletionBlock:(void(^)(BOOL isMore))completionBlock;


@end
