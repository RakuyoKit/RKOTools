//
//  RKOBaseCell.h
//  RKOTools
//
//  Created by Rakuyo on 2017/8/14.
//  Copyright © 2017年 Rakuyo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RKOBaseCell : UITableViewCell

/**
 快速获取 cell

 @param tableView 当前的tableView
 @return 一个普通的cell
 */
+ (instancetype)cell:(UITableView *)tableView;

/**
 从xib中获取cell

 @param tableView 当前的tableView
 @return 从xib中获取到的cell
 */
+ (instancetype)xibCell:(UITableView *)tableView;

/**
 获取一个空白的cell

 @param tableView 当前的tableView
 @return 一个空白的cell
 */
+ (id)blankCell:(UITableView *)tableView;

@end

