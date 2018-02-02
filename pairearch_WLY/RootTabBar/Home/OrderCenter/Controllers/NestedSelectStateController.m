//
//  NestedSelectStateController.m
//  pairearch_WLY
//
//  Created by Leo on 2017/3/6.
//  Copyright © 2017年 Leo. All rights reserved.
//

#import "NestedSelectStateController.h"

#import "NestedSelectModel.h"
#import "OrderStatus115Controller.h"
#import "WaitingListController.h"
#import "WaitEnterController.h"
#import "PrepareEnterController.h"
#import "PressEnterController.h"
#import "OrderStatus140Controller.h"
#import "OrderStatus145Controller.h"
#import "OrderStatus150Controller.h"
#import "OrderStatus160Controller.h"
#import "OrderStatus200Controller.h"
#import "DifferentWarehousesController.h"
#import "NoDataView.h"




@interface NestedSelectStateController ()

@end

@implementation NestedSelectStateController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = TOP_NAVIBAR_COLOR;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getCustomMessageAction:) name:GET_CUSTOM_MESSAGE_NAME object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(judgeJumpToDetailController) name:UIApplicationWillEnterForegroundNotification object:nil];
    
    [self loadPageData];
}

- (void)loadPageData {
    NSDictionary *paraDict = @{@"driverTel":[LoginModel shareLoginModel].phone,
                               OPERATION_KEY:GET_TRANSPORT_ORDERINFO_API
                               };
    
    [NestedSelectModel getDataWithUrl:PAIREACH_NETWORK_URL parameters:paraDict hudTarget:self.view endBlock:^(NSURLSessionDataTask *task, id responseObject, NSError *error) {
        if (self.view.subviews.count > 0) {
            NSMutableArray *subViewsArr = [NSMutableArray arrayWithArray:self.view.subviews];
            for (UIView *subView in subViewsArr) {
                [subView removeFromSuperview];
            }
        }
        if (!error) {
            self.selectedModel = responseObject;
            [self judgeJumpToDetailController];
        } else {
             [self.view addSubview:[NoDataView getPlaceHoldViewWithImgName:@"zanwuxiaoxi" titleText:@"暂无运送中运单"]];
        }
    }];
}

//接收到推送的信息数据
- (void)getCustomMessageAction:(NSNotification *)sender {
    NSDictionary *userInfo = [sender userInfo];
    [self doWithProcessInfo:userInfo];
}

//根据返回的信息处理相关的流程跳转操作
- (void)doWithProcessInfo:(NSDictionary *)processInfo {
    [self.selectedModel setValuesForKeysWithDictionary:processInfo];
    [self judgeJumpToDetailController];
}

