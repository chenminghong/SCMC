//
//  AlterPasswordViewController.m
//  WLY
//
//  Created by Leo on 16/3/21.
//  Copyright © 2016年 Leo. All rights reserved.
//

#import "AlterPasswordViewController.h"

#import "LoginViewController.h"
#import <CommonCrypto/CommonDigest.h>

@interface AlterPasswordViewController ()
@property (nonatomic, strong) UITextField *passwordTF;
@property (nonatomic, strong) UITextField *confirmNewPasswordTF;

@end

@implementation AlterPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"设置密码";
    
    //新密码
    self.passwordTF = [[UITextField alloc] initWithFrame:CGRectMake(20, 15, self.view.frame.size.width - 40, 40)];
    self.passwordTF.placeholder = @"新密码";
    self.passwordTF.secureTextEntry = YES;
    self.passwordTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:self.passwordTF];
    
    //第二条分隔线
    UIView *secondLine = [[UIView alloc] initWithFrame:CGRectMake(10, self.passwordTF.frame.origin.y + self.passwordTF.frame.size.height + 5, kScreenWidth - 20, 2)];
    secondLine.backgroundColor = [UIColor colorWithRed:231 / 255.0 green:231 / 255.0 blue:231 / 255.0 alpha:1.0];
    [self.view addSubview:secondLine];
    
    //再次输入新密码
    self.confirmNewPasswordTF = [[UITextField alloc] initWithFrame:CGRectMake(self.passwordTF.frame.origin.x, secondLine.frame.origin.y + secondLine.frame.size.height + 10, self.passwordTF.frame.size.width, self.passwordTF.frame.size.height)];
    self.confirmNewPasswordTF.placeholder = @"再次输入新密码";
    self.confirmNewPasswordTF.secureTextEntry = YES;
    self.confirmNewPasswordTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:self.confirmNewPasswordTF];
    
    //第三条分隔线
    UIView *thirdLine = [[UIView alloc] initWithFrame:CGRectMake(secondLine.frame.origin.x, self.confirmNewPasswordTF.frame.origin.y + self.confirmNewPasswordTF.frame.size.height + 5, secondLine.frame.size.width, secondLine.frame.size.height)];
    thirdLine.backgroundColor = [UIColor colorWithRed:231 / 255.0 green:231 / 255.0 blue:231 / 255.0 alpha:1.0];
    [self.view addSubview:thirdLine];
    
    //确定button
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//    [button setBackgroundImage:[UIImage imageNamed:@"btn_big_nor.png"] forState:UIControlStateNormal];
    button.backgroundColor = MAIN_THEME_COLOR;
    [button  setTitle:@"确定" forState:UIControlStateNormal];
    [button setTintColor:[UIColor whiteColor]];
    [button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    __weak typeof(self) weakSelf = self;
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(thirdLine.mas_bottom).with.offset(20);
        make.centerX.equalTo(weakSelf.view);
        make.size.mas_equalTo(CGSizeMake(weakSelf.view.frame.size.width / 2, 40));
    }];
}

//确定button
- (void)buttonAction {
    //判断原密码、新密码和确认密码是否为空
    if (0 == self.passwordTF.text.length || 0 == self.confirmNewPasswordTF.text.length) {
        //提醒用户输入信息不能为空
        [MBProgressHUD bwm_showTitle:@"输入的密码不能为空" toView:self.view hideAfter:2.0];
        return;
    } else {
        //如果修改密码与确认密码不相同，提醒用户
        if (![self.passwordTF.text isEqualToString:self.confirmNewPasswordTF.text]) {
            [MBProgressHUD bwm_showTitle:@"两次密码输入不一致，请重新输入！" toView:self.view hideAfter:2.0];
            self.passwordTF.text = @"";
            self.confirmNewPasswordTF.text = @"";
            return;
        } else {
            //请求修改密码
            [self postRequestForAlterPassword];
        }
    }
}

//请求修改密码
- (void)postRequestForAlterPassword {
    [self.view endEditing:YES];
    NSDictionary *paraDict = @{@"account":[[NSUserDefaults standardUserDefaults] objectForKey:USER_NUMBER], @"password":[BaseModel md5HexDigest:self.passwordTF.text], @"comfrmPwd":[BaseModel md5HexDigest:self.confirmNewPasswordTF.text], OPERATION_KEY:CHANGE_PASSWORD_API};
    MBProgressHUD *hud = [MBProgressHUD bwm_showHUDAddedTo:self.view title:@"正在修改密码..."];
    [NetworkHelper POST:PAIREACH_NETWORK_URL parameters:paraDict hudTarget:[UIApplication sharedApplication].keyWindow progress:nil endResult:^(NSURLSessionDataTask *task, id responseObject, NSError *error) {
        [hud hide:YES];
        if (!error) {
            MBProgressHUD *hud1 = [MBProgressHUD bwm_showTitle:@"密码修改成功!" toView:self.view hideAfter:2.0];
            __weak typeof(self) weakself = self;
            [hud1 setCompletionBlock:^(){
                [LoginViewController showSelfInController:weakself completeBlock:^{
                    [weakself.navigationController popViewControllerAnimated:NO];
                }];
            }];
            [[NSUserDefaults standardUserDefaults] setValue:[BaseModel md5HexDigest:self.passwordTF.text] forKey:USER_ACCOUNT];
        }
    }];
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
