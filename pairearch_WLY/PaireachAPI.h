//
//  PaireachAPI.h
//  pairearch_WLY
//
//  Created by Leo on 2017/2/22.
//  Copyright © 2017年 Leo. All rights reserved.
//

#ifndef PaireachAPI_h
#define PaireachAPI_h




//网络请求加密秘钥
#define SECURITY_KEY                      @"ApKKT6/wmftRRLh9aAd+lg=="   //MD5加密秘钥

//网络请求参数关键字
#define SIGN_KEY                          @"sign"               //密文
#define PARAMETER_KEY                     @"parameter"          //请求参数
#define MODULE_KEY                        @"module"             //模块
#define OPERATION_KEY                     @"operation"          //操作类型
#define REQUESTENTITY_KEY                 @"requestEntity"      //实际操作参数
#define APPVERSION_KEY                    @"appversion"         //APP版本
#define APPTYPE_KEY                       @"apptype"            //app类型
#define APPSYSTEM_KEY                     @"appsystem"          //app的系统类型
#define LIMIT_KEY                         @"limit"              //每页限制数量
#define START_KEY                         @"start"              //每页开始位置
#define UPLOAD_FILE_KEY                   @"type"               //上传拍照文件关键字
#define UPLOAD_FILE_VALUE                 @"operationProcess"   //上传拍照文件要添加的type键值对的value值
#define WHETHER_NEED_LOCATION_KRY         @"whether_need_location"  //是否需要上传位置信息
//网络请求数据解析关键字
#define RESULT_FLAG_KEY                   @"resultFlag"         //请求成功标识
#define MESSAGE_KEY                       @"message"            //请求成功失败提示语句
#define RESPONSE_ENTITY_KEY               @"responseEntity"     //供界面显示使用的Data数据


#pragma markk -- APP接口定义

/*============================BaseUrl相关=============================*/
//API前缀定义
#define BASE_URL                @"http://139.196.188.185:8385/itip-app-web"    //测试线上
//#define BASE_URL                @"http://192.168.0.158:8283/itip-app-web"       //Ocean本地IP
//#define BASE_URL                @"http://itiptest.paireach.com/client/"        //双至域名

//改版APP数据请求接口
#define PAIREACH_NETWORK_URL                 @"mobileDispatch/index.html"    //测试环境
#define PAIREACH_NETWORK_UPLOAD_URL          @"mobileFile/index.html"        //上传图片的BaseUrl

//#define PAIREACH_NETWORK_URL                 @"mobileDispatch/index.html"      //Ocean本地环境
//#define PAIREACH_NETWORK_UPLOAD_URL          @"mobileFile/index.html"        //上传图片的BaseUrl



/*============================用户相关服务=============================*/

//APP接口服务类型
#define APP_USER_SERVICE_MODULE          @"appUserService"

//用户登录接口
#define USER_LOGIN_API                    @"appUserLogin"                //post

//修改密码接口
#define CHANGE_PASSWORD_API               @"appUpdatePwd"                //post

/*============================首页相关=============================*/

//数据个数统计模块首页
#define HOME_INDEX_MODULE                 @"appIndexService"              //get

//首页顶部图片数据
#define HOME_IMAGE_LIST_API               @"appIndexAdvert"                //get

//首页个数显示数据
#define HOME_TOTAL_API                    @"appIndexCount"                 //get



/*============================运单数据相关用户相关=============================*/

//订单服务模块
#define ORDER_SERVICE_MODULE              @"transportOrderService"

//待运送列表
#define WAIT_TRANSPORT_LIST_API           @"appWaitTransOrderList"    //get

//根据TU单获取TU单详情
#define GET_TU_DETAIL_API                 @"appGetTuDetailByCode"     //get

//点击订单获取订单详情
#define GET_ORDER_DETAIL_API              @"appGetOrderDetailByCode"  //get

//获取历史运单接口
#define GET_DRIVER_HISTORY_API            @"appGetDriverHistoryOrder"   //GET


