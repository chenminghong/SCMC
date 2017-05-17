//
//  OrderStatus224Controller.m
//  pairearch_WLY
//
//  Created by Jean on 2017/5/15.
//  Copyright © 2017年 Leo. All rights reserved.
//

#import "OrderStatus224Controller.h"

@interface OrderStatus224Controller ()

@property (weak, nonatomic) IBOutlet UIImageView *codeImageView;
@property (weak, nonatomic) IBOutlet UILabel *codeNumberLabel;

@end

@implementation OrderStatus224Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.codeNumberLabel.text = [NSString stringWithFormat:@"%@", self.code];
    self.codeImageView.image = [CreatQRCodeAndBarCodeFromLeon generateBarCode:self.code size:CGSizeMake(kScreenWidth, kScreenWidth * 9.0 / 16.0) color:[UIColor blackColor] backGroundColor:nil];
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
