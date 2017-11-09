//
//  ShiciDetialViewController.m
//  LuckProject
//
//  Created by moxi on 2017/9/6.
//  Copyright © 2017年 moxi. All rights reserved.
//

#import "ShiciDetialViewController.h"

@interface ShiciDetialViewController ()

@property (nonatomic, strong)MymxConfig *myConfig;
@property (nonatomic, strong)UIButton *rightButton;
@property (nonatomic, strong)MymxConfig *config;

@property (nonatomic, strong)NSMutableArray *dataSource;
@end

@implementation ShiciDetialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.myConfig = [MymxConfig shareInstance];
    
    self.dataSource = [NSMutableArray array];
    
    self.navigationItem.title = self.poemModle.title;

    
    [self createUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -UI

-(void)createUI{
    
    self.rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.rightButton.frame = CGRectMake(0, 0, 60, 32);
    NSArray * array = [FavoriteModel MR_findAllWithPredicate:[NSPredicate predicateWithFormat:@"pid=%ld",self.poemModle.pid]];
    if (array.count>0) {
        [self.rightButton setImage:ECIMAGENAME(@"mysave_s") forState:UIControlStateNormal];
    }else{
        [self.rightButton setImage:ECIMAGENAME(@"mysave") forState:UIControlStateNormal];
    }
    [self.rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.rightButton addTarget:self action:@selector(saveFalgClick:) forControlEvents:UIControlEventTouchUpInside];
    
    if (self.flag == 4) {
        [self.rightButton setImage:ECIMAGENAME(@"mysave_s") forState:UIControlStateNormal];
    }
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithCustomView:self.rightButton];
    self.navigationItem.rightBarButtonItem = right;
    
    NSString *str = [NSString stringWithFormat:@"bg%ld",self.myConfig.bgImage];
    
    UIImageView *bgImage = [[UIImageView alloc]initWithImage:ECIMAGENAME(str)];
    bgImage.userInteractionEnabled = YES;
    [self.view addSubview:bgImage];
    
    [bgImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.view);
        make.width.mas_equalTo(DREAMCSCREEN_W);
        make.height.mas_equalTo(DREAMCSCREEN_H);
    }];
    
    UILabel *titleL = [[UILabel alloc]init];
    titleL.textAlignment = NSTextAlignmentCenter;
    titleL.text = self.poemModle.title;
    titleL.font = [UIFont systemFontOfSize:self.myConfig.detialFont];
    [self.view addSubview:titleL];
    
    [titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top).offset(100);
        make.left.mas_equalTo(self.view.mas_left);
        make.right.mas_equalTo(self.view.mas_right);
        make.height.mas_equalTo(DREAMCSCREEN_H/12);
    }];
    
    UILabel *author = [[UILabel alloc]init];
    author.text = self.poemModle.author;
    author.textAlignment = NSTextAlignmentCenter;
    author.font = [UIFont systemFontOfSize:self.myConfig.detialFont];
    [self.view addSubview:author];
    
    [author mas_makeConstraints:^(MASConstraintMaker *make) {
        [author mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(titleL.mas_bottom);
            make.left.mas_equalTo(self.view.mas_left);
            make.right.mas_equalTo(self.view.mas_right);
            make.height.mas_equalTo(DREAMCSCREEN_H/12);
            
        }];
    }];
    
    UIScrollView *myScrollview = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 100 + DREAMCSCREEN_H/12*2 + 20, DREAMCSCREEN_W, DREAMCSCREEN_H - 30 - (100 + DREAMCSCREEN_H/12*2 + 20))];
    CGSize cellSize = STRING_SIZE(DREAMCSCREEN_W, self.poemModle.content, self.myConfig.detialFont);
    CGFloat cellHeigh = cellSize.height;//真机调试还是现实不全，字体也调整不了,去掉设置字体就可以
    myScrollview.contentSize = CGSizeMake(DREAMCSCREEN_W, cellHeigh);
    myScrollview.showsHorizontalScrollIndicator = NO;
    myScrollview.scrollEnabled = YES;
    myScrollview.backgroundColor = [UIColor clearColor];
    [self.view addSubview:myScrollview];

    UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, DREAMCSCREEN_W, cellHeigh)];
    lable.text = self.poemModle.content;
    lable.numberOfLines = 0;
    lable.font = [UIFont systemFontOfSize:self.myConfig.detialFont];
    lable.textAlignment = NSTextAlignmentCenter;
    [myScrollview addSubview:lable];

}

#pragma mark -click

-(void)saveFalgClick:(UIButton*)button{
    
    if (self.flag == 4) {
        
        self.popView = [[ZYFPopview alloc]initInView:[UIApplication sharedApplication].keyWindow tip:@"删除已经背诵的吗?" images:(NSMutableArray*)@[] rows:(NSMutableArray*)@[@"删除"] doneBlock:^(NSInteger selectIndex) {
        
            [FavoriteModel MR_deleteAllMatchingPredicate:[NSPredicate predicateWithFormat:@"pid=%@",self.favoModel.pid]];
    
            [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
   
            self.config = [MymxConfig shareInstance];
            NSInteger readTSCount = self.config.readTScount;
            NSInteger readSCCount = self.config.readSCcount;
            NSInteger readYQCount = self.config.readYQcount;
             if (self.poemModle.category == 1) {
                
                readTSCount = readTSCount -1;
                [self.config saveReadTSCount:readTSCount];
                
            }else if (self.poemModle.category == 2){
                readSCCount = readSCCount - 1;
                [self.config saveReadSCCount:readSCCount];
            }else{
                readYQCount = readYQCount - 1;
                [self.config saveReadYQCount:readYQCount];
            }
            
            
      
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
            
        } cancleBlock:^{
            
        }];
        [self.popView showPopView];
        
    }else{
        NSArray * array = [FavoriteModel MR_findAllWithPredicate:[NSPredicate predicateWithFormat:@"pid=%ld",self.poemModle.pid]];
        if (array.count>0) {
            
            [self showBaseHud];
            [self dismissHudWithWarningTitle:@"背诵过了" After:1.f];
            
        }else{
            [self doSave:self.poemModle];
        }
  
    }
}

- (void)doSave:(PoemModel *)model{
    
    FavoriteModel * saveModel = [FavoriteModel MR_createEntity];
    [saveModel setUpWith:model];
    
    self.config = [MymxConfig shareInstance];
    NSInteger readTSCount = self.config.readTScount;
    NSInteger readSCCount = self.config.readSCcount;
    NSInteger readYQCount = self.config.readYQcount;
    
    if ([saveModel.category isEqualToNumber:[NSNumber numberWithInteger:1]]) {
        readTSCount = readTSCount+1;
        [self.config saveReadTSCount:readTSCount];
    }else if ([saveModel.category isEqualToNumber:[NSNumber numberWithInteger:2]]){
        readSCCount = readSCCount+1;
        [self.config saveReadSCCount:readSCCount];
    }else{
        readYQCount = readYQCount+1;
        [self.config saveReadYQCount:readYQCount];
    }
    
    [[NSManagedObjectContext MR_defaultContext]MR_saveToPersistentStoreAndWait];
    [self.rightButton setImage:ECIMAGENAME(@"mysave_s") forState:UIControlStateNormal];
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
