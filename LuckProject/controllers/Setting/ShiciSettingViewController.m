//
//  ShiciSettingViewController.m
//  LuckProject
//
//  Created by moxi on 2017/9/6.
//  Copyright © 2017年 moxi. All rights reserved.
//

#import "ShiciSettingViewController.h"

@interface ShiciSettingViewController ()

@property (nonatomic, strong)NSArray *cellTitles;
@property (nonatomic, strong)MymxConfig *Myconfig;

@end

@implementation ShiciSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.cellTitles = @[@"详情页字体",@"详情页背景",@"背诵统计",@"我的背诵"];
    
    self.Myconfig = [MymxConfig shareInstance];
    
    [self createUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -UI

-(void)createUI{
    
    [self initTableViewWithFrame:CGRectMake(0, 0, DREAMCSCREEN_W, DREAMCSCREEN_H) WithHeadRefresh:NO WithFootRefresh:NO WithScrollIndicator:NO];
}


#pragma mark -UITableView

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.cellTitles.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return DREAMCSCREEN_H/13;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellId = @"cellID";
    
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = self.cellTitles[indexPath.section];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 10;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = ECCOLOR(240, 240, 240, 1);
    
    return view;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SetDetialViewController *vc = [[SetDetialViewController alloc]init];

    switch (indexPath.section) {
        case 0:
        {
            self.popView = [[ZYFPopview alloc]initInView:[UIApplication sharedApplication].keyWindow tip:@"详情页字体" images:(NSMutableArray *)@[] rows:(NSMutableArray *)@[@"小",@"默认",@"大"]  doneBlock:^(NSInteger selectIndex) {
                
                NSInteger detialFont;
                if (selectIndex == 0) {
                    detialFont = 11;
                }else if (selectIndex == 1){
                    detialFont = 13;
                }else{
                    detialFont = 16;
                }
                
                [self.Myconfig saveDetialFont:detialFont];
                
            } cancleBlock:^{
                
            }];
            
            [self.popView showPopView];
        }
            break;
        case 1:
        {
            vc.flag = 1;
            self.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
            self.hidesBottomBarWhenPushed = NO;
        }
            break;
        case 2:
        {
            vc.flag = 2;
            self.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
            self.hidesBottomBarWhenPushed = NO;
        }
            break;
        case 3:
        {
            vc.flag = 3;
            self.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
            self.hidesBottomBarWhenPushed = NO;
        }
            break;
            
        default:
            break;
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
