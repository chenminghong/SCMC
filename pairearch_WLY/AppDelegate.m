//
//  AppDelegate.m
//  pairearch_WLY
//
//  Created by Leo on 2017/2/14.
//  Copyright © 2017年 Leo. All rights reserved.
//

#import "AppDelegate.h"

#import "LoginViewController.h"
#import "RootTabController.h"
#import <XHVersion.h>

@interface AppDelegate ()<UNUserNotificationCenterDelegate, JPUSHRegisterDelegate>

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    if (![LoginViewController isLogin]) {
        [self loginPage];
    } else {
        [self mainAppPage];
    }
    
    //注册本地通知
    [self registerLocalNotification];
    
    //网络变化执行动作
    [self netWorkDidChangeAction];
    
    //添加百度统计
    [self startBaiduMob];
    
    //版本更新
    [self checkAppVersion];
    
    //初始化JPush
    [self registerJpushWithOptions:launchOptions];
    
    //注册自定义消息监听
    [self registerCustomerMessage];
    
    [[LocationManager shareManager] startUpdateLocation];
    
    return YES;
}

//检查App版本信息
- (void)checkAppVersion {
    //构建版本获取appID
    NSString *updateUrl = [NSString stringWithFormat:@"http://itunes.apple.com/cn/lookup?id=%@", APP_ID];
    [[NetworkHelper shareClient] GET:updateUrl parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *receiveDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        if ([[receiveDic valueForKey:@"resultCount"] integerValue] > 0) {
            
            NSDictionary *versionDict = [[receiveDic valueForKey:@"results"] objectAtIndex:0];
            //APP最新版本
            NSString *latestVersion = [versionDict objectForKey:@"version"];
            latestVersion = [latestVersion stringByReplacingOccurrencesOfString:@"." withString:@""];
            CGFloat latest = [latestVersion floatValue];
            
            //APP当前版本
            NSString *appCurVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
            appCurVersion = [appCurVersion stringByReplacingOccurrencesOfString:@"." withString:@""];
            CGFloat current = [appCurVersion floatValue];
            
            NSArray *ignoreVersonArr = [[NSUserDefaults standardUserDefaults] arrayForKey:IGNORE_UPDATE_VERSIONS];
            for (NSString *ignoreVersion in ignoreVersonArr) {
                if ([ignoreVersion isEqualToString:latestVersion]) {
                    return;
                }
            }
            
            if (latest > current && ![self.window.rootViewController.presentedViewController isKindOfClass:[UIAlertController class]]) {
                UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"提示" message:@"发现需要升级的新版本，现在去更新？" preferredStyle:UIAlertControllerStyleAlert];
                
                __block NSString *trackViewUrl = [versionDict objectForKey:@"trackViewUrl"];
                UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"忽略" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    NSMutableArray *versions = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] arrayForKey:IGNORE_UPDATE_VERSIONS]];
                    [versions addObject:latestVersion];
                    [[NSUserDefaults standardUserDefaults] setObject:versions forKey:IGNORE_UPDATE_VERSIONS];
                }];
                
                UIAlertAction *sure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:trackViewUrl] options:@{@"open":@"update"} completionHandler:nil];
                }];
                [alertView addAction:cancel];
                [alertView addAction:sure];
                [self.window.rootViewController presentViewController:alertView animated:YES completion:nil];
            }
        }
    } failure:nil];
}


//切换回登录页
- (void)loginPage {
    LoginViewController *loginVC = [LoginViewController new];
    NavigationController *loginNC = [[NavigationController alloc] initWithRootViewController:loginVC];
    [self.window setRootViewController:loginNC];
}

//切换回首页
- (void)mainAppPage {
    RootTabController *rootTab = [RootTabController new];
    [self.window setRootViewController:rootTab];
}


/**
 注册监听自定义消息
 */
- (void)registerCustomerMessage {
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter addObserver:self selector:@selector(networkDidReceiveMessage:) name:kJPFNetworkDidReceiveMessageNotification object:nil];
}


/**
 收到自定义消息执行的通知方法

 @param notification 收到的消息对象
 */
- (void)networkDidReceiveMessage:(NSNotification *)notification {
    NSDictionary *userInfo = [notification userInfo];
    NSString *content = [userInfo valueForKey:@"content"];
//    NSDictionary *extras = [userInfo valueForKey:@"extras"];
//    NSString *customizeField1 = [extras valueForKey:@"customizeField1"]; //服务端传递的Extras附加字段，key是自己定义的
    
    [self addNetLocalNotificationWithDesStr:content];
    
}

