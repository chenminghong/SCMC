//
//  OrderStatusKABaseController.m
//  pairearch_WLY
//
//  Created by Leo on 2017/3/27.
//  Copyright © 2017年 Leo. All rights reserved.
//

#import "OrderStatusKABaseController.h"

@interface OrderStatusKABaseController ()

@end

@implementation OrderStatusKABaseController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    //界面消失刷新首页面
    [[NSNotificationCenter defaultCenter] postNotificationName:ORDERSCENTER_RELOAD_NAME object:nil];
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
