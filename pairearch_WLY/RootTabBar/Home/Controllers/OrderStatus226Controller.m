//
//  OrderStatus226Controller.m
//  pairearch_WLY
//
//  Created by Jean on 2017/8/18.
//  Copyright © 2017年 Leo. All rights reserved.
//

#import "OrderStatus226Controller.h"

#import "OrderStatus228Controller.h"

@interface OrderStatus226Controller ()

@property (weak, nonatomic) IBOutlet UIView *backgroundView;
@property (weak, nonatomic) IBOutlet UIButton *tuNumberButton;
@property (weak, nonatomic) IBOutlet UILabel *wharfLabel;
@property (weak, nonatomic) IBOutlet CustomVerticalButton *photoImgButton;
@property (weak, nonatomic) IBOutlet UILabel *statusDescriptionLabel;

@end

@implementation OrderStatus226Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.photoImgButton.layer.cornerRadius = 8;
}
- (IBAction)tunumberButtonAction:(UIButton *)sender {
    
}
- (IBAction)photoStartLoadButtonAction:(CustomVerticalButton *)sender {
    OrderStatus228Controller *orderVC = [OrderStatus228Controller new];
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
