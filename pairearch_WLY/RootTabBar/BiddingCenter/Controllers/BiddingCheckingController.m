//
//  BiddingCheckingController.m
//  pairearch_WLY
//
//  Created by Jean on 2017/5/24.
//  Copyright © 2017年 Leo. All rights reserved.
//

#import "BiddingCheckingController.h"

#import "BiddingCheckingModel.h"

@interface BiddingCheckingController ()

@property (weak, nonatomic) IBOutlet UIButton *changeBiddingBtn;
@property (weak, nonatomic) IBOutlet UIButton *cancelBiddingBtn;

@end

@implementation BiddingCheckingController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.changeBiddingBtn.backgroundColor = MAIN_THEME_COLOR;
    self.cancelBiddingBtn.backgroundColor = MAIN_THEME_COLOR;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)setBidCode:(NSString *)bidCode {
    _bidCode = bidCode;
    if (bidCode.length > 0) {
        [self loadDataFromNet];
    }
}

//  请求网络数据
- (void)loadDataFromNet{
    [BiddingCheckingModel getDataWithParameters:@{@"phoneNumber":[LoginModel shareLoginModel].tel, @"bidCode":self.bidCode} endBlock:^(id model, NSError *error) {
        if (!error) {
            
        }
    }];
}
- (IBAction)changeBiddingAction:(UIButton *)sender {
    
}
- (IBAction)cancelBiddingAction:(UIButton *)sender {
    
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
