//
//  SetDetialViewController.m
//  LuckProject
//
//  Created by moxi on 2017/9/7.
//  Copyright © 2017年 moxi. All rights reserved.
//

#import "SetDetialViewController.h"

@interface SetDetialViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong)UIScrollView *myScrollView;

@property(nonatomic,strong)NSMutableArray * dataSource;

@property (nonatomic, strong)WSPieChart *pieChart;

@property (nonatomic, strong)MymxConfig *config;




@end

@implementation SetDetialViewController

-(void)viewWillAppear:(BOOL)animated{
    
    self.dataSource = [NSMutableArray array];
    
    self.config = [MymxConfig shareInstance];
    
    [self createUI];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
}

-(void)viewDidDisappear:(BOOL)animated{
    
    [self.tableView removeFromSuperview];
    self.tableView = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -freshData

-(void)frechData{
    
    [self.dataSource addObjectsFromArray:[FavoriteModel MR_findAll]];
}


#pragma mark -UI

-(void)createUI{
    
    if (self.flag == 1) {
        [self createBackGroundView];
    }else if (self.flag == 2){
        [self createReadChartView];
    }else{
        [self createReadCountView];
    }
    
}

-(void)createBackGroundView{
    
    CGFloat bottomPad;
    CGFloat topPad;
    if (DREAMCSCREEN_H == 812) {
        bottomPad = -34;
        topPad = 84;
    }else{
        bottomPad = -10;
        topPad = 64;
    }
    self.navigationItem.title = @"背景设置";
    
    self.myScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(35, topPad, DREAMCSCREEN_W - 70, DREAMCSCREEN_H - topPad - 50 + bottomPad)];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"设置背景" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor redColor];
    button.layer.masksToBounds = YES;
    button.layer.cornerRadius = 10;
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(setBgClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    
    
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(bottomPad);
        make.left.mas_equalTo(self.view.mas_left).offset(35);
        make.right.mas_equalTo(self.view.mas_right).offset(-35);
        make.height.mas_equalTo(40);
    }];
    
    self.myScrollView.delegate = self;
    self.myScrollView.showsVerticalScrollIndicator = NO;
    self.myScrollView.pagingEnabled = YES;
    self.myScrollView.bounces = NO;
    self.myScrollView.contentOffset = CGPointMake(self.config.bgImage*(DREAMCSCREEN_W - 70), 0);
    self.myScrollView.contentSize = CGSizeMake((DREAMCSCREEN_W - 70)*6, DREAMCSCREEN_H - topPad - 50 + bottomPad);
    [self.view addSubview:self.myScrollView];
    
    for (NSInteger index=0; index<=5; index++) {
        NSString *string = [@"bg" stringByAppendingString:[NSString stringWithFormat:@"%ld",index]];
        UIImageView *myImage = [[UIImageView alloc]initWithImage:ECIMAGENAME(string)];
        myImage.frame = CGRectMake(index*(DREAMCSCREEN_W - 70), 0, DREAMCSCREEN_W - 70, DREAMCSCREEN_H - topPad - 50 - bottomPad);
        myImage.userInteractionEnabled = YES;
        [self.myScrollView addSubview:myImage];
    }
}

-(void)createReadChartView{
    
    self.config = [MymxConfig shareInstance];

    
    self.navigationItem.title = @"背诵统计";
    [self initTableViewWithFrame:CGRectMake(0, 64, DREAMCSCREEN_W, DREAMCSCREEN_H - 64) WithHeadRefresh:NO WithFootRefresh:NO WithScrollIndicator:NO];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.pieChart = [[WSPieChart alloc]initWithFrame:CGRectMake(0, 0, DREAMCSCREEN_W, DREAMCSCREEN_H/3)];
    self.pieChart.valueArr = [NSArray arrayWithObjects:@"320",@"301",@"300",[NSString stringWithFormat:@"%ld",self.config.readTScount],[NSString stringWithFormat:@"%ld",self.config.readSCcount],[NSString stringWithFormat:@"%ld",self.config.readYQcount], nil];
    self.pieChart.descArr = [NSArray arrayWithObjects:@"唐诗总数",@"宋词总数",@"元曲总数",@"以背唐诗",@"以背宋词",@"以背元曲", nil];
    self.pieChart.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.pieChart];
    
    self.pieChart.positionChangeLengthWhenClick = 20;
    self.pieChart.showDescripotion = YES;
    [self.pieChart showAnimation];
    
    self.tableView.tableHeaderView = self.pieChart;
}

-(void)createReadCountView{
    self.navigationItem.title = @"我的背诵";
    [self frechData];
    [self initTableViewWithFrame:CGRectMake(0, 0, DREAMCSCREEN_W, DREAMCSCREEN_H) WithHeadRefresh:NO WithFootRefresh:NO WithScrollIndicator:NO];
    
}

#pragma mark -click 

-(void)setBgClick:(UIButton*)button{
    
    self.popView = [[ZYFPopview alloc]initInView:[UIApplication sharedApplication].keyWindow tip:@"将当前图片设为详情背景?" images:(NSMutableArray*)@[] rows:(NSMutableArray*)@[@"确定"] doneBlock:^(NSInteger selectIndex) {
        NSInteger page = self.myScrollView.contentOffset.x/(DREAMCSCREEN_W - 70);
        [self.config saveBgroundImage:page];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self showBaseHud];
            [self dismissHudWithSuccessTitle:@"设置成功" After:1.f];
        });
        
    } cancleBlock:^{
        
    }];
    [self.popView showPopView];
}


#pragma mark -tableview

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.flag ==2) {
        return 6;
    } 
    return self.dataSource.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 64;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if (self.flag == 2) {
        cell.textLabel.text = self.pieChart.descArr[indexPath.row];
        cell.detailTextLabel.text = self.pieChart.valueArr[indexPath.row];
        return cell;
    }else{
        FavoriteModel *model = self.dataSource[indexPath.row];
        cell.textLabel.text = model.title;
        cell.detailTextLabel.text = model.auther;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.flag == 2) {
        
    }else{
        FavoriteModel *model = self.dataSource[indexPath.row];
        PoemModel *poemModel = [[PoemModel alloc]init];
        [poemModel setupWith:model];
        ShiciDetialViewController *vc = [[ShiciDetialViewController alloc]init];
        self.hidesBottomBarWhenPushed = YES;
        vc.poemModle = poemModel;
        vc.favoModel = model;
        vc.flag = 4;
        [self.navigationController pushViewController:vc animated:YES];
    }
}





/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
