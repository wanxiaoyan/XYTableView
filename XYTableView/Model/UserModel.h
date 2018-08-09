//
//  UserModel.h
//  XYTableView
//
//  Created by htouhui on 2018/8/9.
//  Copyright © 2018年 htouhui. All rights reserved.
//
//  用户数据模型

#import "XYCellBaseModel.h"

@interface UserModel : XYCellBaseModel

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *age;

@end
