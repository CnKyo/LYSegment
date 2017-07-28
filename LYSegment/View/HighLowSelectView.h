//
//  HighLowSelectView.h
//  库存管理
//
//  Created by liuyang on 2017/7/24.
//  Copyright © 2017年 同牛科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TypeSelectCell.h"

@protocol HighLowSelectDelegate <NSObject>
-(void)HighLowSelectTypeNameLab:(NSString *)typeNamStr;
@end

@interface HighLowSelectView : UIView<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * hlTableView;
@property(nonatomic,strong)TypeSelectCell * typeSelectCell;
@property(nonatomic,assign)id<HighLowSelectDelegate>hlDelegate;
+(id)highLowSelectView;


@end
