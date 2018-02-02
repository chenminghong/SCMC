//
//  OrdersCollectionCell.m
//  pairearch_WLY
//
//  Created by Leo on 2017/2/17.
//  Copyright © 2017年 Leo. All rights reserved.
//

#import "TransationCollectionCell.h"

#import "ListTableCell.h"
#import "OrderListModel.h"
#import "TransationListCell.h"

@implementation TransationCollectionCell

//加载cell
+ (instancetype)getCellWithCollectionView:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath pushBlock:(PushActionBlock)pushBlock {
    NSString *reuseIdentifier = [NSString stringWithFormat:@"%ld", (long)indexPath.item];
    [collectionView registerClass:[TransationCollectionCell class] forCellWithReuseIdentifier:reuseIdentifier];
    TransationCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.indexPath = indexPath;
    cell.pushBlock = pushBlock;
    return cell;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self addSubview:self.listTableView];
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
        self.listTableView.placeHolderView = [NoDataView getPlaceHoldViewWithImgName:@"jingqingqidai" titleText:@"功能正在开发，敬请期待"];
        [MJRefreshUtil pullDownRefresh:self andScrollView:self.listTableView andAction:@selector(loadDataFromNet)];
    }
    return _listTableView;
}

- (void)setIndexPath:(NSIndexPath *)indexPath {
    _indexPath = indexPath;
    switch (indexPath.item) {
        case 0:
        {
            self.url = IN_BIDDING_API;//竞价中
        }
            break;
            
        case 1:
        {
            self.url = IN_CHECK_API; //审核中
        }
            break;
            
        case 2:
        {
            self.url = ALREADY_BIDDING_API;  //已中标
        }
            break;
            
        case 3:
        {
            self.url = HISTORY_BIDDING_API; //历史竞价
        }
            break;
            
        default:
        {
            self.url = IN_BIDDING_API; //竞价中
        }
            break;
    }
}

- (void)setListModelArr:(NSMutableArray *)listModelArr {
    _listModelArr = listModelArr;
}

//  请求网络数据
- (void)loadDataFromNet {
    [self.listModelArr removeAllObjects];
    [MJRefreshUtil endRefresh:self.listTableView];
    [self.listTableView reloadData];
    /*
     [OrderListModel getDataWithOperation:self.url.length>0? self.url:@"" parameters:@{@"phoneNumber":[LoginModel shareLoginModel].phone, @"item":@(self.indexPath.item)} endBlock:^(id model, NSError *error) {
     if (!error) {
     self.listModelArr = [NSMutableArray arrayWithArray:model];
     } else {
     [MBProgressHUD bwm_showTitle:error.userInfo[ERROR_MSG] toView:self.listTableView.superview hideAfter:HUD_HIDE_TIMEINTERVAL/2.0];
     }
     
     [self.listTableView reloadData];
     [MJRefreshUtil endRefresh:self.listTableView];
     }];
     */
}


#pragma marks -- TableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return self.listModelArr.count;
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    OrderListModel *orderModel = self.listModelArr[indexPath.row];
//    CGFloat specialExplainConstant = [BaseModel heightForTextString:orderModel.specialExplain width:(kScreenWidth - 100.0)  fontSize:CELL_LABEL_FONTSIZE];
//    CGFloat height = 140 + specialExplainConstant;
//    return height;
    return 260;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TransationListCell *cell = [TransationListCell getCellWithTable:tableView indexPath:indexPath offerButtonAction:^(NSIndexPath *indexPath) {
        if (self.pushBlock) {
            self.pushBlock(indexPath);
        }
    }];
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
