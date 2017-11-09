//
//  AddNotesViewController.m
//  LuckProject
//
//  Created by moxi on 2017/9/5.
//  Copyright © 2017年 moxi. All rights reserved.
//

#import "AddNotesViewController.h"

@interface AddNotesViewController ()<UITextFieldDelegate,UITextViewDelegate>

@property (nonatomic, strong)UITextField *titleText;
@property (nonatomic, strong)UITextView *contentText;

@property (nonatomic, strong)NSMutableArray *notesDatas;

@end

@implementation AddNotesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIImageView *imageBg = [[UIImageView alloc]initWithFrame:self.view.bounds];
    imageBg.image = ECIMAGENAME(@"bg2");
    [self.view addSubview:imageBg];
    
    
    if (self.flag == 1) {
        [self createDetialView];
        self.navigationItem.title = self.poemTitle;
    }else{
        self.navigationItem.title = @"Add Note";
        [self createUI];
        
        [self loadNoteData];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -loadData

-(void)loadNoteData{
    
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path1 = [pathArray objectAtIndex:0];
    NSString *myPath = [path1 stringByAppendingPathComponent:@"notes.plist"];
    
    NSMutableArray*data2 = [[NSMutableArray alloc] initWithContentsOfFile:myPath];
    
    self.notesDatas = [NSMutableArray array];
    
    if (data2.count) {
        [self.notesDatas addObjectsFromArray:data2];
    }
}

#pragma mark -UI

-(void)createDetialView{
    
    self.contentText = [[UITextView alloc]init];
    self.contentText.text = [[self.poemTitle stringByAppendingString:@"\n"]stringByAppendingString:self.poemContent];
    self.contentText.font = [UIFont systemFontOfSize:16];
    self.contentText.editable = NO;
    self.contentText.textAlignment = NSTextAlignmentCenter;
    self.contentText.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.contentText];
    
    [self.contentText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top).offset(80);
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-50);
        make.left.mas_equalTo(self.view.mas_left).offset(50);
        make.right.mas_equalTo(self.view.mas_right).offset(-50);
    }];
}

-(void)createUI{
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 32, 32);
    [button setImage:ECIMAGENAME(@"mybottom") forState:UIControlStateNormal];
    [button addTarget:self action:@selector(backNotesClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *left = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = left;
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 60, 35);
    [rightBtn setTitle:@"保存" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(saveClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = right;
    
    
    self.titleText = [[UITextField alloc]init];
    self.titleText.delegate = self;
    self.titleText.keyboardType = UIKeyboardTypeDefault;
    self.titleText.backgroundColor = [UIColor clearColor];
    self.titleText.layer.borderWidth = 1;
    self.titleText.placeholder = @"输入标题";
    self.titleText.layer.borderColor = ECCOLOR(231, 212, 172, 1).CGColor;
    [self.view addSubview:self.titleText];
    
    self.contentText = [[UITextView alloc]init];
    self.contentText.delegate = self;
    self.contentText.keyboardType = UIKeyboardTypeDefault;
    self.contentText.backgroundColor = [UIColor clearColor];
    self.contentText.layer.borderWidth = 1;
    self.contentText.layer.borderColor = ECCOLOR(231, 212, 172, 1).CGColor;
    [self.view addSubview:self.contentText];
    
    [self configFrame];
    
}

#pragma mark -frame

-(void)configFrame{
    
    [self.titleText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top).offset(100);
        make.left.mas_equalTo(self.view.mas_left).offset(30);
        make.right.mas_equalTo(self.view.mas_right).offset(-30);
        make.height.mas_equalTo(40);
    }];
    
    [self.contentText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleText.mas_bottom).offset(30);
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-50);
        make.left.mas_equalTo(self.view.mas_left).offset(30);
        make.right.mas_equalTo(self.view.mas_right).offset(-30);
    }];
}

#pragma mark -click

-(void)backNotesClick:(UIButton*)button{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)saveClick:(UIButton*)button{
    
    if (self.titleText.text.length == 0 || self.contentText.text.length == 0) {
       
        [self showBaseHud];
        [self dismissHudWithInfoTitle:@"标题内容不能为空" After:1.f];
    }else{
        NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsPath = [path objectAtIndex:0];
        NSString *plistPath = [documentsPath stringByAppendingPathComponent:@"notes.plist"];
        //赋值
        NSMutableDictionary * newsDict = [NSMutableDictionary dictionary];
        [newsDict setObject:self.titleText.text forKey:@"title"];
        [newsDict setObject:self.contentText.text forKey:@"notes"];
        [newsDict setObject:[NSString currtenDate] forKey:@"date"];
        [self.notesDatas addObject:newsDict];
        //数据写入plist
        [self.notesDatas writeToFile:plistPath atomically:YES];
        
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }
}

#pragma mark -textDelegate

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.titleText resignFirstResponder];
    [self.contentText resignFirstResponder];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [self.titleText resignFirstResponder];
    [self.contentText resignFirstResponder];
    
    return YES;
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
