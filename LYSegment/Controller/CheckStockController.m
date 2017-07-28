//
//  CheckStockController.m
//  库存管理
//
//  Created by liuyang on 2017/7/11.
//  Copyright © 2017年 同牛科技. All rights reserved.
//

#import "CheckStockController.h"
#import "PhoneTypeSearchView.h"
#import "HighLowSelectView.h"
@interface CheckStockController ()<UISearchBarDelegate,PhoneTypeSearchDelegate,HighLowSelectDelegate>

@property(nonatomic,strong)UILabel * allTypeLab;
@property(nonatomic,strong)UILabel * highLowLab;

@property(nonatomic,strong)PhoneTypeSearchView * phoneTypeSearchView;
@property(nonatomic,strong)HighLowSelectView * highLowSelectView;
@property(nonatomic,strong)NSMutableArray * stockArray;
@property(nonatomic,strong)UISearchBar * searchBar;
@property(nonatomic,strong)NSMutableArray * brandsArray;
@end

@implementation CheckStockController
{
    UIImageView * _allTypeImage;
    UIButton * _allTypeBtn;
    UIImageView * _highLowImage;
    UIButton * _highLowBtn;
    UIView * _backWindowView;
    UIView * _hlBackWindowView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColorFromRGB(0xEFEFF4);
    //创建headView
    [self createHeadView];
    //创建全部品牌view
    [self createPhoneTypeView];
    //创建价格排序view
    [self createHighLowView];
    
}

