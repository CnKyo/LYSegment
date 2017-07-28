//
//  PhoneTypeSearchView.m
//  库存管理
//
//  Created by liuyang on 2017/7/24.
//  Copyright © 2017年 同牛科技. All rights reserved.
//

#import "PhoneTypeSearchView.h"

@implementation PhoneTypeSearchView
{
   NSInteger _selectRow;
   NSMutableArray * _typeArray;
}

+(id)phoneTypeSearchView{
  return [[self alloc] initWithFrame:CGRectZero];
}

-(id)initWithFrame:(CGRect)frame
{
    
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        _selectRow = 0;
        _typeArray = [NSMutableArray arrayWithObjects:@"全部品牌",@"苹果",@"华为",@"小米",@"魅族",@"vivo",nil];

        
        _typeTableView = [[UITableView alloc]init];
        _typeTableView.frame = CGRectMake(0, 0, kScreen_Width, 0);
        _typeTableView.delegate=self;
        _typeTableView.dataSource=self;
        _typeTableView.showsVerticalScrollIndicator=NO;
        _typeTableView.showsHorizontalScrollIndicator=NO;
        _typeTableView.userInteractionEnabled= YES ;
        
        _typeTableView.contentInset = UIEdgeInsetsMake(0, 0, -5, 0);
        
        _typeTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self addSubview:_typeTableView];
        
        _typeTableView.backgroundColor = [UIColor clearColor];
    }
    return self;
}

#pragma mark - 数据源
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _typeArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TypeSelectCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"TypeSelectCell" owner:nil options:nil] lastObject];
    cell.typeNameLab.text = _typeArray[indexPath.row];
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
    [_typeDelegate PhoneTypeSearchTypeNameLab:cell.typeNameLab.text];
}

@end
