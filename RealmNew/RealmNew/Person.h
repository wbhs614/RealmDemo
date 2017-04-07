//
//  Person.h
//  KKRealm
//
//  Created by kkmac on 2017/3/13.
//  Copyright © 2017年 kkmac. All rights reserved.
//

#import "KKBaseObject.h"
@interface Person : KKBaseObject
@property (nonatomic,strong)NSString *name;
@property (nonatomic,strong)NSString *sex;
@property (nonatomic,assign)NSInteger age;
@property (nonatomic,assign)NSString *timeStamp;
@end
