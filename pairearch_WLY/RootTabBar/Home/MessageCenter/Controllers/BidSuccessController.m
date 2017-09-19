//
//  BidSuccessController.m
//  pairearch_WLY
//
//  Created by Jean on 2017/9/19.
//  Copyright © 2017年 Leo. All rights reserved.
//

#import "BidSuccessController.h"

@interface BidSuccessController ()
{
    NSAttributedString *phoneNumber;
}
@property (weak, nonatomic) IBOutlet UIView *topView;

@property (strong, nonatomic) KZLinkLabel *descriptionLabel;


@end

@implementation BidSuccessController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view.backgroundColor = TOP_NAVIBAR_COLOR;
    self.title = @"消息";
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSAttributedString *desStr = [[NSAttributedString alloc] initWithString:@"*提示信息：您可在历史运单中查看竞价成功的运单信息，请尽快去待运送运单列表，预约装货时间，如暂时无装运单，请等待装运单下发，或者联系平台客服，平台客服联系方式：021-51039231"];
    self.descriptionLabel.attributedText = desStr;
    self.descriptionLabel.linkTapHandler = ^(KZLinkType linkType, NSString *string, NSRange range){
        if (linkType == KZLinkTypeURL) {
            //            [self openURL:[NSURL URLWithString:string]];
        } else if (linkType == KZLinkTypePhoneNumber) {
            NSString *telString = [NSString stringWithFormat:@"tel://%@",string];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:telString]];
        } else {
            NSLog(@"Other Link");
        }
    };
}

- (KZLinkLabel *)descriptionLabel {
    if (!_descriptionLabel) {
        self.descriptionLabel = [KZLinkLabel new];
        [self.view addSubview:self.descriptionLabel];
        [self.descriptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.topView.mas_bottom).with.offset(30);
            make.left.mas_equalTo(self.view.mas_left).with.offset(20);
            make.right.mas_equalTo(self.view.mas_right).with.offset(-20);
        }];
        self.descriptionLabel.font = [UIFont systemFontOfSize:16];
        self.descriptionLabel.backgroundColor = [UIColor clearColor];
        self.descriptionLabel.textColor = UIColorFromRGB(0xe35974);
        self.descriptionLabel.numberOfLines = 0;
        self.descriptionLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        self.descriptionLabel.linkColor = [UIColor blueColor];
        self.descriptionLabel.linkHighlightColor = [UIColor orangeColor];
    }
    return _descriptionLabel;
}

-(void)distinguishPhoneNumLabel:(UILabel *)label labelStr:(NSString *)labelStr{
    //获取字符串中的电话号码
    NSString *regulaStr = @"\\d{3,4}[- ]?\\d{7,8}"; NSRange stringRange = NSMakeRange(0, labelStr.length); //正则匹配
    NSError *error;
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:labelStr];
    NSRegularExpression *regexps = [NSRegularExpression regularExpressionWithPattern:regulaStr options:0 error:&error];
    if (!error && regexps != nil) {
        [regexps enumerateMatchesInString:labelStr options:0 range:stringRange usingBlock:^(NSTextCheckingResult * _Nullable result, NSMatchingFlags flags, BOOL * _Nonnull stop) {
            NSRange phoneRange = result.range;
            //定义一个NSAttributedstring接受电话号码字符串
            phoneNumber = [str attributedSubstringFromRange:phoneRange];
            //添加下划线
            NSDictionary *attribtDic = @{NSUnderlineStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
            [str addAttributes:attribtDic range:phoneRange];
            //设置文本中的电话号码显示为黄色
            [str addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0xFF8200) range:phoneRange];
            label.attributedText = str;
            label.userInteractionEnabled = YES;
            //添加手势，可以点击号码拨打电话
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGesture:)];
            [label addGestureRecognizer:tap];
        }];
    }
}

//实现拨打电话的方法
- (void)tapGesture:(UITapGestureRecognizer *)sender{
    NSString *deviceType = [UIDevice currentDevice].model;
    if(![deviceType isEqualToString:@"iPod touch"] &&
       ![deviceType isEqualToString:@"iPad"] && !
       [deviceType isEqualToString:@"iPhone Simulator"]) {
        //NSAttributedstring转换为NSString
        NSString *stringNum = [phoneNumber string];
        NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",stringNum];
        NSString *newStr = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        UIWebView * callWebview = [[UIWebView alloc] init];
        [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:newStr]]]; [self.view addSubview:callWebview];
    }
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
