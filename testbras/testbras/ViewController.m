//
//  ViewController.m
//  testbras
//
//  Created by Apple on 15/12/2.
//  Copyright © 2015年 Apple. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
- (IBAction)endEditing:(id)sender {
    
}
- (IBAction)btnLogout:(id)sender {
    //构造url
    NSURL *url=[NSURL URLWithString:@"http://p.nju.edu.cn/portal_io/logout"];
    //构造request
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    //设置为post请求
    [request setHTTPMethod:@"POST"];
    //超时
    [request setTimeoutInterval:60];
    
    //设置请求头
    //[request setAllHTTPHeaderFields:nil];
    
    
    //设置请求体
    [request setHTTPBody:nil];
    NSURLSession *session = [NSURLSession sharedSession];
    //task
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSLog(@"response : %@", response);
        NSLog(@"error: %@",error);
        NSLog(@"data: %@",data);
    }];
    
    [task resume];

}
- (IBAction)btnClicked:(id)sender {
    //构造url
    NSURL *url=[NSURL URLWithString:@"http://p.nju.edu.cn/portal_io/login"];
    //构造request
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    //设置为post请求
    [request setHTTPMethod:@"POST"];
    //超时
    [request setTimeoutInterval:60];
    
    //设置请求头
    //[request setAllHTTPHeaderFields:nil];
    //设置请求体
    NSString *str1,*str2;
    str1=self.username.text;
    str2=self.password.text;
    NSString *bodyStr;
    bodyStr=[NSString stringWithFormat:@"username=%@&password=%@",str1,str2];
    NSData *bodyData = [bodyStr dataUsingEncoding:NSUTF8StringEncoding];
    
    
    //设置请求体
    [request setHTTPBody:bodyData];
    NSURLSession *session = [NSURLSession sharedSession];
    //task
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSLog(@"response : %@", response);
        NSLog(@"error: %@",error);
        NSLog(@"data: %@ %@ %@",str1,str2,bodyStr);
        
    }];
    
    [task resume];
    

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
