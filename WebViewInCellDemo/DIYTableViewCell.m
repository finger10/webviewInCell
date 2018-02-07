//
//  DIYTableViewCell.m
//  WebViewInCellDemo
//
//  Created by caihongguang on 2018/2/7.
//  Copyright © 2018年 caihongguang. All rights reserved.
//

#import "DIYTableViewCell.h"
@implementation DIYTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    
    [self creatSubviews];
    
    
}

- (void)creatSubviews
{
    WKWebViewConfiguration *confifg = [[WKWebViewConfiguration alloc] init];
    confifg.selectionGranularity = WKSelectionGranularityCharacter;
    _wkWebView = [[WKWebView alloc] initWithFrame:CGRectMake(14, 0, self.frame.size.width - 28, 1) configuration:confifg];

    //    _webView.scalesPageToFit = NO;
    _wkWebView.scrollView.scrollEnabled=NO;
    _wkWebView.userInteractionEnabled = NO;
    _wkWebView.opaque = NO;
    _wkWebView.scrollView.bounces=NO;
    _wkWebView.backgroundColor=[UIColor orangeColor];
    _wkWebView.UIDelegate = self; _wkWebView.scrollView.decelerationRate=UIScrollViewDecelerationRateNormal;
    [self addSubview:_wkWebView];
  
}


- (void)setDetail:(NSString *)detail
{
    if(!_detail){
        _detail = detail;
        if (_detail.length >0) {
            
            [self.wkWebView loadHTMLString:[NSString stringWithFormat:@"<meta content=\"width=device-width, initial-scale=1.0, maximum-scale=3.0, user-scalable=0;\" name=\"viewport\" />%@<div id=\"testDiv\" style = \"height:100px; width:100px\"></div>",_detail] baseURL:[NSURL fileURLWithPath: [[NSBundle mainBundle]  bundlePath]]];
        }
        
    }
    
}





- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