//根据加载的数据判断跳转界面
- (void)judgeJumpToDetailController {
    NSArray *statusArr = self.selectedModel.processList;
//    statusArr = @[@"145", @"150"];
    if (statusArr.count == 1) {
        NSInteger status = [statusArr[0] integerValue];
//        status = 120;
        NSLog(@"status:%ld", status);
        switch (status) {
            case ORDER_STATUS_100:
            {
                
            }
                break;
                
            case ORDER_STATUS_115:
            {
//                self.title = @"扫码签到";
                OrderStatus115Controller *orderStatusVC = [OrderStatus115Controller new];
                [self addChildController:orderStatusVC];
                orderStatusVC.selectedModel = self.selectedModel;
            }
                break;
                
            case ORDER_STATUS_120:
            {
//                self.title = @"候补排队";
                WaitingListController *orderStatusVC = [WaitingListController new];
                [self addChildController:orderStatusVC];
                orderStatusVC.selectedModel = self.selectedModel;
                
            }
                break;
                
            case ORDER_STATUS_123:
            {
                
            }
                break;
                
            case ORDER_STATUS_125:
            {
//                self.title = @"等待入厂";
                WaitEnterController *orderStatusVC = [WaitEnterController new];
                [self addChildController:orderStatusVC];
                orderStatusVC.selectedModel = self.selectedModel;
            }
                break;
                
            case ORDER_STATUS_130:
            {
//                self.title = @"准备入厂";
                PrepareEnterController *orderStatusVC = [PrepareEnterController new];
                [self addChildController:orderStatusVC];
                orderStatusVC.selectedModel = self.selectedModel;
            }
                break;
                
            case ORDER_STATUS_135:
            {
//                self.title = @"催促入厂";
                PressEnterController *orderStatusVC = [PressEnterController new];
                [self addChildController:orderStatusVC];
                orderStatusVC.selectedModel = self.selectedModel;
            }
                break;
                
            case ORDER_STATUS_140:   //内仓
            case ORDER_STATUS_152:   //外仓
            {
                
//                self.title = @"开始装货";
                OrderStatus140Controller *orderStatusVC = [OrderStatus140Controller new];
                [self addChildController:orderStatusVC];
                orderStatusVC.selectedModel = self.selectedModel;
                [orderStatusVC setProcessEndBlock:^(NSDictionary *responseInfo) {
                    if (responseInfo) {
                        [self doWithProcessInfo:responseInfo];
                    } else {
                        [self.navigationController popToRootViewControllerAnimated:YES];
                    }
                }];
            }
                break;
                
            case ORDER_STATUS_145:  //内仓
            case ORDER_STATUS_154:  //外仓
            {
//                self.title = @"装货完成";
                OrderStatus145Controller *orderStatusVC = [OrderStatus145Controller new];
                [self addChildController:orderStatusVC];
                orderStatusVC.selectedModel = self.selectedModel;
                [orderStatusVC setProcessEndBlock:^(NSDictionary *responseInfo) {
                    if (responseInfo) {
                        [self doWithProcessInfo:responseInfo];
                    } else {
                        [self.navigationController popToRootViewControllerAnimated:YES];
                    }
                }];
            }
                break;
                
            case ORDER_STATUS_147:
            {
//                self.title = @"收货完成";
            }
                break;
                
            case ORDER_STATUS_148:
            {
//                self.title = @"收货完成";
            }
                break;
                
            case ORDER_STATUS_150:
            {
//                self.title = @"装货离厂";
                OrderStatus150Controller *orderStatusVC = [OrderStatus150Controller new];
                [self addChildController:orderStatusVC];
                orderStatusVC.selectedModel = self.selectedModel;
            }
                break;
                
            case ORDER_STATUS_160:
            {
//                self.title = @"开始卸货";
                OrderStatus160Controller *orderStatusVC = [OrderStatus160Controller new];
                [self addChildController:orderStatusVC];
                orderStatusVC.selectedModel = self.selectedModel;
                [orderStatusVC setProcessEndBlock:^(NSDictionary *responseInfo) {
                    if (responseInfo) {
                        [self doWithProcessInfo:responseInfo];
                    } else {
                        [self.navigationController popToRootViewControllerAnimated:YES];
                    }
                }];
            }
                break;
                
            case ORDER_STATUS_200:
            {
//                self.title = @"卸货完成";
                OrderStatus200Controller *orderStatusVC = [OrderStatus200Controller new];
                [self addChildController:orderStatusVC];
                orderStatusVC.selectedModel = self.selectedModel;
                [orderStatusVC setProcessEndBlock:^(NSDictionary *responseInfo) {
                    if (responseInfo) {
                        [self doWithProcessInfo:responseInfo];
                    } else {
                        [self.navigationController popToRootViewControllerAnimated:YES];
                    }
                }];
            }
                break;
                
            default:
            {
                [self.navigationController popViewControllerAnimated:YES];
            }
                break;
        }
    } else if (statusArr.count > 1) {
//        self.title = @"开始装货";
        DifferentWarehousesController *orderStatusVC = [DifferentWarehousesController new];
        [self addChildController:orderStatusVC];
        orderStatusVC.selectedModel = self.selectedModel;
        [orderStatusVC setProcessEndBlock:^(NSDictionary *responseInfo) {
            if (responseInfo) {
                [self doWithProcessInfo:responseInfo];
            } else {
                [self.navigationController popToRootViewControllerAnimated:YES];
            }
        }];
    } else {
        [MBProgressHUD bwm_showTitle:@"系统数据错误，请返回重试！" toView:self.view hideAfter:HUD_HIDE_TIMEINTERVAL];
    }
}

//添加子视图控制器
- (void)addChildController:(UIViewController *)viewController {
    if (self.childViewControllers.count > 0) {
        if ([[self.childViewControllers[0] class] isSubclassOfClass:[viewController class]]) {
            return;
        }
        [self.childViewControllers[0] removeFromParentViewController];
        [self.view.subviews[0] removeFromSuperview];
        
        [self addChildViewController:viewController];
        [UIView transitionWithView:self.view duration:0.3 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
            viewController.view.frame = self.view.bounds;
            [self.view insertSubview:viewController.view atIndex:0];
        } completion:nil];
        
    } else {
        [self addChildViewController:viewController];
        [UIView transitionWithView:self.view duration:0.3 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
            viewController.view.frame = self.view.bounds;
            [self.view insertSubview:viewController.view atIndex:0];
        } completion:nil];
    }
}

#pragma mark -- ButtonAction

//返回按钮
- (void)popBackAction:(UIButton *)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
