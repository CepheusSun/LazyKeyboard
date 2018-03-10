//
//  OpenMainKit.m
//  Lazy
//
//  Created by sunny on 2018/3/4.
//  Copyright © 2018年 CepheusSun. All rights reserved.
//

#import "OpenMainKit.h"

@implementation OpenMainKit

+ (void)openMainApp:(UIViewController * _Nonnull)controller extensionContext:(NSExtensionContext * _Nullable )context {
    
    UIResponder *responder = controller;
    while (responder) {
        if ([responder isKindOfClass:[UIApplication class]]) break;
        responder = [responder nextResponder];
    }
    NSString* toUtf8= @"cepheus://";
    NSURL* url = [NSURL URLWithString:toUtf8];
    [responder performSelector:@selector(openURL:) withObject:url];
    if (context) {
        [context openURL:url completionHandler:nil];
    }
}

@end
