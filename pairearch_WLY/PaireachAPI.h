//
//  PaireachAPI.h
//  pairearch_WLY
//
//  Created by Leo on 2017/2/22.
//  Copyright © 2017年 Leo. All rights reserved.
//

#ifndef PaireachAPI_h
#define PaireachAPI_h

#pragma markk -- APP接口定义

/*============================BaseUrl相关=============================*/
//API前缀定义
#define PAIREACH_BIDDING_URL             @"http://106.14.39.65:8385/itip/clientBid/"  //竞价中心
#define PAIREACH_BASE_URL                @"http://106.14.39.65:8385/itip/client/"       //测试线上
//#define PAIREACH_BASE_URL                @"http://192.168.1.14:8086/itip/client/"     //备用
//#define PAIREACH_BASE_URL                @"http://itiptest.paireach.com/client/"       //双至域名


/*============================首页相关=============================*/

//首页数据
#define HOME_PAGE_DATA_API                @"loadFirstUnCheckOrder.a"            //get

//首页订单详情数据
#define LOAD_DETAIL_API                   @"loadOrderDetailById.a"              //get

//接收运单
#define GET_LOAD_API                      @"driverAcceptOrder.a"                //post

//安全选项检查
#define SAFETY_CONFIRMATION_API           @"safeVeriSave.a"                     //post

//地理位置上传
#define UPLOAD_LOCATION_API                  @"saveTrackList.a"                //post



/*============================运单中心用户相关=============================*/

//订单中心
#define ORDER_LIST_API                    @"loadAllOrder.a"                 //get

//入厂签到
#define SIGN_UP_API                       @"orderHandling.a"                //post

//装货开始扫码
#define LOAD_START_API                    @"loadStartOrder.a"               //get

//装货结束扫码
#define LOAD_END_API                      @"loadEndOrder.a"                 //get

//修改预计到货时间
#define CHANGE_PLAN_ARRIVETIME_API        @"savePlanAchieveTime.a"          //post

//收货签到
#define DELIVERY_SIGN_UP_API              SIGN_UP_API                       //post

//收货完成
#define  DELIVERY_COMPLETE_API            SIGN_UP_API                       //post



/*============================竞价中心相关=============================*/

//竞价中
#define IN_BIDDING_API                    @"queryByScOrderBidForaudit.a"    //get

//竞价中详情
#define BIDDING_DETAIL_API                @"loadByScOrderBidDetails.a"      //get


//审核中
#define IN_CHECK_API                      @"queryAllScOrderBidForaudit.a"   //get

//已中标
#define ALREADY_BIDDING_API               @"queryByScOrderBidForZb.a"       //get

//历史竞价
#define HISTORY_BIDDING_API               @"queryByScOrderBidHostory.a"     //get



/*============================个人中心用户相关=============================*/

//用户登录
#define USER_LOGIN_API                    @"loginForDriver.a"                   //post

//修改密码
#define CHANGE_PASSWORD_API               @"changeDriverPwd.a"                  //post

//异常反馈
#define ABNORMAL_UPLOAD_API               @"uploadAbnormalPresentationInfo.a"   //post






/*============================通知中心相关=============================*/

#pragma mark -- 通知中心

//接收到JPush自定义消息通知
#define GET_CUSTOM_MESSAGE_NAME           @"get_custom_message_name"           //get







#endif /* PaireachAPI_h */
