//
//  ViewController.m
//  testbras
//
//  Created by Apple on 15/12/2.
//  Copyright © 2015年 Apple. All rights reserved.
//

#import "ViewController.h"
#import "MBProgressHUD+NJ.h"

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
   //     NSLog(@"response : %@", response);
    //    NSLog(@"error: %@",error);
        if(data){
        NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];

            NSString *re_msg=[dict objectForKey:@"reply_msg"];
        dispatch_async(dispatch_get_main_queue(), ^{
            
                [MBProgressHUD showSuccess:re_msg];
        
            
        });
        }
        else{
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD showError:@"喵～没有网络"];});
        }
        
    }];
    
    [task resume];
   
 
}
- (IBAction)btnClicked:(id)sender {
    NSUserDefaults* usersDefaults=[[NSUserDefaults alloc]initWithSuiteName:@"group.TodayBras"];
    [usersDefaults setObject:self.username.text forKey:@"name"];
    [usersDefaults setObject:self.password.text forKey:@"pwd"];
    [usersDefaults setBool:YES forKey:@"UpdateSetting"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    
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
  
        
        if(data){
            NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
         //   NSLog(@"%@",dict);
          //  NSString *code=dict[@"reply_code"];
            
            int re_code=[dict[@"reply_code"] intValue];
            NSString *re_msg=[dict objectForKey:@"reply_msg"];
          
            dispatch_async(dispatch_get_main_queue(), ^{

            if(re_code==1){
                [MBProgressHUD showSuccess:re_msg];
            }
            else{
                [MBProgressHUD showError:re_msg];
            }
                
                
            });
            
        }
        else{
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD showError:@"喵～没有网络"];});
        }}];
    
    [task resume];

}

- (void)viewDidLoad {
    [super viewDidLoad];
   

    NSUserDefaults* userDefaults=[[NSUserDefaults alloc]initWithSuiteName:@"group.TodayBras"];
    self.username.text=[userDefaults objectForKey:@"name"];
    self.password.text=[userDefaults objectForKey:@"pwd"];
    
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
