//
//  OrderStatus232Controller.m
//  pairearch_WLY
//
//  Created by Jean on 2017/5/15.
//  Copyright © 2017年 Leo. All rights reserved.
//

#import "OrderStatus232Controller.h"

#import "PlanTimePickerView.h"

@interface OrderStatus232Controller ()
@property (weak, nonatomic) IBOutlet UIButton *planTimeButton;
@property (weak, nonatomic) IBOutlet UIButton *signButton;

@end

@implementation OrderStatus232Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.planTimeButton.backgroundColor = MAIN_THEME_COLOR;
    self.signButton.backgroundColor = MAIN_THEME_COLOR;
}
- (IBAction)planTimeAction:(UIButton *)sender {
    __weak typeof(self) weakSelf = self;
    [PlanTimePickerView showTimeSelectViewWithSelectBlock:^(NSDictionary *selectParaDict) {
        NSLog(@"%@", selectParaDict);
        NSMutableDictionary *paraDict = [NSMutableDictionary dictionaryWithDictionary:selectParaDict];
        [paraDict setObject:weakSelf.code forKey:@"orderCode"];
        [weakSelf networkWithUrlStr:CHANGE_PLAN_ARRIVETIME_API paraDict:paraDict];
    }];
    
}

/**
 调用接口返回处理结果
 
 @param urlStr 接口名称
 @param paraDict 需要传递的参数
 */
- (void)networkWithUrlStr:(NSString *)urlStr paraDict:(NSDictionary *)paraDict {
    [NetworkHelper POST:urlStr parameters:paraDict progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSString *msg = responseObject[@"remark"];
        [ProgressHUD bwm_showTitle:msg toView:self.view hideAfter:HUD_HIDE_TIMEINTERVAL];
    } failure:^(NSError *error) {
        [ProgressHUD bwm_showTitle:error.userInfo[ERROR_MSG] toView:self.view hideAfter:HUD_HIDE_TIMEINTERVAL];
    }];
}

//入厂签到按钮点击事件
- (IBAction)signButtonAction:(UIButton *)sender {
    [self networkWithUrlStr:SIGN_UP_API paraDict:@{@"userName":[LoginModel shareLoginModel].tel.length>0? [LoginModel shareLoginModel].tel:@"", @"orderCode":self.code, @"lat":@"0", @"lng":@"0"}];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