-(void)createHeadView
{
    UIView * headView = [[UIView alloc]init];
    [self.view addSubview:headView];
    headView.backgroundColor = [UIColor whiteColor];
    headView.frame = CGRectMake(0, 0, kScreen_Width, 79.5);
    
    _searchBar = [[UISearchBar alloc] init];
    _searchBar.frame = CGRectMake(25, 10.5, kScreen_Width-50, 28);
    _searchBar.placeholder = @"输入关键词查询";
    _searchBar.delegate = self;
    [headView addSubview:_searchBar];
    //设置背景图是为了去掉上下黑线
    _searchBar.backgroundImage = [[UIImage alloc] init];
    // 设置SearchBar的颜色主题为白色
    _searchBar.barTintColor = UIColorFromRGB(0xF5F5F5);
    
    UITextField *searchField = [_searchBar valueForKey:@"searchField"];
    if (searchField) {
        [searchField setBackgroundColor:[UIColor whiteColor]];
        searchField.layer.cornerRadius = 14.0f;
        searchField.layer.borderColor = [UIColor clearColor].CGColor;
        searchField.layer.borderWidth = 1;
        searchField.layer.masksToBounds = YES;
        searchField.backgroundColor = UIColorFromRGB(0xF5F5F5);
        [searchField setValue:[UIFont boldSystemFontOfSize:15] forKeyPath:@"_placeholderLabel.font"];
        [searchField setValue:UIColorFromRGB(0xBBBFC7) forKeyPath:@"_placeholderLabel.textColor"];
    }
    
    UIView * allTypeView = [[UIView alloc]init];
    [headView addSubview:allTypeView];
    allTypeView.frame = CGRectMake(0, 38, kScreen_Width/2, 41.5);
    allTypeView.backgroundColor = [UIColor clearColor];
    
    _allTypeLab = [[UILabel alloc]init];
    [allTypeView addSubview:_allTypeLab];
    _allTypeLab.text = @"全部品牌";
    _allTypeLab.font = [UIFont systemFontOfSize:13];
    _allTypeLab.textColor = UIColorFromRGB(0xEE2041);
    [_allTypeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(allTypeView).with.offset(15);
        make.top.equalTo(allTypeView).with.offset(-13.5);
        make.height.mas_equalTo(@13);
        make.centerX.equalTo(allTypeView).with.offset(-7);
    }];
    _allTypeImage = [[UIImageView alloc]init];
    [allTypeView addSubview:_allTypeImage];
    _allTypeImage.image = [UIImage imageNamed:@"扫码页面-下拉icon"];
    [_allTypeImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_allTypeLab.mas_right).with.offset(4);
        make.top.equalTo(allTypeView).with.offset(17.5);
        make.height.mas_equalTo(@6);
        make.width.mas_equalTo(@9);
    }];
    _allTypeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [allTypeView addSubview:_allTypeBtn];
    _allTypeBtn.backgroundColor = [UIColor clearColor];
    [_allTypeBtn setTitle:nil forState:UIControlStateNormal];
    [_allTypeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(allTypeView).with.offset(15);
        make.top.equalTo(allTypeView).with.offset(-13.5);
        make.height.mas_equalTo(@13);
        make.width.mas_equalTo(@70);
        make.centerX.equalTo(allTypeView).with.offset(0);
    }];
     [_allTypeBtn addTarget:self action:@selector(allTypeBtClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIView * highLowView = [[UIView alloc]init];
    [headView addSubview:highLowView];
    highLowView.frame = CGRectMake(kScreen_Width/2, 38, kScreen_Width/2, 41.5);
    highLowView.backgroundColor = [UIColor clearColor];
    
    _highLowLab = [[UILabel alloc]init];
    [highLowView addSubview:_highLowLab];
    _highLowLab.text = @"库存由高到低";
    _highLowLab.font = [UIFont systemFontOfSize:13];
    _highLowLab.textColor = UIColorFromRGB(0xEE2041);
    [_highLowLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(highLowView).with.offset(15);
        make.top.equalTo(highLowView).with.offset(-13.5);
        make.height.mas_equalTo(@13);
        make.centerX.equalTo(highLowView).with.offset(-7);
    }];
    _highLowImage = [[UIImageView alloc]init];
    [highLowView addSubview:_highLowImage];
    _highLowImage.image = [UIImage imageNamed:@"扫码页面-下拉icon"];
    [_highLowImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_highLowLab.mas_right).with.offset(4);
        make.top.equalTo(highLowView).with.offset(17.5);
        make.height.mas_equalTo(@6);
        make.width.mas_equalTo(@9);
    }];
    _highLowBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [highLowView addSubview:_highLowBtn];
    _highLowBtn.backgroundColor = [UIColor clearColor];
    [_highLowBtn setTitle:nil forState:UIControlStateNormal];
    [_highLowBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(highLowView).with.offset(15);
        make.top.equalTo(highLowView).with.offset(-13.5);
        make.height.mas_equalTo(@13);
        make.width.mas_equalTo(@94);
        make.centerX.equalTo(highLowView).with.offset(0);
    }];
    [_highLowBtn addTarget:self action:@selector(highLowBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIView * lineView = [[UIView alloc]init];
    [headView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(headView).with.offset(0);
        make.right.equalTo(headView).with.offset(0);
        make.left.equalTo(headView).with.offset(0);
        make.height.mas_equalTo(@0.5);
        
    }];
    lineView.backgroundColor = UIColorFromRGB(0xBBBFC7);
    
    UIView * lineView2 = [[UIView alloc]init];
    [self.view addSubview:lineView2];
    [lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView.mas_bottom).with.offset(14.5);
        make.right.equalTo(headView).with.offset(0);
        make.left.equalTo(headView).with.offset(0);
        make.height.mas_equalTo(@0.5);
        
    }];
    lineView2.backgroundColor = UIColorFromRGB(0xBBBFC7);
}

-(void)createPhoneTypeView
{
    _backWindowView = [[UIView alloc] initWithFrame:CGRectMake(0, 64+60+79.5, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-(64+60+79.5))];
    _backWindowView.backgroundColor = [UIColor blackColor];
    _backWindowView.alpha = 0.5;
    [[UIApplication sharedApplication].keyWindow addSubview:_backWindowView];
    _backWindowView.hidden = YES;
    
    _phoneTypeSearchView = [PhoneTypeSearchView phoneTypeSearchView];
    _phoneTypeSearchView.typeDelegate = self;
    _phoneTypeSearchView.frame = CGRectMake(0, 64+60+79.5, kScreen_Width, 0);
    [[UIApplication sharedApplication].keyWindow addSubview:_phoneTypeSearchView];
}

