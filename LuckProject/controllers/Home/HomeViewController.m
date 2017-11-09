//
//  HomeViewController.m
//  LuckProject
//
//  Created by moxi on 2017/6/25.
//  Copyright © 2017年 moxi. All rights reserved.
//

#import "HomeViewController.h"
#import "PoemModel.h"

@interface HomeViewController ()

@property (nonatomic, strong)NSArray *myDatas;

@property (nonatomic, assign)NSInteger styleFlag;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createUI];
    
    self.styleFlag = 1;
    
    [self createTableview];
    [self.tableView.mj_header beginRefreshing];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -UI

-(void)createUI{
    
    NSArray *iamgeArr = @[@"stylechange",@"barsearch"];
    NSMutableArray *barItems = [NSMutableArray array];
    
    for (NSInteger index = 0; index <2; index++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, 0, 32, 32);
        [button setImage:ECIMAGENAME(iamgeArr[index]) forState:UIControlStateNormal];
        button.tag = 100 + index;
        [button addTarget:self action:@selector(changestyleClick:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithCustomView:button];
        [barItems addObject:right];
    }
    self.navigationItem.rightBarButtonItems = barItems;

}


#pragma mark tableview

-(void)createTableview{
    CGRect StatusRect = [[UIApplication sharedApplication] statusBarFrame];
    CGRect NavRect = self.navigationController.navigationBar.frame;
    CGFloat topHeight = StatusRect.size.height + NavRect.size.height;
   
    [self initTableViewWithFrame:CGRectMake(0, topHeight, DREAMCSCREEN_W, DREAMCSCREEN_H - topHeight) WithHeadRefresh:YES WithFootRefresh:YES WithScrollIndicator:NO];
    self.tableView.backgroundColor = [UIColor colorWithPatternImage:ECIMAGENAME(@"bg1")];
    [self.tableView registerNib:[UINib nibWithNibName:@"ShiCiTableViewCell" bundle:nil] forCellReuseIdentifier:@"shiciID"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    UIView *headview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, DREAMCSCREEN_W, DREAMCSCREEN_H/5)];
    UIImageView *myIamgeView = [[UIImageView alloc]initWithImage:ECIMAGENAME(@"recomend_bg")];
    headview = myIamgeView;
    self.tableView.tableHeaderView = headview;
    
    NSArray *shiArr = [NSArray array];
    
    if (self.styleFlag == 1) {
       shiArr = @[@"三春花事早",@"为花须及早",@"花开有落时",@"人生容易老"];
    }else if (self.styleFlag == 2){
        shiArr = @[@"莫道不消魂",@"帘卷西风",@"人比黄花瘦",@"李清照"];
    }else{
      shiArr = @[@"枯藤老树昏鸦",@"小桥流水人家",@"古道西风瘦马",@"夕阳西下",@"断肠人在天涯"];
    }
    
    for (NSInteger index = 0; index <= 3; index++) {
        
        UILabel *label = [[UILabel alloc]init];
        label.numberOfLines = 0;
        label.font = [UIFont systemFontOfSize:15];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = shiArr[index];
        [headview addSubview:label];
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(headview.mas_left).offset(40 + index*30 + index*5);
            make.top.mas_equalTo(headview.mas_top).offset(20);
            make.bottom.mas_equalTo(headview.mas_bottom).offset(-20);
            make.width.mas_equalTo(30);
        }];
    }
   
}



#pragma mark netquest

-(void)netquest{
    
    self.myDatas = [self getDataWithCatefgory:self.styleFlag];
    
}



#pragma mark -click

-(void)changestyleClick:(UIButton*)button{
    if (button.tag == 101) {
        
        SearchViewController *searchVc = [[SearchViewController alloc]init];
        self.hidesBottomBarWhenPushed = YES;
        searchVc.dataSouce = [NSArray arrayWithArray:self.myDatas];
        [self.navigationController pushViewController:searchVc animated:YES];
        self.hidesBottomBarWhenPushed = NO;
    }else{
        NSArray *arr = @[@"唐诗",@"宋词",@"元曲"];
        
        self.popView = [[ZYFPopview alloc]initInView:[UIApplication sharedApplication].keyWindow tip:@"选择形式" images:(NSMutableArray*)@[@"tangshi",@"songci",@"yuanqu"] rows:(NSMutableArray*)arr doneBlock:^(NSInteger selectIndex) {

            [self.tableView removeFromSuperview];
            if (selectIndex == 0) {
                self.styleFlag = 1;
 
            }else if (selectIndex == 1){
                
                self.styleFlag = 2;

            }else{
                self.styleFlag = 3;
            }
            
            [self.tableView.mj_header beginRefreshing];
            [self.view addSubview:self.tableView];
            self.navigationItem.title = arr[selectIndex];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [self.tableView.mj_header endRefreshing];
                
            });
            
        } cancleBlock:^{
            
        }];
        
        [self.popView showPopView];
    }

}


#pragma mark tabelviewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.myDatas.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 100;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    ShiCiTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"shiciID"];
    
    if (!cell) {
        cell = [[ShiCiTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"shiciID"];
    }
    cell.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1);
    [UIView animateWithDuration:1 animations:^{
        cell.layer.transform = CATransform3DMakeScale(1, 1, 1);
    }];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    PoemModel *model = self.myDatas[indexPath.row];
    cell.titleLable.text = model.title;
    cell.authorLable.text = model.author;
    cell.contentLable.text = model.content;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PoemModel *model = self.myDatas[indexPath.row];
    ShiciDetialViewController *shiciDeVc = [[ShiciDetialViewController alloc]init];
    self.hidesBottomBarWhenPushed = YES;
    shiciDeVc.flag = self.styleFlag;
    shiciDeVc.poemModle = model;
    [self.navigationController pushViewController:shiciDeVc animated:YES];
    self.hidesBottomBarWhenPushed = NO;
    
}


-(void)tableViewHeadRefresh{
    
    [self netquest];
    [self.tableView reloadData];
    [self showBaseHudWithTitle:@"Loading...."];
    [self.tableView.mj_header endRefreshing];
    [self dismissHudWithSuccessTitle:@"Success" After:2.f];
    
}

-(void)tableViewFootRefresh{
    
    [self.tableView.mj_footer endRefreshing];
    [self showBaseHudWithTitle:@"Loading...."];
    [self dismissHudWithSuccessTitle:@"Success" After:2.f];
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
