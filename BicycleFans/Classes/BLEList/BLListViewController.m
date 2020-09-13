//
//  BLListViewController.m
//  BicycleFans
//
//  Created by Mac on 2020/9/12.
//  Copyright © 2020 sport. All rights reserved.
//

#import "BLListViewController.h"
#import "SAJBLEPort.h"
#import "SAJBluetoothCenter.h"
#import "SVProgressHUD.h"
#import "TYCyclePagerView.h"
#import "KMCarouseContentCell.h"
#import "SAJBLEPort.h"
#import "SAJBluetoothCenter.h"
#import "SVProgressHUD.h"
#import "ISListTableViewCell.h"
#import "ISTitleTableViewCell.h"
#import "BFHomeViewController.h"

@interface BLListViewController ()<TYCyclePagerViewDataSource,TYCyclePagerViewDelegate,UITableViewDelegate,UITableViewDataSource,SAJBluetoothCenterDelegate>

@property (nonatomic, strong) TYCyclePagerView *cycleCarouselView;

@property (nonatomic, strong) NSArray *imgsArr;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *listArray;

@property (nonatomic, strong) SAJBLEPort *operationPort;

@end

@implementation BLListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = MainColor;
    self.title = @"设备搜索";
    self.imgsArr = @[@"01",@"02",@"03"];
    [self setupSubViews];
    [self tableView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshTableview) name:@"BluetoothBreak" object:nil];
    Bluetooth.delegate = self;
    [Bluetooth startPerialScan];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [Bluetooth stopPerialScan];
}


- (void)setupSubViews {
//    self.view.backgroundColor = KM_HEXColor(0xF7F7F7);
//    [self.view addSubview:self.cycleCarouselView];
//
//    CGFloat height = (WindowWidth - 24) *147/351;
//    [self.cycleCarouselView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.equalTo(self.view);
//        make.top.equalTo(self.view).mas_offset(0);
//        make.height.mas_equalTo(height);
//    }];
}

#pragma mark - TYCyclePagerViewDelegate
- (NSInteger)numberOfItemsInPagerView:(TYCyclePagerView *)pageView {
    return self.imgsArr.count*100;
}

- (__kindof UICollectionViewCell *)pagerView:(TYCyclePagerView *)pagerView cellForItemAtIndex:(NSInteger)index {
    KMCarouseContentCell *cell = [pagerView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([KMCarouseContentCell class]) forIndex:index];
    cell.backgroundColor = MainColor;
    cell.imgName = self.imgsArr[index % self.imgsArr.count];
    return cell;
}

- (TYCyclePagerViewLayout *)layoutForPagerView:(TYCyclePagerView *)pageView {
    TYCyclePagerViewLayout *layout = [[TYCyclePagerViewLayout alloc]init];
    layout.itemSize = CGSizeMake(WindowWidth-30, (WindowWidth-24) *147/351);
    layout.itemSpacing = 6.0;
    layout.layoutType = TYCyclePagerTransformLayoutLinear;
    return layout;
}

#pragma mark -- UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
//    return self.listArray.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        ISTitleTableViewCell *titleCell = [tableView dequeueReusableCellWithIdentifier:@"titleCell"];
        if (!titleCell) {
            titleCell = [[ISTitleTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"titleCell"];
        }
        
        if (titleCell.activityIndicator) {
            [titleCell.activityIndicator startAnimating];
        }
        
        return titleCell;
    }else {
        ISListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (!cell) {
            cell = [[ISListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        }
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        BFHomeViewController *mainPageVc = [[BFHomeViewController alloc] init];
        [self.navigationController pushViewController:mainPageVc animated:YES];
    });

    return;
    
    if (indexPath.row > 0 && self.listArray.count > 0)
    {
        //连接蓝牙设备
        SAJBLEPort *port = self.listArray[indexPath.row-1];
        self.operationPort = port;

        //保证connect的东西不会是一个空，空的connect就崩了
        if ([port.peripheral isKindOfClass:[CBPeripheral class]])
        {
            [Bluetooth connectPeripheral:port.peripheral];
            [Bluetooth startConnectCountDown];
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [[UIView alloc] init];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [[UIView alloc] init];
}

#pragma mark - getter
- (TYCyclePagerView *)cycleCarouselView {
    if (!_cycleCarouselView) {
        _cycleCarouselView = [TYCyclePagerView new];
        _cycleCarouselView.isInfiniteLoop = true;
        _cycleCarouselView.autoScrollInterval = 3.0;
        _cycleCarouselView.dataSource = self;
        _cycleCarouselView.delegate = self;
        _cycleCarouselView.backgroundColor = MainColor;
        _cycleCarouselView.collectionView.clipsToBounds = NO;
        [_cycleCarouselView registerClass:[KMCarouseContentCell class]
          forCellWithReuseIdentifier:NSStringFromClass([KMCarouseContentCell class])];
    }
    return _cycleCarouselView;
}

- (UITableView *)tableView {
    if (!_tableView) {
        CGFloat height = (WindowWidth - 24) *147/351;
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WindowWidth, WindowHeight - 0) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = MainColor;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        [self.view addSubview:_tableView];
    }
    
    return _tableView;
}

- (void)refreshTableview
{
    [self.tableView reloadData];
    
    Bluetooth.delegate = self;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.2f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [Bluetooth startPerialScan];
    });
}

