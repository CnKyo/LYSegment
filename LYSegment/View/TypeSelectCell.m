//
//  TypeSelectCell.m
//  库存管理
//
//  Created by liuyang on 2017/7/24.
//  Copyright © 2017年 同牛科技. All rights reserved.
//

#import "TypeSelectCell.h"

@implementation TypeSelectCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.typeSelectBtn.hidden = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
