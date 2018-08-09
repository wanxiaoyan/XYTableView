//
//  XYTableView.h
//  XYTableView
//
//  Created by htouhui on 2018/7/7.
//  Copyright © 2018年 htouhui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYTableViewModel.h"


//@protocol XYTableViewDataDelegate<UITableViewDataSource>
//
///**
// 返回cell的类型
// */
//- (Class)tableViewCellClasswAtIndexPath:(NSIndexPath *)indexPath;
//
//@end

typedef Class (^CellClassAtIndexPath)(NSIndexPath *indexPath); //!< 返回cell的类型

@protocol XYTableViewDelegate<NSObject>

@optional

- (void)xy_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

- (void)xy_tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath; //!< 可用于传递cell上的点击回调

- (void)xy_scrollViewDidScroll:(UIScrollView *)scrollView;

@end


@interface XYTableView : UITableView <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, assign) id<XYTableViewDelegate> xy_delegate;

@property (nonatomic, strong) XYTableViewModel *tableViewModel; //!< 网路数据处理Model

// 是否需要下拉刷新和上拉加载
@property (nonatomic, assign) BOOL isNeedPullDownToRefreshAction;
@property (nonatomic, assign) BOOL isNeedPullUpToRefreshAction;

@property (nonatomic, copy) CellClassAtIndexPath cellClassAtIndexPath; //!< 返回cell的类型

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style tabelModel:(XYTableViewModel *)tableViewMdoel;

/**
 直接加载加载
 */
- (void)refresh;


/**
 下拉刷新
 */
- (void)tableViewHeaderBeginRefreshing;

@end
