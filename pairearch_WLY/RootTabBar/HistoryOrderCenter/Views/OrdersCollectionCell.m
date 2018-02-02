//
//  OrdersCollectionCell.m
//  pairearch_WLY
//
//  Created by Leo on 2017/2/17.
//  Copyright © 2017年 Leo. All rights reserved.
//

#import "OrdersCollectionCell.h"

#import "ListTableCell.h"
#import "OrderListModel.h"
#import "TransferBidListCell.h"

@implementation OrdersCollectionCell

//加载cell
+ (instancetype)getCellWithCollectionView:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath pushBlock:(PushActionBlock)pushBlock {
    NSString *reuseIdentifier = [NSString stringWithFormat:@"cell%ld", (long)indexPath.item];
    OrdersCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.indexPath = indexPath;
    cell.pushBlock = pushBlock;
    return cell;
}

#pragma mark -- LazyLoding

- (UITableView *)listTableView {
    if (!_listTableView) {
        self.listTableView = [UITableView new];
        [self addSubview:self.listTableView];
        [self.listTableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.and.left.and.bottom.and.right.mas_equalTo(self);
        }];
        self.listTableView.delegate = self;
        self.listTableView.dataSource = self;
        self.listTableView.tableFooterView = [UIView new];
        self.listTableView.backgroundColor = TABLE_BACKGROUND_COLOR;
        self.listTableView.separatorColor = TABLE_SEPARATOR_COLOR;
        self.listTableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        self.listTableView.placeHolderView = [NoDataView getPlaceHoldViewWithImgName:@"zanwujingjia" titleText:@"暂无数据"];
        [MJRefreshUtil pullDownRefresh:self andScrollView:self.listTableView andAction:@selector(loadData)];
    }
    return _listTableView;
}

- (void)setIndexPath:(NSIndexPath *)indexPath {
    _indexPath = indexPath;
    switch (indexPath.item) {
        case 0:
        {
            self.url = nil;          //竞价历史
        }
            break;
            
        case 1:
        {
            self.url = nil;            //转竞价历史
        }
            break;
            
        case 2:
        {
            self.url = GET_DRIVER_HISTORY_API;  //装运历史数据
        }
            break;
            
        default:
        {
            self.url = IN_BIDDING_API; //竞价中
        }
            break;
    }
}

//  请求网络数据
- (void)loadData {
    [self.listModelArr removeAllObjects];
    if (!self.url) {
        [self.listTableView reloadData];
        [MJRefreshUtil endRefresh:self.listTableView];
        return;
    }
    [OrderListModel getDataWithUrl:PAIREACH_NETWORK_URL parameters:@{@"driverTel":[LoginModel shareLoginModel].phone, OPERATION_KEY:self.url} hudTarget:self endBlock:^(NSURLSessionDataTask *task, id responseObject, NSError *error) {
        if (!error) {
            OrderListModel *model = responseObject;
            self.listModelArr = [NSMutableArray arrayWithArray:model.modelListArr];
        }
        [self.listTableView reloadData];
        [MJRefreshUtil endRefresh:self.listTableView];
    }];
}


#pragma marks -- TableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.listModelArr.count>0? 1:0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listModelArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    OrderListModel *orderModel = self.listModelArr[indexPath.row];
//    CGFloat specialExplainConstant = [BaseModel heightForTextString:orderModel.specialExplain width:(kScreenWidth - 100.0)  fontSize:CELL_LABEL_FONTSIZE];
//    CGFloat height = 140 + specialExplainConstant;
//    return height;
    return 225;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.indexPath.item == 0) {
        ListTableCell *cell = [ListTableCell getCellWithTable:tableView indexPath:indexPath];
        return cell;
    }
    TransferBidListCell *cell = [TransferBidListCell getCellWithTable:tableView indexPath:indexPath];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.pushBlock) {
//        OrderListModel *model = self.listModelArr[indexPath.row];
//        NSMutableArray *modelArr = [NSMutableArray arrayWithObject:model];
//        self.pushBlock(modelArr, self.indexPath);
    }
}

@end
