//
//  UITableView+EmptyExtension.m
//  WholeDemo
//
//  Created by company_2 on 2017/5/3.
//  Copyright © 2017年 company_2. All rights reserved.
//

#import "UITableView+EmptyExtension.h"
#import <objc/runtime.h>

//#define PLACE_HOLDER_VIEW_KEY  @"placeHolderView"

@implementation UITableView (EmptyExtension)

static char *PlaceHolderView = "placeHolderView";

//替换方法：
+ (void)swizzleOriginMethod:(SEL)oriSel Method:(SEL)newSel
{
    Method oriMethod = class_getInstanceMethod(self, oriSel);
    Method newMethod = class_getInstanceMethod(self, newSel);
    BOOL methodIsAdd = class_addMethod(self, oriSel, method_getImplementation(newMethod), method_getTypeEncoding(newMethod));
    if (methodIsAdd) {
        class_replaceMethod(self, newSel, method_getImplementation(oriMethod), method_getTypeEncoding(oriMethod));
    } else {
        method_exchangeImplementations(oriMethod, newMethod);
    }
}

//被应用的时候就会调用:
+ (void)load {
    //防止手动调用load出现多次调用的情况：
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self swizzleOriginMethod:@selector(reloadData) Method:@selector(customReloadData)];
    });
}

- (void)setPlaceHolderView:(UIView *)placeHolderView
{
    objc_setAssociatedObject(self, PlaceHolderView, placeHolderView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)placeHolderView
{
    return objc_getAssociatedObject(self, PlaceHolderView);
}


#pragma mark 自定义刷新方法：

- (void)customReloadData {
    [self checkIsEmpty];
    [self customReloadData];
}


- (void)checkIsEmpty {
    if (!self.placeHolderView) {
        return;
    }
    BOOL isEmpty = NO;
    id<UITableViewDataSource> src = self.dataSource;
    if ([src respondsToSelector:@selector(numberOfSectionsInTableView:)]) {//group
        NSInteger sections = [src numberOfSectionsInTableView:self];
        if (sections <= 0) {
            isEmpty = YES;
        }
    }
    if ([src respondsToSelector:@selector(tableView:numberOfRowsInSection:)]){
        NSInteger rows = [src tableView:self numberOfRowsInSection:0];//plain
        if (rows <= 0) {
            isEmpty = YES;
        }
    }
    if (isEmpty) {
        self.backgroundView = self.placeHolderView;
    }else{
        self.backgroundView = nil;
    }
}

@end
