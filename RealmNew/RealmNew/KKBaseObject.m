//
//  KKBaseObject.m
//  RealmNew
//
//  Created by kkmac on 2017/4/7.
//  Copyright © 2017年 kkmac. All rights reserved.
//

#import "KKBaseObject.h"
typedef void (^afe)(void);
static RLMRealm *defaultRealm=nil;
static RLMRealm *customRealm=nil;
@implementation KKBaseObject

/**
 获取默认的realm数据库
 @return 返回realm数据库实例
 */
+(RLMRealm *)getDefaultRealm {
    defaultRealm = [RLMRealm defaultRealm];
    return defaultRealm;
}

/**
 获取指定路径的数据库
 @param  realmName 数据库的名字
 @return return value description
 */
+(RLMRealm *)getCustomRealmWithName:(NSString *)realmName {
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSString *realmPath = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.realm",realmName]];
    customRealm = [RLMRealm realmWithURL:[NSURL fileURLWithPath:realmPath]];
    return customRealm;
}


/**
 获取所有的数据集
 @param realmName 数据库名称（默认数据库则传nil）
 @param descriptors 排序器（RLMSortDescriptor类型，不排序传nil即可）
 @return 所有的数据集
 */
+(RLMResults *)getAllObjectsWithRealmName:(NSString *)realmName sortedDescriptors:(NSArray *)descriptors{
    RLMResults *results=nil;
    if (realmName) {
       RLMRealm* realm=[self getCustomRealmWithName:realmName];
        if (realm) {
            results=[self allObjectsInRealm:realm];
        }
    }
    else {
           results=[self allObjects];
    }
    if (results&&descriptors) {
        results=[results sortedResultsUsingDescriptors:descriptors];
    }
    return results;
}

/**
 获取所有的数据集（适合根据单个属性进行排序）
 @param realmName 数据库名称（默认数据库则传nil）
 @param keyPath 排序关键字（不排序则传传nil）
 @return 所有的数据集
 */
+(RLMResults *)getAllObjectsWithRealmName:(NSString *)realmName sortedByKePath:(NSString *)keyPath ascending:(BOOL)ascending {
    RLMResults *results=nil;
    if (realmName) {
        RLMRealm* realm=[self getCustomRealmWithName:realmName];
        if (realm) {
            results=[self allObjectsInRealm:realm];
        }
    }
    else {
        results=[self allObjects];
    }
    if (results&&keyPath) {
        results=[results sortedResultsUsingKeyPath:keyPath ascending:ascending];
    }
    return results;
}

/**
 通过字符串查询(适合根据多个属性进行排序)
 @param where 查询条件字符串(指定数据库需要传入数据库名字，默认数据库需要传入nil即可)
 @param realmName 数据库的名称(默认数据库传nil)
 @param descriptors 排序器（RLMSortDescriptor类型，不排序传nil即可）
 @return 结果集
 */
+(RLMResults *)getObjetctsWithWhere:(NSString *)where realm:(NSString *)realmName sortedDescriptors:(NSArray *)descriptors   {
    RLMResults *results=nil;
    RLMRealm* realm=nil;
    if (realmName) {
     realm=[self getCustomRealmWithName:realmName];
        if (realm) {
        results=[self objectsInRealm:realm where:where];
        }
    }
    else {
    results=[self objectsWhere:where];
    }
    if (descriptors&&results) {
       results=[results sortedResultsUsingDescriptors:descriptors];
    }
    return results;
}

/**
 通过字符串查询(适合根据单个属性进行排序)
 @param where 查询条件字符串(指定数据库需要传入数据库名字，默认数据库需要传入nil即可)
 @param realmName 数据库的名称
 @param keyPath 排序关键字（不排序传nil即可）
 @param ascending 是否升序排列
 @return 结果集
 */
+(RLMResults *)getObjetctsWithWhere:(NSString *)where realm:(NSString *)realmName sortedByKePath:(NSString *)keyPath ascending:(BOOL)ascending {
    RLMResults *results=nil;
    RLMRealm* realm=nil;
    if (realmName) {
        realm=[self getCustomRealmWithName:realmName];
        if (realm) {
            results=[self objectsInRealm:realm where:where];
        }
    }
    else {
        results=[self objectsWhere:where];
    }
    if (keyPath&&results) {
        results=[results sortedResultsUsingKeyPath:keyPath ascending:YES];
    }
    return results;
}

/**
 通过谓词查询数据集(适合根据多个属性进行排序)
 @param predicate 查询谓词
 @param realmName 数据库的名称
 @param descriptors 排序器（RLMSortDescriptor类型，不排序传nil即可）
 @return 结果集
 */
+(RLMResults *)getObjectWithPredicate:(NSPredicate *)predicate realm:(NSString *)realmName sortedDescriptors:(NSArray *)descriptors {
    RLMRealm* realm=nil;
    RLMResults* results=nil;
    if (realmName) {
        realm=[self getCustomRealmWithName:realmName];
        if (realm) {
        results=[self objectsInRealm:realm withPredicate:predicate];
        }
    }
    else {
        results=[self objectsWithPredicate:predicate];
    }
    if (descriptors&&results) {
        results=[results sortedResultsUsingDescriptors:descriptors];
    }
    return results;
}