/*============================运单流程操作相关=============================*/
//运单流程操作模块
#define DRIVER_VEHICLE_SERVICE_MODULE     @"driverVehicleService"    //POST

//接单操作调用接口
#define RECEIVE_ORDER_API                 @"driverAcceptOrder"    //GET

//各个流程节点操作接口
#define PROCESSNODE_OPERATION_API         @"driverProcessOperation"    //get

//获取配送中运单信息接口
#define GET_TRANSPORT_ORDERINFO_API       @"driverTranspOrderInfo"     //get

//查询前面排队的车子数量接口
#define GET_FRONTCAR_COUNT_API            @"queryLineUpCount"          //get


/*============================拍照上传操作相关=============================*/

//拍照上传模块
#define LOCATION_UPLOAD_MODULE            @"trajectoryAppService"

//拍照上传接口
#define LOCATION_UPLOAD_API               @"orderTrajectoryUpload"      //POST














//内仓司机装货入厂签到
#define SIGN_UP_API                       @"loadSignOrder.a"           //post

//是否可以进入装货工厂
#define CAN_ENTERFAC_API                  @"canEnterFactory.a"         //post

//外仓司机装货开始拍照
#define OUT_LOAD_START_API                @"loadSignOrder.a"           //post

//内仓司机装货开始拍照
#define INNEROUT_LOAD_START_API           @"loadStartOrder.a"          //post

//装货结束扫码(内/外仓)
#define LOAD_END_API                      @"loadEndOrder.a"            //post

//收货签到
#define DELIVERY_SIGN_UP_API              @"unloadStartOrder.a"        //post

//收货完成
#define  DELIVERY_COMPLETE_API            @"unloadEndOrder.a"          //post

//根据TU单号获取订单列表
#define GET_ORDERLIST_API                 @"queryOrdersByTu.a"         //post

//获取TU单列表数据
#define TU_LIST_API                       @"queryDriverAllTus.a"       //post









//订单中心
#define ORDER_LIST_API                    @"loadAllOrder.a"                 //get

//修改预计到货时间
#define CHANGE_PLAN_ARRIVETIME_API        @"savePlanAchieveTime.a"          //post

//收货完成（不需要上传图片）
//#define DELIVERY_COMPLETEBTN_API          @"unloadEndBeforeUrl.a"                //post
#define DELIVERY_COMPLETEBTN_API          @"orderHandling.a"                //post



/*============================竞价中心相关=============================*/

//竞价中
#define IN_BIDDING_API                    @"queryByScOrderBidForaudit.a"    //get

//竞价中详情
#define BIDDING_DETAIL_API                @"loadByScOrderBidDetails.a"      //get

//当前承运商下的司机车牌号
#define GET_DRIVER_API                    @"loadByScOrderBidDetails.a"      //get

//抢单操作
#define SCRATCH_ORDER_API                 @"saveScBidInfo.a"                //get

//审核中
#define IN_CHECK_API                      @"queryAllScOrderBidForaudit.a"   //get

//审核中运单详情
#define BIDDINF_CHECKING_API              @"loadByScOrderBidDetailsforSh.a" //get

//修改竞价
#define CHANGE_BIDDING_API                @"updateByScBidInfo.a"            //get

//取消竞价
#define CANCEL_BIDDING_API                @"deleteByScBidInfo.a"            //get


//已中标
#define ALREADY_BIDDING_API               @"queryByScOrderBidForZb.a"       //get

//已中标运单详情
#define ALREADY_BIDDING_DETAIL_API        @"loadScorderbidforZb.a"          //get

//历史竞价
#define HISTORY_BIDDING_API               @"queryByScOrderBidHostory.a"     //get



/*============================个人中心用户相关=============================*/
//异常反馈
#define ABNORMAL_UPLOAD_API               @"uploadAbnormalPresentationInfo.a"   //post






/*============================通知中心相关=============================*/

#pragma mark -- 通知中心

//接收到JPush自定义消息通知
#define GET_CUSTOM_MESSAGE_NAME           @"get_custom_message_name"           //get







#endif /* PaireachAPI_h */