//注册本地通知
- (void)registerLocalNotification {
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    [center requestAuthorizationWithOptions:(UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert) completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (!error) {
            NSLog(@"request authorization succeeded!");
        }
    }];
}


/**
 注册JPush通知

 @param launchOptions 登录参数
 */
- (void)registerJpushWithOptions:(NSDictionary *)launchOptions {
    
    NSLog(@"%s\n%@", __func__, launchOptions);
    [MBProgressHUD bwm_showTitle:NSStringFromClass([launchOptions class]) toView:self.window hideAfter:10.0];
    //notice: 3.0.0及以后版本注册可以这样写，也可以继续用之前的注册方式
    JPUSHRegisterEntity *entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    [JPUSHService setupWithOption:launchOptions appKey:JPUSH_APPKEY channel:@"APP Store" apsForProduction:0 advertisingIdentifier:nil];
}

#pragma mark -- JPushDelegate

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    // Required - 注册 DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
}


- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}


//iOS 10 support

/**
 程序在前台收到消息调用函数

 @param center 通知中心
 @param notification 前台通知对象
 @param completionHandler 完成回调
 */
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger options))completionHandler {
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler(UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以选择设置
    NSLog(@"%s\n%@", __func__, userInfo);
}

/**
 点击通知进入程序调用方法

 @param center 通知中心
 @param response 通知响应对象
 @param completionHandler 完成回调
 */
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)())completionHandler {
    // Required
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler(UNNotificationPresentationOptionAlert);  //系统要求执行这个方法
    NSLog(@"%s\n%@", __func__, userInfo);
}


//iOS 7 Remote Notification

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
    NSLog(@"%s\n%@", __func__, userInfo);
}

// iOS6 及以下
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    [JPUSHService handleRemoteNotification:userInfo];
    NSLog(@"%s\n%@", __func__, userInfo);
}

//网络变化通知
- (void)netWorkDidChangeAction {
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if (status == AFNetworkReachabilityStatusNotReachable) {
            if ([[UIApplication sharedApplication] applicationState] == UIApplicationStateBackground) {
                [self addNetLocalNotificationWithDesStr:@"网络连接已断开，请检查网络！"];
            } else {
                [MBProgressHUD bwm_showTitle:@"网络连接已断开，请检查网络！" toView:self.window hideAfter:HUD_HIDE_TIMEINTERVAL];
            }
        }
    }];
    [manager startMonitoring];
}

/**
 添加本地通知

 @param desStr 本地通知显示文字描述
 */
- (void)addNetLocalNotificationWithDesStr:(NSString *)desStr {
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    UNMutableNotificationContent *content = [UNMutableNotificationContent new];
    content.body = [NSString localizedUserNotificationStringForKey:desStr arguments:nil];
    content.sound = [UNNotificationSound defaultSound];
    
    NSString *requestIdentifier = [NSString stringWithFormat:@"%.0f", [[NSDate date] timeIntervalSince1970]];
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:requestIdentifier content:content trigger:nil];
    
    //添加推送成功后的处理！
    [center addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        if (!error) {
            NSLog(@"本地通知添加成功");
        }
    }];
}

//百度统计
- (void)startBaiduMob {
    
    //添加百度统计
    BaiduMobStat *statTracker = [BaiduMobStat defaultStat];
    statTracker.enableExceptionLog = YES; // 是否允许截获并发送崩溃信息，请设置YES或者NO
    statTracker.channelId = @"appStore";//设置您的app的发布渠道
    statTracker.sessionResumeInterval = 600;//设置应用进入后台再回到前台为同一次session的间隔时间[0~600s],超过600s则设为600s，默认为30s
    statTracker.enableDebugOn = NO; //调试的时候打开，会有log打印，发布时候关闭
    
    //开始上传
    [statTracker startWithAppId:APP_KEY];
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    
    [JPUSHService setBadge:0];//重置JPush服务器上面的badge值。如果下次服务端推送badge传"+1",则会在你当时JPush服务器上该设备的badge值的基础上＋1；
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];//apple自己的接口，变更应用本地（icon）的badge值；
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    
//    [self checkAppVersion];
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
