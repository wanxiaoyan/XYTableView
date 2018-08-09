//
//  XYTableViewCell.m
//  XYTableView
//
//  Created by htouhui on 2018/7/7.
//  Copyright © 2018年 htouhui. All rights reserved.
//

#import "XYTableViewCell.h"

@implementation XYTableViewCell

- (void)setupCellWithModel:(XYCellBaseModel *)model
{
    // 子类可重写该方法 进行具体操作
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
