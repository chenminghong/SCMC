//
//  OrderStatus232Controller.m
//  pairearch_WLY
//
//  Created by Jean on 2017/9/7.
//  Copyright © 2017年 Leo. All rights reserved.
//

#import "OrderStatus232Controller.h"

#import "OrderStatus244Controller.h"

@interface OrderStatus232Controller ()

@property (weak, nonatomic) IBOutlet UIView *backgroundView;
@property (weak, nonatomic) IBOutlet UIButton *tuNumberButton;
@property (weak, nonatomic) IBOutlet UILabel *wharfLabel;
@property (weak, nonatomic) IBOutlet CustomVerticalButton *photoImgButton;
@property (weak, nonatomic) IBOutlet UILabel *statusDescriptionLabel;

@end

@implementation OrderStatus232Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view.backgroundColor = TOP_NAVIBAR_COLOR;
    self.photoImgButton.layer.cornerRadius = 8;
    self.backgroundView.layer.masksToBounds = YES;
    self.backgroundView.layer.cornerRadius = 10;
}

- (IBAction)tunumberButtonAction:(UIButton *)sender {
    OrderStatus244Controller *orderVC = [OrderStatus244Controller new];
    [self.navigationController pushViewController:orderVC animated:YES];
}

- (IBAction)photoEndLoadButtonAction:(CustomVerticalButton *)sender {
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
