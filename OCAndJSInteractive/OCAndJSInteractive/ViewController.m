//
//  ViewController.m
//  OCAndJSInteractive
//
//  Created by apple on 16/3/3.
//  Copyright © 2016年 ZhangFan. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIWebViewDelegate>

@property (strong,nonatomic) UIWebView *myWebView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /// @brief JS交互准备
    [self JSInteractiveReady];
    /// @brief 准备JS交互按钮
    [self JSInteractiveButton];
}

#pragma mark - JS交互准备
- (void)JSInteractiveReady
{
    CGSize size = self.view.frame.size;
    /// @brief 创建要打开的html文件的完整路径
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *resPath = [bundle resourcePath];
    NSString *filePath = [resPath stringByAppendingPathComponent:@"index.html"];
    /// @brief 初始化一个UIWebView实例
    self.myWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 100, size.width, size.height - 100.0)];
    /// @brief 加载指定的html文件
    [self.myWebView loadRequest:[[NSURLRequest alloc] initWithURL:[[NSURL alloc] initFileURLWithPath:filePath]]];
    self.myWebView.delegate = self;
    [self.view addSubview:self.myWebView];
    
}


#pragma mark - 准备JS交互按钮
- (void)JSInteractiveButton
{
    CGSize size = self.view.frame.size;
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(20, 30, size.width - 40.0, 40)];
    [button setTitle:@"OC与JS交互" forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor orangeColor]];
    [button addTarget:self action:@selector(interactive:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
}

#pragma mark - 按钮事件
- (void)interactive:(id)sender
{
    /// @brief OC调用JS的方法，showAlert2()为JS方法名，在调用JS方法之前需HTML完成加载
    [self.myWebView stringByEvaluatingJavaScriptFromString:@"showAlert2()"];
    
}

#pragma mark - WebView加载完成的方法
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    
    NSString *str = [self.myWebView stringByEvaluatingJavaScriptFromString:@"showAlert('zhangsan')"];
    NSLog(@"webView加载完成--%@",str);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
