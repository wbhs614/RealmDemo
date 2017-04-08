//
//  KKBaseObject.h
//  RealmNew
//
//  Created by kkmac on 2017/4/7.
//  Copyright © 2017年 kkmac. All rights reserved.
//

#import <Realm/Realm.h>

@interface KKBaseObject : RLMObject
/**
 获取指定路径的数据库
 @param  realmName 数据库的名字（默认的数据库则传nil）
 @return return value description
 */
+(RLMRealm *)getCustomRealmWithName:(NSString *)realmName;

/**
 获取所有的数据集(适合根据多个属性进行排序)
 @param realmName 数据库名称（默认数据库则传nil）
 @param descriptors 排序器（RLMSortDescriptor类型，不排序传nil即可）
 @return 所有的数据集
 */
+(RLMResults *)getAllObjectsWithRealmName:(NSString *)realmName sortedDescriptors:(NSArray *)descriptors;

/**
 获取所有的数据集（适合根据单个属性进行排序）
 @param realmName 数据库名称（默认数据库则传nil）
 @param keyPath 排序关键字（不排序则传传nil）
 @return 所有的数据集
 */
+(RLMResults *)getAllObjectsWithRealmName:(NSString *)realmName sortedByKePath:(NSString *)keyPath ascending:(BOOL)ascending;

/**
 通过字符串查询(适合根据单个属性进行排序)
 @param where 查询条件字符串(指定数据库需要传入数据库名字，默认数据库需要传入nil即可)
 @param realmName 数据库的名称（默认数据库则传nil）
 @param keyPath 排序关键字（不排序传nil即可）
 @param ascending 是否升序排列
 @return 结果集
 */
+(RLMResults *)getObjetctsWithWhere:(NSString *)where realm:(NSString *)realmName sortedByKePath:(NSString *)keyPath ascending:(BOOL)ascending;

/**
 通过字符串查询(适合根据多个属性进行排序)
 @param where 查询条件字符串(指定数据库需要传入数据库名字，默认数据库需要传入nil即可)
 @param realmName 数据库的名称（默认数据库则传nil）
 @param descriptors 排序器（RLMSortDescriptor类型）
 @return 结果集
 */
+(RLMResults *)getObjetctsWithWhere:(NSString *)where realm:(NSString *)realmName sortedDescriptors:(NSArray *)descriptors;

/**
 通过谓词查询数据集(适合根据多个属性进行排序)
 @param predicate 查询谓词
 @param realmName 数据库的名称（默认数据库则传nil）
 @param descriptors 排序器（RLMSortDescriptor类型,不排序传nil即可）
 @return 结果集
 */
+(RLMResults *)getObjectWithPredicate:(NSPredicate *)predicate realm:(NSString *)realmName sortedDescriptors:(NSArray *)descriptors;

/**
 通过谓词查询数据集（适合根据单个属性进行排序）
 @param predicate 查询谓词
 @param realmName 数据库的名称（默认数据库则传nil）
 @param keyPath 排序关键字（不排序传nil即可）
 @param ascending 是否升序排列
 @return 结果集
 */
+(RLMResults *)getObjectWithPredicate:(NSPredicate *)predicate realm:(NSString *)realmName sortedByKePath:(NSString *)keyPath ascending:(BOOL)ascending;

/**
 对数据库进行增加或者更新当个对象
 @param ojbect 单个对象
 @param realmName 数据库名字（默认数据库则传nil）
 @param block 解决更新属性前必须beginWriteTransaction的操作。
 */
+(void)addorUpdateWithObject:(RLMObject *)ojbect realm:(NSString *)realmName afterBlock:(void (^)(void))block;

/**
 对数据库进行增加或者更新数组集
 @param objects 数据集
 @param realmName 数据库名字（默认数据库则传nil）
 */
+(void)addorUpdateWithObjects:(id)objects realm:(NSString *)realmName;


/**
 添加数据（不含更新）
 @param object 增加或者更新的对象
 @param realmName 数据库名字（默认数据库则传nil）
 */
+(void)addSingleObject:(RLMObject *)object realmName:(NSString *)realmName;

/**
 通过谓词删除指定数据
 @param predicate 谓词
 @param realmName 数据库名称(默认数据库则传nil)
 */
+(void)deleteObjectsWithPredicate:(NSPredicate *)predicate realmName:(NSString *)realmName;

/**
 通过where字符串数据指定数据
 @param where where字符串
 @param realmName 数据库名称(默认数据库则传nil)
 */
+(void)deleteObjectsWithWhere:(NSString *)where realmName:(NSString *)realmName;

/**
 删除数据库中的所有数据
 @param realmName 数据库名称(默认数据库则传nil)
 */
+(void)deleteAllObjectsWithRealmName:(NSString *)realmName;
@end
