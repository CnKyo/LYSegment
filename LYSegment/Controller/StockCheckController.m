//
//  StockCheckController.m
//  库存管理
//
//  Created by liuyang on 2017/7/7.
//  Copyright © 2017年 同牛科技. All rights reserved.
//

#import "StockCheckController.h"
#import "CheckStaffController.h"
#import "CheckStockController.h"
@interface StockCheckController ()<UIScrollViewDelegate>
@property(nonatomic,strong)UISegmentedControl * Segment;
@property(nonatomic,strong)UIScrollView * scrollView;
@property(nonatomic,strong)CheckStockController * checkStockController;
@property(nonatomic,strong)CheckStaffController * checkStaffController;
@end

@implementation StockCheckController

- (void)viewDidLoad {
    [super viewDidLoad];
   //创建segment
    [self createSegment];
    //创建scrollview
    [self createScrollView];
    //创建库存查询，员工统计控制器
    [self setUpChildViewControll];
}

-(void)createSegment{
    UIView * SegmentView = [[UIView alloc]init];
    SegmentView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:SegmentView];
    
    [SegmentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).with.offset(64);
        make.right.equalTo(self.view).with.offset(0);
        make.left.equalTo(self.view).with.offset(0);
        make.height.mas_equalTo(@60);
    }];
    
    UIView * lineView = [[UIView alloc]init];
    [SegmentView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(SegmentView).with.offset(0);
        make.right.equalTo(SegmentView).with.offset(0);
        make.left.equalTo(SegmentView).with.offset(0);
        make.height.mas_equalTo(@0.5);
        
    }];
    lineView.backgroundColor = UIColorFromRGB(0xBBBFC7);
    
    NSArray * segmentArray = @[@"库存查询",@"员工统计"];
    _Segment = [[UISegmentedControl alloc]initWithItems:segmentArray];
    [SegmentView addSubview:_Segment];
    [_Segment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(SegmentView).with.offset(16);
        make.right.equalTo(SegmentView).with.offset(-25);
        make.left.equalTo(SegmentView).with.offset(25);
        make.height.mas_equalTo(@25);
        
    }];
    _Segment.selectedSegmentIndex = 0;
    _Segment.tintColor = UIColorFromRGB(0xEE2041);
    UIColor *segmentColor = UIColorFromRGB(0x90959E);
    
     NSDictionary *colorAttr = [NSDictionary dictionaryWithObjectsAndKeys:segmentColor, NSForegroundColorAttributeName,[UIFont systemFontOfSize:15],NSFontAttributeName,nil];
    [_Segment setTitleTextAttributes:colorAttr forState:UIControlStateNormal];
    _Segment.layer.cornerRadius = 12.5;
    _Segment.layer.masksToBounds = YES;
    _Segment.layer.borderColor = UIColorFromRGB(0xEE2041).CGColor;
    _Segment.layer.borderWidth = 1;
    
    [_Segment addTarget:self action:@selector(segmentSelect:) forControlEvents:UIControlEventValueChanged];

}

-(void)createScrollView
{
    _scrollView = [[UIScrollView alloc]init];
    [self.view addSubview:_scrollView];
    _scrollView.frame = CGRectMake(0, 60+64, kScreen_Width, kScreen_Height-64-60);
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.bounces = false;
    //方向锁
    _scrollView.directionalLockEnabled = YES;
    //为scrollview设置大小  需要计算调整
    _scrollView.contentSize = CGSizeMake(kScreen_Width * 2, kScreen_Height - 64-60);

}

-(void)setUpChildViewControll
{
    _checkStockController = [[CheckStockController alloc]init];
    _checkStockController.view.frame = CGRectMake(0, 0, kScreen_Width, CGRectGetHeight(_scrollView.frame));
    [_scrollView addSubview:_checkStockController.view];

}


-(void)segmentSelect:(UISegmentedControl*)seg{
    NSInteger index = seg.selectedSegmentIndex;
    if (index==1&&_checkStaffController==nil) {
        _checkStaffController = [[CheckStaffController alloc]init];
        _checkStaffController.view.frame = CGRectMake(index * kScreen_Width, 0, kScreen_Width, CGRectGetHeight(_scrollView.frame));
         [_scrollView addSubview:_checkStaffController.view];
    }
    
      [_scrollView setContentOffset:CGPointMake(index*kScreen_Width, 0) animated:YES];
    
       
    
}
#pragma mark - Scrollview delegate
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGFloat offSetX = scrollView.contentOffset.x;
    NSInteger ratio = round(offSetX / kScreen_Width);
    _Segment.selectedSegmentIndex = ratio;
    
    if (ratio==1&&_checkStaffController==nil) {
        _checkStaffController = [[CheckStaffController alloc]init];
        _checkStaffController.view.frame = CGRectMake(ratio * kScreen_Width, 0, kScreen_Width, CGRectGetHeight(_scrollView.frame));
        [_scrollView addSubview:_checkStaffController.view];
    }

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
