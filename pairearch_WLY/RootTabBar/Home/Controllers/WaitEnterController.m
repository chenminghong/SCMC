//
//  WaitEnterController.m
//  pairearch_WLY
//
//  Created by Jean on 2017/8/18.
//  Copyright © 2017年 Leo. All rights reserved.
//

#import "WaitEnterController.h"

#import "CustomHexagonLabel.h"
#import "PrepareEnterController.h"

@interface WaitEnterController ()

@property (weak, nonatomic) IBOutlet UIView *bottomBackgroundView;

@property (nonatomic, strong) CustomHexagonLabel *topStatusLabel;
@property (weak, nonatomic) IBOutlet UILabel *carCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *planEnterTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *pageDesLabel;
@property (weak, nonatomic) IBOutlet UIView *labelView;
@property (weak, nonatomic) IBOutlet UILabel *enterDesLabel;

@end

@implementation WaitEnterController

#pragma mark -- Lazy Loading

- (CustomHexagonLabel *)topStatusLabel {
    if (!_topStatusLabel) {
        self.topStatusLabel = [CustomHexagonLabel new];
        [self.bottomBackgroundView addSubview:self.topStatusLabel];
        [self.topStatusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            CGFloat top = CGRectGetHeight(self.bottomBackgroundView.bounds)*40/982.0;
            CGFloat width = CGRectGetWidth(self.bottomBackgroundView.bounds) * 220 / 600.0;
            CGFloat height = CGRectGetHeight(self.bottomBackgroundView.bounds) * 60 / 982.0;
            make.top.equalTo(self.bottomBackgroundView.mas_top).with.offset(top);
            make.centerX.mas_equalTo(self.bottomBackgroundView.mas_centerX);
            make.size.mas_equalTo(CGSizeMake(width, height));
        }];
        self.topStatusLabel.backgroundColor = UIColorFromRGB(0x00a7eb);
        self.topStatusLabel.text = @"等待入厂";
        self.topStatusLabel.textColor = [UIColor whiteColor];
        self.topStatusLabel.font = [UIFont systemFontOfSize:20.0];
        self.topStatusLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _topStatusLabel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view.backgroundColor = TOP_NAVIBAR_COLOR;
    self.bottomBackgroundView.layer.masksToBounds = YES;
    self.bottomBackgroundView.layer.cornerRadius = 10;
    [self.bottomBackgroundView addSubview:self.topStatusLabel];
    self.labelView.layer.masksToBounds = YES;
    self.labelView.layer.cornerRadius = 5;
    self.enterDesLabel.layer.masksToBounds = YES;
    self.enterDesLabel.layer.cornerRadius = 5;
    
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    PrepareEnterController *prepareVC = [PrepareEnterController new];
    [self.navigationController pushViewController:prepareVC animated:YES];
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
