//
//  BidddingDetailModel.h
//  pairearch_WLY
//
//  Created by Jean on 2017/5/23.
//  Copyright © 2017年 Leo. All rights reserved.
//

#import "BaseModel.h"

@interface BidddingDetailModel : BaseModel

/**
 {
 driver =     (
 {
 truckNumber = "\U9ed1B00000";
 }
 );
 product =     (
 (
 {
 bidCode = 10163412;
 createtime = "2017-05-22 15:59:28";
 dealCode = 17052215565428108661;
 id = 1501;
 planProductNums = 2000;
 productCode = 101134;
 productName = "ME\U7f8e\U6c41\U6e90\U679c\U7c92\U6a59P450ml*12-ME\U666e\U901a\U7248C";
 productWeight = "5.9";
 tunnage = "11.8";
 updatetime = "2017-05-22 15:59:29";
 }
 )
 );
 scorderbid =     (
 {
 amount = 0;
 bidCode = 10163412;
 bidKamApprove = 0;
 bidResult = 0;
 bidSupplierAmount = 0;
 bidTunnage = 0;
 dcName = "\U5357\U4eac\U6d66\U53e3\U9ad8\U65b0\U6280\U672f\U5f00\U53d1\U533a\U65b0\U79d1\U4e8c\U8def26\U53f7 ";
 deadlineTime = "2017-05-23 15:58:00";
 driverNum = 0;
 id = 0;
 isOffer = 0;
 isOfferCancel = 0;
 planDate = "2017-05-24 00:00:00";
 rev = 0;
 sourceName = "\U9655\U897f\U7701\U54b8\U9633\U5e02\U4e09\U539f\U53bf\U6e05\U6cb3\U98df\U54c1\U5de5\U4e1a\U56ed\U98df\U54c1\U4e00\U8def";
 supplierNum = 0;
 tunnage = "11.8";
 tunnageNew = 0;
 valid = 0;
 }
 );
 supplie =     (
 {
 supplierCode = 00200301;
 supplierName = "\U53a6\U95e8\U5b8f\U8c61\U7269\U6d41\U79d1\U6280\U6709\U9650\U516c\U53f8";
 }
 );
 }

 */

@property (nonatomic, strong) NSMutableArray *scorderbidArr;  //当前页竞价单列表

@property (nonatomic, strong) NSMutableArray *productArr;     //产品详情列表

@property (nonatomic, strong) NSMutableArray *supplieArr;     //承运商列表

@property (nonatomic, strong) NSMutableArray *driverArr;      //车牌号列表


//scorderbid

@property (nonatomic, copy) NSString *bidCode;             //竞价单号

@property (nonatomic, copy) NSString *sourceName;          //发货地名称

@property (nonatomic, copy) NSString *dcName;              //收货地名称

@property (nonatomic, copy) NSString *planDate;            //装运时间

@property (nonatomic, copy) NSString *specialExplain;      //装运要求

@property (nonatomic, copy) NSString *tunnage;             //吨重


//pruduct

@property (nonatomic, copy) NSString *productName;         //产品名称

//@property (nonatomic, copy) NSString *tunnage;             //重量

@property (nonatomic, copy) NSString *planProductNums;     //计划数量


//supplier

@property (nonatomic, copy) NSString *supplierCode;         //承运商编码

@property (nonatomic, copy) NSString *supplierName;         //承运商名称


//driver

@property (nonatomic, copy) NSString *truckNumber;          //车牌号




@end
