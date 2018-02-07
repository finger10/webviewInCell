//
//  ViewController.m
//  WebViewInCellDemo
//
//  Created by caihongguang on 2018/2/7.
//  Copyright © 2018年 caihongguang. All rights reserved.
//

#import "ViewController.h"
#import "DIYTableViewCell.h"
#import "HYBTestModel.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,WKUIDelegate,WKNavigationDelegate>
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic)CGFloat webHeight;

@end

@implementation ViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.tableView = [[UITableView alloc] init];
    //没有frame 不走代理方法
    self.tableView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    self.tableView.delegate = self;
    self.tableView.dataSource =self;
    [self.view addSubview:self.tableView];
    
    
    self.tableView.tableFooterView = [UIView new];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0){
        return self.webHeight;
    }// 当前tableview是加载web状态时 cell返回高度
    
    return 20;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // 判断webView所在的cell是否可见，如果可见就layout
    NSArray *cells = self.tableView.visibleCells;
    for (UITableViewCell *cell in cells) {
        if ([cell isKindOfClass:[UITableViewCell class]]) {
            DIYTableViewCell *webCell = (DIYTableViewCell *)cell;
            [webCell.wkWebView setNeedsLayout];
        }
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DIYTableViewCell *diyTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"diycellReusableIdentifier"];
    if(!diyTableViewCell)
    {
        diyTableViewCell = [[[NSBundle mainBundle] loadNibNamed:@"DIYTableViewCell" owner:self options:nil] lastObject];
    }
    diyTableViewCell.wkWebView.UIDelegate = self;
   diyTableViewCell.wkWebView.navigationDelegate =self;
    diyTableViewCell.detail = @"<img width=\"100%\" heigth=\"auto\" src=\"http://p0mw1p48z.bkt.clouddn.com/Fkpi7-StnF0cuuI9r-Tm0mgaHorD\" id=\"/Fkpi7-StnF0cuuI9r-Tm0mgaHorD\">";
    
    return diyTableViewCell;
    
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation
{
    
    [webView evaluateJavaScript:@"document.getElementById(\"testDiv\").offsetTop"completionHandler:^(id _Nullable result,NSError * _Nullable error) {
        //获取页面高度，并重置webview的frame
        CGFloat lastHeight  = [result doubleValue];
        webView.frame = CGRectMake(14, 0, self.view.frame.size.width - 28, lastHeight);
        self.webHeight = lastHeight;
        [self.tableView beginUpdates];
        [self.tableView endUpdates];
    }];
    
    
    
}

@end
