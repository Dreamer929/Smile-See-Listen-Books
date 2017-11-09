//
//  SearchViewController.m
//  LuckProject
//
//  Created by moxi on 2017/9/5.
//  Copyright © 2017年 moxi. All rights reserved.
//

#import "SearchViewController.h"
#import "PoemModel.h"

@interface SearchViewController ()<UISearchResultsUpdating,UISearchControllerDelegate>

@property (nonatomic, strong)UISearchController *mySearchVC;

@property (nonatomic, strong)NSArray *resultData;


@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.resultData = [NSArray array];
    
    [self createUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -UI

-(void)createUI{
    
    [self initTableViewWithFrame:CGRectMake(0, 0, DREAMCSCREEN_W, DREAMCSCREEN_H) WithHeadRefresh:NO WithFootRefresh:NO WithScrollIndicator:NO];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    self.mySearchVC = [[UISearchController alloc]initWithSearchResultsController:nil];
    self.mySearchVC.searchResultsUpdater = self;
    self.mySearchVC.delegate = self;
    self.mySearchVC.dimsBackgroundDuringPresentation = NO;
    self.mySearchVC.searchBar.tintColor = [UIColor whiteColor];
    self.mySearchVC.searchBar.barTintColor = [UIColor redColor];
    self.tableView.tableHeaderView = self.mySearchVC.searchBar;
    
}

#pragma mark -UItableview

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.resultData.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    PoemModel * model = self.resultData[indexPath.row];
     NSString * str  = [NSString stringWithFormat:@"%@\n%@\n%@",model.title,model.author,model.content];
    CGSize cellSize = STRING_SIZE(DREAMCSCREEN_W, str, 13);
    CGFloat cellHeigh = cellSize.height;
    return cellHeigh;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    PoemModel * model = self.resultData[indexPath.row];
    
    NSString * str  = [NSString stringWithFormat:@"%@\n%@\n%@",model.title,model.author,model.content];
    cell.textLabel.text = str;
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    [cell.textLabel sizeToFit];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ShiciDetialViewController *vc = [[ShiciDetialViewController alloc]init];
    self.hidesBottomBarWhenPushed = YES;
    vc.poemModle = self.resultData[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark -UISearchResultsUpdating

-(void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    NSString *textString = searchController.searchBar.text;
    
    if (textString.length == 0) {
        return;
    }
    
    self.resultData = [self.dataSouce filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id  _Nonnull evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
        
        PoemModel * model = (PoemModel *)evaluatedObject;
        NSString * str = [NSString stringWithFormat:@"%@%@%@",model.title,model.author,model.content];
        NSRange range = [str rangeOfString:textString];
        return (range.location != NSNotFound);
        
    }]];
    self.navigationItem.title = textString;
    [self.tableView reloadData];
    
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
