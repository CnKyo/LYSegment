//
//  PhoneTypeSearchView.h
//  库存管理
//
//  Created by liuyang on 2017/7/24.
//  Copyright © 2017年 同牛科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TypeSelectCell.h"

@protocol PhoneTypeSearchDelegate <NSObject>
-(void)PhoneTypeSearchTypeNameLab:(NSString *)typeNamStr;
@end

@interface PhoneTypeSearchView : UIView<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * typeTableView;
@property(nonatomic,strong)TypeSelectCell * typeSelectCell;
@property(nonatomic,assign)id<PhoneTypeSearchDelegate>typeDelegate;
+(id)phoneTypeSearchView;

@end
