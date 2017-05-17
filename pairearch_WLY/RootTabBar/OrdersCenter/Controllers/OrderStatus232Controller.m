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
    [PlanTimePickerView showTimeSelectView];
    
}
- (IBAction)signButtonAction:(UIButton *)sender {
    
    
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
