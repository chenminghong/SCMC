//
//  OrderStatus226Controller.m
//  pairearch_WLY
//
//  Created by Jean on 2017/5/15.
//  Copyright © 2017年 Leo. All rights reserved.
//

#import "OrderStatus226Controller.h"

#import "SGScanningQRCodeVC.h"
#import <AVFoundation/AVFoundation.h>


@interface OrderStatus226Controller ()

@property (weak, nonatomic) IBOutlet UILabel *codeLabel;
@property (weak, nonatomic) IBOutlet UIButton *startScanButton;

@end

@implementation OrderStatus226Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.startScanButton.backgroundColor = MAIN_THEME_COLOR;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.codeLabel.text = [NSString stringWithFormat:@"运单号：%@", self.code];
}


/**
 调用接口返回扫描一维码结果
 
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

- (IBAction)scanButtonAction:(UIButton *)sender {
    //获取摄像设备
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if (device) {
        __weak typeof(self) weakself = self;
        SGScanningQRCodeVC *codeVC = [SGScanningQRCodeVC getSgscanningQRCodeVCWithResultBlock:^(NSString *scanResult) {
            //扫描结束回调
            NSLog(@"%@", scanResult);
            NSDictionary *paraDict = @{@"userName":[LoginModel shareLoginModel].tel.length>0? [LoginModel shareLoginModel].tel:@"", @"orderCode":scanResult};
            [self networkWithUrlStr:LOAD_START_API paraDict:paraDict];
        }];
        NavigationController *naviNC = [[NavigationController alloc] initWithRootViewController:codeVC];
        codeVC.navigationItem.leftBarButtonItem = [NavigationController getNavigationBackItemWithTarget:codeVC SEL:@selector(dismissModalViewControllerAnimated:)];
        [weakself presentViewController:naviNC animated:YES completion:nil];
    } else {
        [MBProgressHUD bwm_showTitle:@"⚠️ 警告:未检测到您的摄像头, 请在真机上测试" toView:self.view hideAfter:HUD_HIDE_TIMEINTERVAL / 2.0];
    }
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
