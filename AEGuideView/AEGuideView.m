//
//  AEGuideView.m
//  AEGuideViewDemo
//
//  Created by WangLin on 2016/11/11.
//  Copyright © 2016年 amberease. All rights reserved.
//

#import "AEGuideView.h"
#import "AEGuideViewInnerViewController.h"

@interface AEGuideView(){
    UIView* _coreView;
}

@end

@implementation AEGuideView


+(instancetype) instance{
    static AEGuideView* result = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        result = [[AEGuideView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        result.windowLevel = UIWindowLevelAlert;
    });
    return result;
}

-(void)showGuideViewWithImages:(NSArray *)images andButtonTitle:(NSString *)title andButtonTitleColor:(UIColor *)titleColor andButtonBGColor:(UIColor *)bgColor andButtonBorderColor:(UIColor *)borderColor withCompletionBlock:(void (^)(void))block{
    AEGuideViewInnerViewController* controller = [[AEGuideViewInnerViewController alloc] init];
    controller.images = images;
    controller.buttonTitle = title;
    controller.titleColor = titleColor;
    controller.buttonBgColor = bgColor;
    controller.buttonBorderColor = borderColor;
    
    __weak AEGuideView* weakSelf = self;
    controller.completion = ^(void){
        [weakSelf resignKeyWindow];
        weakSelf.hidden = YES;
        if(block){
            block();
        }
    };
    
    [self setRootViewController:controller];
    [self addSubview:controller.view];
    
    _coreView = controller.view;
    [self setupContraints];
    
    [self makeKeyAndVisible];
    self.hidden = NO;
   
    
    
}

-(void)setupContraints{
    
    NSDictionary *dict = NSDictionaryOfVariableBindings(_coreView);
    NSString *vfl = @"|-0-[_coreView]-0-|";
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:vfl options:0 metrics:nil views:dict]];
}

@end
