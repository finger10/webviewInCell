//
//  DIYTableViewCell.h
//  WebViewInCellDemo
//
//  Created by caihongguang on 2018/2/7.
//  Copyright © 2018年 caihongguang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
@interface DIYTableViewCell : UITableViewCell<WKUIDelegate>

@property (strong, nonatomic) WKWebView *wkWebView;

@property (nonatomic,strong)NSString *detail;

//- (void)setDetail:(NSString *)detail;

@end
