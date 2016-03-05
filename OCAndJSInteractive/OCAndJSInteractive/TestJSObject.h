/**
 *  @file
 *  @author 张凡
 *  @date 2016/3/4
 */
#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>
/**
 *  @class TestJSObjectProtocol
 *  @brief 此类存放供JS调用的方法
 *  @author 张凡
 *  @date 2016/3/4
 */
@protocol TestJSObjectProtocol <JSExport>

-(NSString *)TestNOParameter;
-(void)TestOneParameter:(NSString *)message;
-(void)TestTowParameter:(NSString *)message1 SecondParameter:(NSString *)message2;

@end

@interface TestJSObject : NSObject<TestJSObjectProtocol>



@end
