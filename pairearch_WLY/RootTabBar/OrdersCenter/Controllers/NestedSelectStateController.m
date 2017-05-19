//
//  NestedSelectStateController.m
//  pairearch_WLY
//
//  Created by Leo on 2017/3/6.
//  Copyright © 2017年 Leo. All rights reserved.
//

#import "NestedSelectStateController.h"

#import "HomePageModel.h"
#import "Mistake212Controller.h"
#import "OrderStatus224Controller.h"
#import "OrderStatus226Controller.h"
#import "OrderStatus228Controller.h"
#import "OrderStatus230Controller.h"
#import "OrderStatus232Controller.h"
#import "OrderStatus244Controller.h"
#import "OrderStatus248Controller.h"


@interface NestedSelectStateController ()

@end

@implementation NestedSelectStateController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [NavigationController getNavigationBackItemWithTarget:self SEL:@selector(popBackAction:)];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getCustomMessageAction:) name:GET_CUSTOM_MESSAGE_NAME object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(judgeJumpToDetailController) name:UIApplicationWillEnterForegroundNotification object:nil];
}

- (void)getCustomMessageAction:(NSNotification *)sender {
    NSDictionary *userInfo = [sender userInfo];
    NSInteger flag = [userInfo[@"flag"] integerValue];
    if (flag == 0) {
        NSInteger status = [userInfo[@"status"] integerValue];
        NSString *orderCode = userInfo[@"orderCode"];
        self.status = status;
        self.code = orderCode;
    }
    
}

- (void)setStatus:(NSInteger)status {
    _status = status;
    [self judgeJumpToDetailController];
}

- (void)judgeJumpToDetailController {
    [self judgeJumpToDetailControllerWithStatus:self.status code:self.code];
}


//根据加载的数据判断跳转界面
- (void)judgeJumpToDetailControllerWithStatus:(NSInteger)status code:(NSString *)code {
    NSLog(@"status:%ld", status);
    switch (status) {
        case ORDER_STATUS_220://已接收待签到
        {
            self.title = @"运单详情";
            Mistake212Controller *childVC = [Mistake212Controller new];
            childVC.homePageModel = self.homePageModel;
            [self addChildController:childVC];
        }
            break;
            
        case ORDER_STATUS_224:
        {
            self.title = @"入厂提示";
            OrderStatus224Controller *childVC = [OrderStatus224Controller new];
            childVC.status = self.status;
            childVC.code = code;
            [self addChildController:childVC];
        }
            break;
            
        case ORDER_STATUS_226:
        {
            self.title = @"开始装货";
            OrderStatus226Controller *childVC = [OrderStatus226Controller new];
            childVC.code = code;
            childVC.status = status;
            [self addChildController:childVC];
        }
            break;
            
        case ORDER_STATUS_228:
        {
            self.title = @"装货中";
            OrderStatus228Controller *childVC = [OrderStatus228Controller new];
            childVC.code = code;
            childVC.status = status;
            [self addChildController:childVC];
        }
            break;
            
        case ORDER_STATUS_230:
        {
            self.title = @"装货完成";
            OrderStatus230Controller *childVC = [OrderStatus230Controller new];
            childVC.code = code;
            childVC.status = status;
            [self addChildController:childVC];
        }
            break;
            
        case ORDER_STATUS_232:
        {
            self.title = @"收货签到";
            OrderStatus232Controller *childVC = [OrderStatus232Controller new];
            childVC.code = code;
            childVC.status = status;
            [self addChildController:childVC];
        }
            break;
            
        case ORDER_STATUS_244:
        {
            self.title = @"卸货完成";
            OrderStatus244Controller *childVC = [OrderStatus244Controller new];
            childVC.code = code;
            childVC.status = status;
            [self addChildController:childVC];
        }
            break;
            
        case ORDER_STATUS_248:
        {
            self.title = @"卸货完成";
            OrderStatus248Controller *childVC = [OrderStatus248Controller new];
            childVC.code = code;
            childVC.status = status;
            [self addChildController:childVC];
        }
            break;
            
        default:
            break;
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
