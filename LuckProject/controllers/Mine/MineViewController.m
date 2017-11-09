//
//  MineViewController.m
//  LuckProject
//
//  Created by moxi on 2017/6/25.
//  Copyright © 2017年 moxi. All rights reserved.
//

#import "MineViewController.h"
#import "MyNotesTableViewCell.h"

@interface MineViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)UIImageView *noNoteImage;

@property (nonatomic, strong)NSMutableArray *notesDatas;



@end

@implementation MineViewController

-(void)viewWillAppear:(BOOL)animated{
    
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path1 = [pathArray objectAtIndex:0];
    NSString *myPath = [path1 stringByAppendingPathComponent:@"notes.plist"];
    
    NSMutableArray*data2 = [[NSMutableArray alloc] initWithContentsOfFile:myPath];
    self.notesDatas = [NSMutableArray array];
    [self.notesDatas addObjectsFromArray:data2];
    
    
    if (data2.count) {
        [self.noNoteImage removeFromSuperview];
        [self createTableview];
    }else{
        [self createimgeView];
        [self.tableView removeFromSuperview];
        self.tableView = nil;

    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self createUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -UI

-(void)createUI{
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 32, 32);
    [button setImage:ECIMAGENAME(@"myadd") forState:UIControlStateNormal];
    [button addTarget:self action:@selector(addNoteClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = right;
    
    [self createimgeView];
}

-(void)createimgeView{
    self.noNoteImage = [[UIImageView alloc]initWithImage:ECIMAGENAME(@"mykongbai")];
    [self.view addSubview:self.noNoteImage];
    
    [self.noNoteImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.view);
        make.width.mas_equalTo(64);
        make.height.mas_equalTo(64);
    }];
    
}

-(void)createTableview{
    if (!self.tableView) {
        
        CGFloat topHeight;
        CGFloat version = [[[UIDevice currentDevice]systemVersion] floatValue];
        if (version >= 11.0) {
            CGRect StatusRect = [[UIApplication sharedApplication] statusBarFrame];
            CGRect NavRect = self.navigationController.navigationBar.frame;
            topHeight = StatusRect.size.height + NavRect.size.height;
            self.automaticallyAdjustsScrollViewInsets = YES;
        }else{
            topHeight = 64;
        }
        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, topHeight, DREAMCSCREEN_W, DREAMCSCREEN_H) style:UITableViewStylePlain];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.tableView registerNib:[UINib nibWithNibName:@"MyNotesTableViewCell" bundle:nil] forCellReuseIdentifier:@"mynoteID"];
        self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
        [self.view addSubview:self.tableView];
    }else{
        [self.view addSubview:self.tableView];
        [self.tableView reloadData];
    }
    
}


#pragma mark -click

-(void)addNoteClick:(UIButton*)button{
    
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:[[AddNotesViewController alloc]init]];
    nav.navigationBar.barTintColor = [UIColor redColor];
    [nav.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self presentViewController:nav animated:YES completion:nil];
}

#pragma mark -tableviewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.notesDatas.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return DREAMCSCREEN_H/5;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MyNotesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mynoteID"];
    if (!cell) {
        cell = [[MyNotesTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"mynoteID"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSDictionary *dic = self.notesDatas[indexPath.row];
    cell.titleLable.text = dic[@"title"];
    cell.timeLable.text = dic[@"date"];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    AddNotesViewController *vc = [[AddNotesViewController alloc]init];
    vc.flag = 1;
    NSDictionary *dic = self.notesDatas[indexPath.row];
    vc.poemContent = dic[@"notes"];
    vc.poemTitle = dic[@"title"];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}


-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return YES;
}

- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewRowAction *detele = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
        self.popView = [[ZYFPopview alloc]initInView:[UIApplication sharedApplication].keyWindow tip:@"删除笔记?" images:(NSMutableArray*)@[] rows:(NSMutableArray*)@[@"删除"] doneBlock:^(NSInteger selectIndex) {
            
            
            NSFileManager *manager=[NSFileManager defaultManager];
            NSString *filepath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0]stringByAppendingPathComponent:@"notes.plist"];
            if ([manager removeItemAtPath:filepath error:nil]) {
                
                NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
                NSString *documentsPath = [path objectAtIndex:0];
                NSString *plistPath = [documentsPath stringByAppendingPathComponent:@"notes.plist"];
                [self.notesDatas removeObjectAtIndex:indexPath.row];//bug
                [self.notesDatas writeToFile:plistPath atomically:YES];
                
                if (self.notesDatas.count==0) {
                    [self.tableView removeFromSuperview];//removeFromSuperview将视图从父视图上移开并且销毁，但是如果其他地方对他还有引用，只是移开了视图但是不会销毁
                    [self createimgeView];
                }else{
                    [self.tableView reloadData];
                }
            }
            

        } cancleBlock:^{
            
        }];
        [self.popView showPopView];
    }];
    
    detele.backgroundColor = [UIColor redColor];
    
    return @[detele];
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
