//
//  XYSectionBaseModel.h
//  SeaGodWallet
//
//  Created by htouhui on 2018/7/9.
//  Copyright © 2018年 Liuhuan. All rights reserved.
//
// 分组模型，根据需求，配置属性


#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface XYSectionBaseModel : NSObject

@property (nonatomic, assign) CGFloat headerHeight;
@property (nonatomic, assign) CGFloat footerHeight;
@property (nonatomic, strong) NSMutableArray *cellModelArr;

@end
