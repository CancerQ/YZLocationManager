# YZLocationManager
基于百度地图的定位类 里面包含百度地图有点大建议打包下载不要进行克隆  ```没有百度地图请点[这里](https://github.com/CancerQ/YZLocationManager-)``` 原文地址 http://www.jianshu.com/p/cc3cee4f64a9
```objc
    YZLocationManager *manager = [YZLocationManager sharedLocationManager];
    manager.isBackGroundLocation = YES;
    manager.locationInterval = 10;
//    @weakify(manager)
    [manager setYZBackGroundLocationHander:^(CLLocationCoordinate2D coordinate) {
        _plc(coordinate);
        YZLMLOG(@">>>>>>>>>>>>>%f,,%f",coordinate.latitude,coordinate.longitude);
//        @strongify(manager) //注意别造成循环引用
//        [manager geoCodeSearchWithCoorinate:coordinate address:^(NSString *address, NSUInteger error) {
//            YZLMLOG(@">>>>>>>>>>address:%@",address);
//        }];
        NSDictionary *dic = @{
                              @"time":self.dateString,
                              @"coordinate":[NSString stringWithFormat:@"%f,%f",coordinate.latitude,coordinate.longitude]
                              };
        [self.dataSouce addObject:dic];
        [self.tableView reloadData];
    }];
    
    [manager setYZBackGroundGeocderAddressHander:^(NSString *address) {
        YZLMLOG(@">>>>>>>>>>address:%@",address);
    }];
    [manager startLocationService];
```
