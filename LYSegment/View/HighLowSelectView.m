//
//  HighLowSelectView.m
//  库存管理
//
//  Created by liuyang on 2017/7/24.
//  Copyright © 2017年 同牛科技. All rights reserved.
//

#import "HighLowSelectView.h"

@implementation HighLowSelectView
{
    NSInteger _selectRow;
    NSMutableArray * _hlArray;
}
+(id)highLowSelectView
{
    return [[self alloc] initWithFrame:CGRectZero];
}

-(id)initWithFrame:(CGRect)frame
{
    
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        _selectRow = 0;
        _hlArray = [NSMutableArray arrayWithObjects:@"库存由高到低",@"库存由低到高",nil];
        
        
        _hlTableView = [[UITableView alloc]init];
        _hlTableView.frame = CGRectMake(0, 0, kScreen_Width, 0);
        _hlTableView.delegate=self;
        _hlTableView.dataSource=self;
        _hlTableView.showsVerticalScrollIndicator=NO;
        _hlTableView.showsHorizontalScrollIndicator=NO;
        _hlTableView.userInteractionEnabled= YES ;
        
        _hlTableView.contentInset = UIEdgeInsetsMake(0, 0, -5, 0);
        
        _hlTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self addSubview:_hlTableView];
        
        _hlTableView.backgroundColor = [UIColor clearColor];
    }
    return self;
}

#pragma mark - 数据源
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TypeSelectCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"TypeSelectCell" owner:nil options:nil] lastObject];
    cell.typeNameLab.text = _hlArray[indexPath.row];
    if (indexPath.row == _selectRow) {
        cell.typeSelectBtn.hidden = NO;
        cell.typeNameLab.textColor = UIColorFromRGB(0xEE2041);
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 38.5;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    _selectRow = indexPath.row;
    TypeSelectCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.typeNameLab.textColor = UIColorFromRGB(0xEE2041);
    cell.typeSelectBtn.hidden = NO;
    [tableView reloadData];
    [_hlDelegate HighLowSelectTypeNameLab:cell.typeNameLab.text];
}


@end