#pragma mark -- SAJBluetoothCenterDelegate
//刷新list
- (void)didFoundPortWithList:(NSMutableArray *)array
{
    self.listArray = array;
    [self.tableView reloadData];
}

- (void)unOpenBluetooth
{
    NSLog(@"蓝牙不可用");
    //1.隐藏tableview
    self.tableView.hidden = YES;
    //2.显示nodataView;
    UIView *noDataView = [self.view viewWithTag:9999];
    if (!noDataView)
    {
        noDataView = [self noDataViewWithTitle:@"请先设置蓝牙：系统设置 -> 蓝牙 -> 打开蓝牙"];
        noDataView.tag = 9999;
        [self.view addSubview:noDataView];
    }
}

- (void)bluetoothCanUse
{
    self.tableView.hidden = NO;
    UIView *nodataView = [self.view viewWithTag:9999];
    if (nodataView)
    {
        [nodataView removeFromSuperview];
    }
    
    [Bluetooth startPerialScan];
}

- (void)connectPortSucceed
{
    //连接成功的时候baseviewcontroller开蓝牙监控，断开的时候在baseview弹框后直接移除delegate
    [self setBaseviewBluetoothDelegate];
        
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        BFHomeViewController *mainPageVc = [[BFHomeViewController alloc] init];
        [self.navigationController pushViewController:mainPageVc animated:YES];
//        XMHomeViewController *vc = [[XMHomeViewController alloc] init];
//        [self.navigationController pushViewController:vc animated:YES];
//        [SAJProgressHud hidden];
    });
}

- (UIView *)noDataViewWithTitle:(NSString *)title
{
    UIView *noDataView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WindowWidth, WindowHeight)];
    noDataView.backgroundColor = [UIColor clearColor];
    UILabel *descLabel = [UILabel new];
    descLabel.text = title;
    descLabel.numberOfLines = 0;
    descLabel.font = [UIFont systemFontOfSize:15];
    descLabel.textColor = [UIColor whiteColor];
    descLabel.textAlignment = NSTextAlignmentCenter;
    [noDataView addSubview:descLabel];
    
    [descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(noDataView).offset(15);
        make.right.equalTo(noDataView).offset(-15);
        make.top.equalTo(noDataView).offset(WindowHeight/2 - 150);
        make.centerX.equalTo(noDataView);
    }];
    
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
//    [button setTitle:@"设置蓝牙" forState:UIControlStateNormal];
//    button.titleLabel.font = [UIFont systemFontOfSize:15];
//    [button addTarget:self action:@selector(goSettingBluetooth:) forControlEvents:UIControlEventTouchUpInside];
//    button.backgroundColor = SAJColorUniversal;
//    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    button.layer.cornerRadius = 3;
//    [noDataView addSubview:button];
//
//    [button mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(descLabel.mas_bottom).offset(25);
//        make.width.mas_offset(80);
//        make.height.mas_offset(35);
//        make.centerX.equalTo(noDataView);
//    }];
    
    return noDataView;
}


@end
