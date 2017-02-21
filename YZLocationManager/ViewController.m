//
//  ViewController.m
//  YZLocationManager
//
//  Created by 叶志强 on 2017/2/20.
//  Copyright © 2017年 CancerQ. All rights reserved.
//

#import "ViewController.h"
#import "YZLocationManager.h"


@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSouce;
@property (nonatomic, strong) YZLocationManager *manager;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    self.dataSouce = [NSMutableArray new];
    
    [self performSelector:@selector(startLocationService) withObject:nil afterDelay:0.5];
    
}

- (void)startLocationService{
    
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
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSouce.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"UITableViewCell"];
    }
    NSDictionary *dic = self.dataSouce[indexPath.row];
    cell.textLabel.text = dic[@"time"];
    cell.detailTextLabel.text = dic[@"coordinate"];
    return cell;
}

- (NSString *)dateString{
    
    NSDateFormatter *dateFormatter =[[NSDateFormatter alloc] init];
    // 设置日期格式
    [dateFormatter setDateFormat:@"YYYY/mm/dd hh:mm:ss"];
    
    NSString *dateString = [dateFormatter stringFromDate:[NSDate date]];
    
    return dateString;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
