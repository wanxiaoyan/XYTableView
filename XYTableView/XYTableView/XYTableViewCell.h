//
//  XYTableViewCell.h
//  XYTableView
//
//  Created by htouhui on 2018/7/7.
//  Copyright © 2018年 htouhui. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XYCellBaseModel;

@interface XYTableViewCell : UITableViewCell

- (void)setupCellWithModel:(XYCellBaseModel *)model;

@end
