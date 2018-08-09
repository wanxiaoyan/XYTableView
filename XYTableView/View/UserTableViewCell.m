//
//  UserTableViewCell.m
//  XYTableView
//
//  Created by htouhui on 2018/8/9.
//  Copyright © 2018年 htouhui. All rights reserved.
//

#import "UserTableViewCell.h"
#import "UserModel.h"

@interface UserTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *ageLabel;

@property (nonatomic, strong) UserModel *userModel;

@end

@implementation UserTableViewCell

- (void)setupCellWithModel:(XYCellBaseModel *)model
{
    self.userModel = (UserModel *)model;
    self.nameLabel.text = self.userModel.name;
    self.ageLabel.text = self.userModel.age;
}

@end
