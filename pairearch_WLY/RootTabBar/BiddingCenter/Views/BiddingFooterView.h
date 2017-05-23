//
//  BiddingFooterView.h
//  pairearch_WLY
//
//  Created by Jean on 2017/5/23.
//  Copyright © 2017年 Leo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BiddingFooterView : UIView
@property (weak, nonatomic) IBOutlet UILabel *tonnageLabel;            //货物吨重
@property (weak, nonatomic) IBOutlet UIButton *supplierButton;          //承运商按钮
@property (weak, nonatomic) IBOutlet UIButton *plateNumberBotton;       //车牌号按钮
@property (weak, nonatomic) IBOutlet UILabel *remainderTimeLabel;      //剩余时间标签
@property (weak, nonatomic) IBOutlet UITextField *biddingTf;  //报价输入框
@property (weak, nonatomic) IBOutlet UIButton *rapButton;               //抢单按钮

/**
 加载视图
 */
+ (instancetype)getFooterView;

@end
