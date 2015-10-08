//
//  JMActionSheet.h
//  JMActionSheet
//
//  Created by admin on 15/10/8.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^JMActionSheetBlock)(NSInteger index);

@interface JMActionSheet : UIView

+(void)showWithTitle:(NSString*)title withDetail:(NSString*)detailStr withCancelTitle:(NSString*)cancelStr withSubmitTitle:(NSString*)submitStr withClickHandler:(JMActionSheetBlock)block;



@end
