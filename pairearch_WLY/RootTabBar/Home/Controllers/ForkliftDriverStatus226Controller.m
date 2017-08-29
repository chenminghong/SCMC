//
//  ForkliftDriverStatus226Controller.m
//  pairearch_WLY
//
//  Created by Jean on 2017/8/29.
//  Copyright © 2017年 Leo. All rights reserved.
//

#import "ForkliftDriverStatus226Controller.h"

@interface ForkliftDriverStatus226Controller ()

@property (weak, nonatomic) IBOutlet UIView *backgroundView;
@property (weak, nonatomic) IBOutlet UIButton *tuNumberButton;
@property (weak, nonatomic) IBOutlet UILabel *wharfLabel;
@property (weak, nonatomic) IBOutlet UIImageView *qrcodeImgView;
@property (weak, nonatomic) IBOutlet UILabel *statusDescriptionLabel;

@end

@implementation ForkliftDriverStatus226Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view.backgroundColor = TOP_NAVIBAR_COLOR;
    self.backgroundView.layer.masksToBounds = YES;
    self.backgroundView.layer.cornerRadius = 10;
    self.qrcodeImgView.image = [QrcodeHelper createLogoQrcodeImageWithMessage:@"TU10001" logoImage:[UIImage imageNamed:@"applogo"] imageSize:self.qrcodeImgView.bounds.size.width];
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
