//
//  ViewController.m
//  RealmNew
//
//  Created by kkmac on 2017/4/7.
//  Copyright © 2017年 kkmac. All rights reserved.
//
//参考文档地址：http://git.devzeng.com/blog/simple-usage-of-realm-in-ios.html

#import "ViewController.h"
#import "Dog.h"
#import "Person.h"
@interface ViewController () {
    RLMRealm *_customRealm;
    RLMResults *_personArray;
    RLMResults *_dogArray;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
}

-(NSInteger)getNowTimestamp{
    UInt64 recordTime = [[NSDate date] timeIntervalSince1970]*1000;
    NSLog(@"设备当前的时间戳:%ld", (long)recordTime); //时间戳的值
    return recordTime;
    
}
-(void)loadData {
    for (int i=0; i<6; i++) {
        Person *per=[[Person alloc]init];
        per.name=@"lily";
        per.sex=@"F";
        per.age=12+i;
        per.primaryKey=[[[NSUUID UUID] UUIDString] stringByReplacingOccurrencesOfString:@"-" withString:@""];
        [Person addSingleObject:per realmName:@"wangbiao"];
    }
}

- (IBAction)getPersons:(id)sender {
    //获取部分数据的方法一
//    RLMSortDescriptor *descriptor=[RLMSortDescriptor sortDescriptorWithKeyPath:@"timeStamp" ascending:NO];
//    _personArray=[Person getObjetctsWithWhere:@"age>14" realm:@"wangbiao" sortedDescriptors:@[descriptor]];
//    for (Person *per in _personArray) {
//        NSLog(@"personCount:%lu,name:%@,sex:%@,age:%ld,time:%lld",(unsigned long)_personArray.count,per.name,per.sex,per.age,per.timeStamp.longLongValue);
//
//    }
//    //获取部分数据的方法二
//    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"age>15"];
//    _personArray=[Person getObjectWithPredicate:predicate realm:@"wangbiao" sortedByKePath:@"age" ascending:NO];
//    for (Person *per in _personArray) {
//        NSLog(@"personCount:%lu,name:%@,sex:%@,age:%ld,time:%lld",(unsigned long)_personArray.count,per.name,per.sex,per.age,per.timeStamp.longLongValue);
//        
//    }
    //获取全部数据的方法
    _personArray=[Person getAllObjectsWithRealmName:@"wangbiao" sortedDescriptors:nil];
    for (Person *per in _personArray) {
        NSLog(@"personCount:%lu,name:%@,sex:%@,age:%ld,primaryKey:%@",(unsigned long)_personArray.count,per.name,per.sex,per.age,per.primaryKey);
        
    }
}

- (IBAction)addOjbect:(id)sender {
    //添加数据的方法1
    Person *per=[[Person alloc]init];
//    [Person addorUpdateWithObject:per realm:@"wangbiao" afterBlock:^{
//        per.age=108;
//        per.timeStamp=[NSString stringWithFormat:@"%ld",[self getNowTimestamp]];
//        per.name=@"zhaohua";
//        per.sex=@"M";
//    }];
   //添加数据的方法二
    per.name=@"qianliu";
    per.age=56;
    per.primaryKey=[[[NSUUID UUID] UUIDString] stringByReplacingOccurrencesOfString:@"-" withString:@""];
    per.sex=@"F";
    [Person addSingleObject:per realmName:@"wangbiao"];
}

- (IBAction)updateObject:(id)sender {
    RLMResults *results=[Person getObjetctsWithWhere:@"name='zhaohua'" realm:@"wangbiao" sortedDescriptors:nil];
    if (results&&results.count>0) {
      Person *per=results[0];
        [Person addorUpdateWithObject:per realm:@"wangbiao" afterBlock:^{
            per.age=101;
        }];
    }
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