-(void)createHighLowView
{
    _hlBackWindowView = [[UIView alloc] initWithFrame:CGRectMake(0, 64+60+79.5, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-(64+60+79.5))];
    _hlBackWindowView.backgroundColor = [UIColor blackColor];
    _hlBackWindowView.alpha = 0.5;
    [[UIApplication sharedApplication].keyWindow addSubview:_hlBackWindowView];
    _hlBackWindowView.hidden = YES;
    
    _highLowSelectView = [HighLowSelectView highLowSelectView];
    _highLowSelectView.hlDelegate = self;
    _highLowSelectView.frame = CGRectMake(0, 64+60+79.5, kScreen_Width, 0);
    [[UIApplication sharedApplication].keyWindow addSubview:_highLowSelectView];
}

//点击全部品牌三角按钮
-(void)allTypeBtClick
{
    if(_highLowBtn.selected == YES){
       [self highLowBtnClick];
    }
    
    if (_allTypeBtn.selected == NO) {
        CGAffineTransform transform= CGAffineTransformMakeRotation(M_PI);
        _allTypeImage.transform = transform;
        _allTypeBtn.selected =YES;
        [_phoneTypeSearchView.typeTableView reloadData];
        
        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
             _backWindowView.hidden = NO;
            _phoneTypeSearchView.frame = CGRectMake(0, 64+60+79.5, kScreen_Width, 232);
           _phoneTypeSearchView.typeTableView.frame = CGRectMake(0, 0, kScreen_Width, 232);
        } completion:^(BOOL finished) {
        }];

        
    }else{
        _allTypeImage.transform = CGAffineTransformIdentity;
        _allTypeBtn.selected =NO;
       
        [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            _backWindowView.hidden = YES;
            _phoneTypeSearchView.frame = CGRectMake(0, 64+60+79.5, kScreen_Width, 0);
            _phoneTypeSearchView.typeTableView.frame = CGRectMake(0, 0, kScreen_Width, 0);
        } completion:^(BOOL finished) {
            
        }];

    }

}

-(void)highLowBtnClick
{
    if(_allTypeBtn.selected == YES){
        [self allTypeBtClick];
    }
    
    if (_highLowBtn.selected == NO) {
        CGAffineTransform transform= CGAffineTransformMakeRotation(M_PI);
        _highLowImage.transform = transform;
        _highLowBtn.selected =YES;
        
        [_highLowSelectView.hlTableView reloadData];
        
        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            _highLowSelectView.frame = CGRectMake(0, 64+60+79.5, kScreen_Width, 78);
           _highLowSelectView.hlTableView.frame = CGRectMake(0, 0, kScreen_Width, 78);
            _hlBackWindowView.hidden = NO;
        } completion:^(BOOL finished) {
        }];
        
    }else{
        _highLowImage.transform = CGAffineTransformIdentity;
        _highLowBtn.selected =NO;
        
        [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            _highLowSelectView.frame = CGRectMake(0, 64+60+79.5, kScreen_Width, 0);
            _highLowSelectView.hlTableView.frame = CGRectMake(0, 0, kScreen_Width, 0);
            _hlBackWindowView.hidden = YES;
        } completion:^(BOOL finished) {
            
        }];
    }
}

-(void)PhoneTypeSearchTypeNameLab:(NSString *)typeNamStr
{
    [self allTypeBtClick];
    self.allTypeLab.text = typeNamStr;
}

-(void)HighLowSelectTypeNameLab:(NSString *)typeNamStr
{
    [self highLowBtnClick];
    self.highLowLab.text = typeNamStr;
    
}


//点击键盘上搜索时的相应事件
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    [_searchBar resignFirstResponder];
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    NSLog(@"收键盘监听");
    [_searchBar resignFirstResponder];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText;{
    NSLog(@"textDidChange---%@",searchBar.text);
    
    if (searchBar.text.length == 0) {
        [self performSelector:@selector(hideKeyboardWithSearchBar:) withObject:searchBar afterDelay:0];
    }
    
}

- (void)hideKeyboardWithSearchBar:(UISearchBar *)searchBar
{
        [searchBar resignFirstResponder];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
