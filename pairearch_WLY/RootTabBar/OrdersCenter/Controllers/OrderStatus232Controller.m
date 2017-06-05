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
@property (nonatomic, strong) PlanTimePickerView *timeView;

@end

@implementation OrderStatus232Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.planTimeButton.backgroundColor = MAIN_THEME_COLOR;
    self.signButton.backgroundColor = MAIN_THEME_COLOR;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (self.planAchieveTime.length <= 0) {
        [self showTimeSelectView];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.timeView removeFromSuperview];
}

- (IBAction)planTimeAction:(UIButton *)sender {
    [self showTimeSelectView];
}

- (PlanTimePickerView *)showTimeSelectView {
    __weak typeof(self) weakSelf = self;
    self.timeView = [PlanTimePickerView showTimeSelectViewInView:self.view withSelectBlock:^(NSDictionary *selectParaDict) {
        NSLog(@"selectParaDict:%@", selectParaDict);
        NSMutableDictionary *paraDict = [NSMutableDictionary dictionaryWithDictionary:selectParaDict];
        [paraDict setObject:weakSelf.code.length>0? weakSelf.code:@"" forKey:@"orderCode"];
        [weakSelf networkWithUrlStr:CHANGE_PLAN_ARRIVETIME_API paraDict:paraDict];
    }];
    self.timeView.tapHide = self.planAchieveTime.length > 0;
    return self.timeView;
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
        if (self.planAchieveTime.length <= 0) {
            self.planAchieveTime = @"111";
        }
    } failure:^(NSError *error) {
        [ProgressHUD bwm_showTitle:error.userInfo[ERROR_MSG] toView:self.view hideAfter:HUD_HIDE_TIMEINTERVAL];
    }];
}

//收货签到按钮点击事件
- (IBAction)signButtonAction:(UIButton *)sender {
//    NSString *lat = [NSString stringWithFormat:@"%@", [LocationManager shareManager].addressInfo[@"latiude"]];
//    NSString *lng = [NSString stringWithFormat:@"%@", [LocationManager shareManager].addressInfo[@"longitude"]];
//    [self networkWithUrlStr:DELIVERY_SIGN_UP_API paraDict:@{@"userName":[LoginModel shareLoginModel].tel.length>0? [LoginModel shareLoginModel].tel:@"", @"orderCode":self.code, @"lat":lat.length? lat:@"", @"lng":lng.length? lng:@""}];
    
    //选择图片并且上传
    NSString *userName = [LoginModel shareLoginModel].tel;
    NSString *orderCode = self.code;
    CLLocation *location =  [LocationManager shareManager].location;
    NSString *lat = [NSString stringWithFormat:@"%f", location.coordinate.latitude];
    NSString *lng = [NSString stringWithFormat:@"%f", location.coordinate.longitude];
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *locationTime = [dateFormatter stringFromDate:location.timestamp];
    [MyImagePickerManager presentImagePickerControllerInTarget:self finishPickingBlock:nil postUrlStr:DELIVERY_SIGN_UP_API paraDict:@{@"userName":userName, @"orderCode":orderCode, @"lat":lat, @"lng":lng, @"locationTime":locationTime} endBlock:^(id responseObject, NSError *error) {
        if (!error) {
            NSString *remarkStr = [NSString stringWithFormat:@"%@", responseObject[@"remark"]];
            NSLog(@"%@", responseObject);
            [ProgressHUD bwm_showTitle:remarkStr toView:self.view hideAfter:HUD_HIDE_TIMEINTERVAL];
        } else {
            [ProgressHUD bwm_showTitle:error.userInfo[ERROR_MSG] toView:self.view hideAfter:HUD_HIDE_TIMEINTERVAL];
        }
    }];
    
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
