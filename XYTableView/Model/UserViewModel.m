//
//  UserViewModel.m
//  XYTableView
//
//  Created by htouhui on 2018/8/9.
//  Copyright © 2018年 htouhui. All rights reserved.
//

#import "UserViewModel.h"
#import "UserModel.h"
#import "XYSectionBaseModel.h"
#import "MJExtension.h"
@implementation UserViewModel

- (void)loadPage:(NSInteger)pageNum isPullDown:(BOOL)isPullDown
{
    // 模拟网络数据请求
    NSString *path = [[NSBundle mainBundle] pathForResource:@"data.plist" ofType:nil];
    NSArray *listArr = [NSArray arrayWithContentsOfFile:path];
    
    NSMutableArray *muArr = @[].mutableCopy;
    for (NSDictionary *dict in listArr) {
        // cellModel
        UserModel *model = [UserModel mj_objectWithKeyValues:dict];
        model.cellHeight = 50;
        [muArr addObject:model];
    }
    
    // sectionModel
    XYSectionBaseModel *sectionModel = [[XYSectionBaseModel alloc] init];
    sectionModel.cellModelArr = muArr;
    
    if (isPullDown) {
        // 下拉刷新
        [self.dataSource removeAllObjects];
        // 数据源
        [self.dataSource addObject:sectionModel];
    }else
    {
        // 上拉加载
        XYSectionBaseModel *secModel = self.dataSource[0];
        [secModel.cellModelArr addObjectsFromArray:muArr];
    }
    

    !self.refreshCompletionBlcok ? : self.refreshCompletionBlcok(YES);
}

@end
