//
//  ViewController.m
//  idageChangeQQSport
//
//  Created by 冯亮 on 16/6/21.
//  Copyright © 2016年 idage. All rights reserved.
//

#import "ViewController.h"
#import <HealthKit/HealthKit.h>

@interface ViewController ()
@property (nonatomic, strong)HKHealthStore *healthStore;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    if (![HKHealthStore isHealthDataAvailable]) {
        //不可以使用健康
        return;
    }
    //HKHealthStore —— 关键类（使用HealthKit框架必须创建该类
     self.healthStore = [[HKHealthStore alloc] init];
    HKQuantityType *stepCountType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
    
    NSSet *writeDataT = [NSSet setWithObjects:stepCountType,  nil];
    
    NSSet *readDataT =nil;
    
    //发出具体的请求许可。这里调用了requestAuthorizationToShareTypes:readTypes方法并将之前定义好的读取和写入的种类作为参数传了进去。我们只需要写入步数就可以
    
    
        [self.healthStore requestAuthorizationToShareTypes:writeDataT readTypes:readDataT completion:^(BOOL success, NSError *error) {
            
            if (!success) {
              //失败了
                return;
            }
         
        }];
    
    //数据看类型为步数.
    HKQuantityType *quantityTypeIdentifier = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
    
    //表示步数的数据单位的数量
    HKQuantity *quantity = [HKQuantity quantityWithUnit:[HKUnit countUnit] doubleValue:10000];
    
    //数量样本.
    HKQuantitySample *temperatureSample = [HKQuantitySample quantitySampleWithType:quantityTypeIdentifier quantity:quantity startDate:[NSDate date] endDate:[NSDate date] metadata:nil];
    
    //保存
    [self.healthStore saveObject:temperatureSample withCompletion:^(BOOL success, NSError *error) {
        if (success) {
            //保存成功
        }else {
            //保存失败
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