/**
 通过谓词查询数据集（适合根据单个属性进行排序）
 @param predicate 查询谓词
 @param realmName 数据库的名称
 @param keyPath 排序关键字（不排序传nil即可）
 @param ascending 是否升序排列
 @return 结果集
 */
+(RLMResults *)getObjectWithPredicate:(NSPredicate *)predicate realm:(NSString *)realmName sortedByKePath:(NSString *)keyPath ascending:(BOOL)ascending {
    RLMRealm* realm=nil;
    RLMResults* results=nil;
    if (realmName) {
        realm=[self getCustomRealmWithName:realmName];
        if (realm) {
            results=[self objectsInRealm:realm withPredicate:predicate];
        }
    }
    else {
        results=[self objectsWithPredicate:predicate];
    }
    if (keyPath&&results) {
        results=[results sortedResultsUsingKeyPath:keyPath ascending:ascending];
    }
    return results;
}

/**
 对数据库进行增加或者更新当个对象
 @param ojbect 单个对象
 @param realmName 数据库名字（默认数据库则传nil）
 @param block 解决更新属性前必须beginWriteTransaction的操作。
 */
+(void)addorUpdateWithObject:(RLMObject *)ojbect realm:(NSString *)realmName afterBlock:(void (^)(void))block {
    RLMRealm* realm=nil;
    if (realmName) {
        realm=[self getCustomRealmWithName:realmName];
    }
    else {
        realm= [self getDefaultRealm];
    }
    if (realm) {
        [realm beginWriteTransaction];
        block();
        [realm addObject:ojbect];
        [realm commitWriteTransaction];
    }
}

/**
 对数据库进行增加或者更新数组集
 @param objects 数据集
 @param realmName 数据库名字（默认数据库则传nil）
 */
+(void)addorUpdateWithObjects:(id)objects realm:(NSString *)realmName {
    RLMRealm* realm=nil;
    if (realmName) {
        realm=[self getCustomRealmWithName:realmName];
    }
    else {
        realm=[self getDefaultRealm];
    }
    if (realm) {
        [realm addOrUpdateObjectsFromArray:objects];
        [realm commitWriteTransaction];
    }
    
}

/**
 添加数据(不含更新)
 @param object 增加或者更新的对象
 @param realmName 数据库名字（默认数据库则传nil）
 */
+(void)addSingleObject:(RLMObject *)object realmName:(NSString *)realmName{
    RLMRealm* realm=nil;
    if (realmName) {
        realm=[self getCustomRealmWithName:realmName];
        [realm transactionWithBlock:^{
            [realm addObject:object];
            [realm commitWriteTransaction];
        }];
    }
    else {
        realm=[self getDefaultRealm];
        [realm transactionWithBlock:^{
        [realm addObject:object];
        [realm commitWriteTransaction];
        }];
    }
}


/**
 删除单个对象
 @param object 删除对象
 @param realmName realm数据库名称（默认则传nil）
 */
+(void)deleteObject:(RLMObject *)object realmName:(NSString *)realmName {
    RLMRealm* realm=nil;
    if (realmName) {
        realm=[self getCustomRealmWithName:realmName];
    }
    else {
        realm=[self getDefaultRealm];
    }
    if (realm) {
        [realm transactionWithBlock:^{
            [realm deleteObject:object];
            [realm commitWriteTransaction];
        }];
    }
}


/**
 删除一组realm数据
 @param objects realm对象的数组
 @param realmName realm数据库的名称(默认数据库则传nil)
 */
+(void)deleteObjects:(id)objects realmName:(NSString *)realmName {
    RLMRealm* realm=nil;
    if (realmName) {
        realm=[self getCustomRealmWithName:realmName];
    }
    else {
        realm=[self getDefaultRealm];
    }
    if (realm) {
        [realm transactionWithBlock:^{
            [realm deleteObjects:objects];
            [realm commitWriteTransaction];
        }];
    }
}


/**
 通过谓词删除指定数据
 @param predicate 谓词
 @param realmName 数据库名称(默认数据库则传nil)
 */
+(void)deleteObjectsWithPredicate:(NSPredicate *)predicate realmName:(NSString *)realmName {
    RLMResults *objects = [self getObjectWithPredicate:predicate realm:realmName sortedDescriptors:nil];
    if (objects&&objects.count>0) {
        [self deleteObjects:objects realmName:realmName];
    }
}

/**
 通过where字符串数据指定数据
 @param where where字符串
 @param realmName 数据库名称(默认数据库则传nil)
 */
+(void)deleteObjectsWithWhere:(NSString *)where realmName:(NSString *)realmName {
    RLMResults *objects = [self getObjetctsWithWhere:where realm:realmName sortedDescriptors:nil];
    NSLog(@"objectCount:%ld",objects.count);
    if (objects&&objects.count>0) {
        [self deleteObjects:objects realmName:realmName];
    }
}


/**
 删除数据库中的所有数据
 @param realmName 数据库名称(默认数据库则传nil)
 */
+(void)deleteAllObjectsWithRealmName:(NSString *)realmName {
    RLMRealm *realm=nil;
    if (realmName) {
        realm=[self getCustomRealmWithName:realmName];
    }
    else {
        realm=[self getDefaultRealm];
    }
    if (realm) {
        [realm transactionWithBlock:^{
            [realm deleteAllObjects];
            [realm commitWriteTransaction];
        }];
    }
}
@end
