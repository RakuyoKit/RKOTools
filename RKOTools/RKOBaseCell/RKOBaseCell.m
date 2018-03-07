//
//  RKOBaseCell.m
//  RKOTools
//
//  Created by Rakuyo on 2017/8/14.
//  Copyright © 2017年 Rakuyo. All rights reserved.
//

#import "RKOBaseCell.h"

@implementation RKOBaseCell

// 快速获取 cell
+ (instancetype)cell:(UITableView *)tableView {
    NSString *ID = NSStringFromClass(self);
    RKOCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        [tableView registerClass:self forCellReuseIdentifier:ID];
        cell = [tableView dequeueReusableCellWithIdentifier:ID];
    }
    
    return cell;
}

// 从xib中获取cell
+ (instancetype)xibCell:(UITableView *)tableView {
    NSString *ID = NSStringFromClass(self);
    RKOCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        [tableView registerNib:[UINib nibWithNibName:ID bundle:nil] forCellReuseIdentifier:ID];
        cell = [tableView dequeueReusableCellWithIdentifier:ID];
    }
    
    return cell;
}

// 获取一个空白的cell
+ (id)blankCell:(UITableView*)tableView {
    static NSString *const ID = @"RKOBlanckCellID";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ID];
        cell = [tableView dequeueReusableCellWithIdentifier:ID];
    }
    return cell;
}

@end
