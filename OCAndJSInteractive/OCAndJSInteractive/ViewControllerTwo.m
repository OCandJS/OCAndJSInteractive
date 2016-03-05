//
//  ViewControllerTwo.m
//  OCAndJSInteractive
//
//  Created by apple on 16/3/3.
//  Copyright © 2016年 ZhangFan. All rights reserved.
//

#import "ViewControllerTwo.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "TestJSObject.h"

@interface ViewControllerTwo ()<UIWebViewDelegate>

@property (strong,nonatomic) UIWebView *myWebView;

@end

@implementation ViewControllerTwo

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /// @brief 初始化webview
    [self initWebView];
}

#pragma mark - 初始化webview
- (void)initWebView
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

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    /// @brief 创建JSContext对象(此处通过webview的键获取到JSContext)
    JSContext *context = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    
    /// @brief OC调用JS
//    NSString *javascript = @"alert('test js OC')";
    JSValue *str = [context evaluateScript:@"showAlert('张三')"];
    NSString *str3 = [NSString stringWithFormat:@"012-%@",str];
    NSLog(@"%@",str3);
    
    /// @brief JS调用OC(方法一)
    /// @brief test1为就是js的方法名称，赋值给一个block 里面是oc代码
    /// @brief 此方法最终将打印出所有接收到的参数,js参数是不固定的
//    context[@"test1"] = ^(){
//        NSArray *args = [JSContext currentArguments];
//        for (id obj in args) {
//            NSLog(@"%@",obj);
//        }
//    };
    
//    /// @brief 用OC调JS模拟JS调用OC
//    NSString *jsFunctStr = @"test2('参数1')";
//    [context evaluateScript:jsFunctStr];
    
    
    
    /// @brief JS调用OC(方法二)
    TestJSObject *testJO = [[TestJSObject alloc] init];
    context[@"testobject"] = testJO;
    
    /// @brief 通过OC调用JS模拟JS调用OC
    NSString *jsStr1 = @"testobject.TestNOParameter()";
    JSValue *backValue = [context evaluateScript:jsStr1];
    NSLog(@"返回值：%@",backValue);
    NSString *jsStr2 = @"testobject.TestOneParameter('参数1')";
    [context evaluateScript:jsStr2];
    NSString *jsStr3 = @"testobject.TestTowParameterSecondParameter('参数2','参数3')";
    ///  @"testobject.TestTowParameterSecondParameter('参数A','参数B')";  
    [context evaluateScript:jsStr3];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
