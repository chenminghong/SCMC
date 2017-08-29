//
//  OrderStatus228Controller.m
//  pairearch_WLY
//
//  Created by Jean on 2017/8/21.
//  Copyright © 2017年 Leo. All rights reserved.
//

#import "OrderStatus228Controller.h"

#import "OrderStatus230Controller.h"

@interface OrderStatus228Controller ()

@property (weak, nonatomic) IBOutlet UIView *backgroundView;
@property (weak, nonatomic) IBOutlet UIButton *tuNumberButton;
@property (weak, nonatomic) IBOutlet UILabel *wharfLabel;
@property (weak, nonatomic) IBOutlet CustomVerticalButton *photoImgButton;
@property (weak, nonatomic) IBOutlet UILabel *statusDescriptionLabel;

@end

@implementation OrderStatus228Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view.backgroundColor = TOP_NAVIBAR_COLOR;
    self.photoImgButton.layer.cornerRadius = 8;
    self.backgroundView.layer.masksToBounds = YES;
    self.backgroundView.layer.cornerRadius = 10;
}

- (IBAction)tunumberButtonAction:(UIButton *)sender {
    
}

- (IBAction)photoEndLoadButtonAction:(CustomVerticalButton *)sender {
    OrderStatus230Controller *orderVC = [OrderStatus230Controller new];
    [self.navigationController pushViewController:orderVC animated:YES];
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
