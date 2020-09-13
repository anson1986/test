//
//  BFItemListViewController.m
//  BicycleFans
//
//  Created by Mac on 2020/9/12.
//  Copyright © 2020 sport. All rights reserved.
//

#import "BFItemListViewController.h"
#import "BFItemListCell.h"
#import "BFConnectionViewController.h"

@interface BFItemListViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *items;

@end

@implementation BFItemListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = MainColor;
    self.title = @"选择设备";
    self.p_backBtn.hidden = YES;
    [self tableView];
}

#pragma mark -- UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BFItemListCell *deviceCell = [tableView dequeueReusableCellWithIdentifier:@"deviceCell"];
    if (!deviceCell) {
        deviceCell = [[BFItemListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"deviceCell"];
    }

    deviceCell.array = self.items;
    deviceCell.indexPath = indexPath;

    return deviceCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    BFConnectionViewController *vc = [[BFConnectionViewController alloc] init];
    vc.imgName = [NSString stringWithFormat:@"0%ld",indexPath.row +1];
    vc.selectIndex = indexPath.row;
    [self.navigationController pushViewController:vc animated:YES];
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


#pragma mark -- getter
- (NSMutableArray *)items {
    if (!_items) {
        _items = [[NSMutableArray alloc] init];
        _items = @[@"遥控微波炉",@"遥控电灯",@"遥控冰箱",@"遥控空调",@"遥控热水器",@"遥控窗帘",@"遥控马桶",@"遥控电视"].mutableCopy;
    }
    return _items;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WindowWidth, WindowHeight - 64) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = MainColor;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        [self.view addSubview:_tableView];
    }
    
    return _tableView;
}

@end
