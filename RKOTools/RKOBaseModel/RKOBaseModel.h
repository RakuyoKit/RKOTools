//
//  RKOBaseModel.h
//  RKOTools
//
//  Created by Rakuyo on 2018/1/17.
//  Copyright © 2018年 Rakuyo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <YYModel/YYModel.h>

@interface RKOBaseModel : NSObject <NSCoding, NSCopying>

/** 快速获取模型 */
+ (instancetype)model;

@end
