//
//  CheckStaffController.h
//  库存管理
//
//  Created by liuyang on 2017/7/11.
//  Copyright © 2017年 同牛科技. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CheckStaffDelegate <NSObject>
-(void)Staffid:(NSString *)staffId withType:(NSString *)type;
@end
@interface CheckStaffController : UIViewController
@property(nonatomic,assign)id<CheckStaffDelegate>delegate;
@end
