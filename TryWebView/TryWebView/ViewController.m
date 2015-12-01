//
//  ViewController.m
//  TryWebView
//
//  Created by Chun Cao on 15/11/23.
//  Copyright © 2015年 NJU. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property UIActivityIndicatorView *indicator ;

@end

@implementation ViewController 

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSURL *url= [[NSURL alloc] initWithString:@"http://p.nju.edu.cn"];
    
    NSURLRequest *request= [[NSURLRequest alloc] initWithURL:url];
    
    ((UIWebView *)self.view).delegate=self;
    
    [(UIWebView *)self.view loadRequest:request];
    
   self.indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    
    [self.indicator setCenter:CGPointMake(screenWidth/2.0, screenHeight/2.0)];
    [self.view addSubview:self.indicator];
    
    
}

-(void) webViewDidStartLoad:(UIWebView *)webView{
    [self.indicator startAnimating];
}

-(void) webViewDidFinishLoad:(UIWebView *)webView{
    [self.indicator stopAnimating];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
