//
//  OrderStatus220Controller.m
//  pairearch_WLY
//
//  Created by Jean on 2017/8/17.
//  Copyright © 2017年 Leo. All rights reserved.
//

#import "OrderStatus220Controller.h"

#import "WaitEnterController.h"

@interface OrderStatus220Controller ()
@property (weak, nonatomic) IBOutlet UIView *qrcodeBackgroundView;
@property (weak, nonatomic) IBOutlet UIButton *tuNumberButton;
@property (weak, nonatomic) IBOutlet UIImageView *qrcodeImgView;
@property (weak, nonatomic) IBOutlet UILabel *orderCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusDescriptionLabel;

@end

@implementation OrderStatus220Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view.backgroundColor = TOP_NAVIBAR_COLOR;
    self.qrcodeBackgroundView.layer.masksToBounds = YES;
    self.qrcodeBackgroundView.layer.cornerRadius = 10;
    self.qrcodeImgView.image = [QrcodeHelper createLogoQrcodeImageWithMessage:@"TU10001" logoImage:[UIImage imageNamed:@"applogo"] imageSize:self.qrcodeImgView.bounds.size.width];
}


- (IBAction)tunumberButtonAction:(UIButton *)sender {
    WaitEnterController *enterVC = [WaitEnterController new];
    [self.navigationController pushViewController:enterVC animated:YES];
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
