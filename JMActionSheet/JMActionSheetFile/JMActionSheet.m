//
//  JMActionSheet.m
//  JMActionSheet
//
//  Created by admin on 15/10/8.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "JMActionSheet.h"
#import "UIImage+Image.h"
#define RGBA(R,G,B,A) [UIColor colorWithRed: R/255.0f green:G/255.0f blue:B/255.0f alpha:A]
#define Color_SubBtn [UIColor colorWithRed:0.173 green:0.624 blue:1.000 alpha:1.000]
@implementation JMActionSheet{
    UIView * backgroupView;
    UILabel * titleLab;
    UILabel * detailLab;
    UIView * containerView;
    UIButton * cancelBtn;
    UIButton * submitBtn;
    JMActionSheetBlock clickBlock;
    NSLayoutConstraint * layoutConstaintHeight;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+(JMActionSheet*)shareInstance
{
    static JMActionSheet *_sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    
    dispatch_once(&oncePredicate,^{
        _sharedInstance = [[JMActionSheet alloc] init];
    });
    
    return _sharedInstance;
}


-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        if (!backgroupView.superview) {
            [self install];
        }
        
    }
    return self;
}


-(void)install{
   
    backgroupView = self;
    
    backgroupView.backgroundColor = RGBA(0, 0, 0, 0.3);
    
    containerView = [UIView new];
  //  [containerView makeCornerWithRadius:10.];
    containerView.backgroundColor = [UIColor whiteColor];
    containerView.translatesAutoresizingMaskIntoConstraints = NO;
    [backgroupView addSubview:containerView];
    
    titleLab = [UILabel new];
    titleLab.font = [UIFont boldSystemFontOfSize:17];
    titleLab.translatesAutoresizingMaskIntoConstraints = NO;
    titleLab.textAlignment = NSTextAlignmentCenter;
    [backgroupView addSubview:titleLab];
    
    detailLab = [UILabel new];
    detailLab.font = [UIFont systemFontOfSize:17];
    detailLab.translatesAutoresizingMaskIntoConstraints = NO;
    detailLab.numberOfLines = 0;
    detailLab.textAlignment = NSTextAlignmentCenter;
    [backgroupView addSubview:detailLab];
    
    cancelBtn = [UIButton new];
    cancelBtn.translatesAutoresizingMaskIntoConstraints = NO;
    [self makeCornerForView:cancelBtn andRadius:3.0f];
    [cancelBtn setBackgroundImage:[UIImage imageWithColor:RGBA(193, 193, 193,1.0)] forState:UIControlStateNormal];
    [containerView addSubview:cancelBtn];
    [cancelBtn setBackgroundColor:[UIColor blackColor]];
    cancelBtn.tag = 0;
    
    submitBtn = [UIButton new];
    submitBtn.translatesAutoresizingMaskIntoConstraints = NO;
    [self makeCornerForView:submitBtn andRadius:3.0f];
   [submitBtn setBackgroundImage:[UIImage imageWithColor:Color_SubBtn] forState:UIControlStateNormal];
    
    [submitBtn setBackgroundColor:[UIColor blackColor]];
    [containerView addSubview:submitBtn];
    submitBtn.tag = 1;
    
    layoutConstaintHeight = [NSLayoutConstraint constraintWithItem:containerView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1.0 constant:115];
    
    [cancelBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [submitBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [backgroupView addConstraint:[NSLayoutConstraint constraintWithItem:backgroupView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:containerView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0]];
    //    [containerView addConstraint:layoutConstaintHeight];
    [backgroupView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(0)-[containerView]-(0)-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(backgroupView, containerView)]];
    
   // [backgroupView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(114)-[containerView]-(0)-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(backgroupView,containerView)]];
    
    
  //  [backgroupView addConstraint:[NSLayoutConstraint constraintWithItem:titleLab attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:backgroupView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:-40.]];
    [backgroupView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-25-[titleLab]-25-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(titleLab, backgroupView)]];
    [backgroupView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-35-[detailLab]-35-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(detailLab, backgroupView)]];
    
    [backgroupView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[titleLab]-(10)-[detailLab]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(detailLab, backgroupView,titleLab,cancelBtn)]];
    
    
    [backgroupView addConstraint:[NSLayoutConstraint constraintWithItem:containerView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:titleLab attribute:NSLayoutAttributeTop multiplier:1.0 constant:-10.]];
    
    [backgroupView addConstraint:[NSLayoutConstraint constraintWithItem:containerView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:detailLab attribute:NSLayoutAttributeBottom multiplier:1.0 constant:60.]];

}

-(void )makeCornerForView:(UIView *)tmpView andRadius:(CGFloat)radius{

    CALayer * lay = tmpView.layer;
    [lay setMasksToBounds:YES];
    [lay setCornerRadius:radius];

}

-(void)makeCornerWithRadius:(CGFloat)radius{
    CALayer * lay = self.layer;
    [lay setMasksToBounds:YES];
    [lay setCornerRadius:radius];
}

+(void)showWithTitle:(NSString*)title withDetail:(NSString*)detailStr withCancelTitle:(NSString*)cancelStr withSubmitTitle:(NSString*)submitStr withClickHandler:(JMActionSheetBlock)block{

    [[self shareInstance] showWithTitle:title withDetail:detailStr withCancelTitle:cancelStr withSubmitTitle:submitStr withClickHandler:block];


}

-(void)showWithTitle:(NSString*)title withDetail:(NSString*)detailStr withCancelTitle:(NSString*)cancelStr withSubmitTitle:(NSString*)submitStr withClickHandler:(JMActionSheetBlock)block{
    
    titleLab.text = title;
    detailLab.text = detailStr;
    CGFloat height = 40;
    detailLab.textAlignment = NSTextAlignmentCenter;
    detailLab.font = [UIFont systemFontOfSize:16.f];
    detailLab.textColor = [UIColor blackColor];
    
    if (submitStr) {
        [submitBtn setTitle:submitStr forState:UIControlStateNormal];
        submitBtn.hidden = NO;
        [containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[submitBtn(height)]-(10)-|" options:0 metrics:@{@"height":@(height)} views:NSDictionaryOfVariableBindings(containerView, submitBtn, detailLab)]];
        [containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[submitBtn]-(20)-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(containerView, submitBtn)]];
    }else{
        [cancelBtn setBackgroundImage:[UIImage imageWithColor:[UIColor redColor]] forState:UIControlStateNormal];
        submitBtn.hidden = YES;
    }
    
    if (cancelStr) {
        [cancelBtn setTitle:cancelStr forState:UIControlStateNormal];
        cancelBtn.hidden = NO;
        if (submitStr) {
            [containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[cancelBtn(height)]-(10)-|" options:0 metrics:@{@"height":@(height)} views:NSDictionaryOfVariableBindings(containerView, cancelBtn, detailLab)]];
            [containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(20)-[cancelBtn(submitBtn)]-(20)-[submitBtn]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(containerView, cancelBtn, submitBtn)]];
        }else{
            [containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[cancelBtn(height)]-(10)-|" options:0 metrics:@{@"height":@(height)} views:NSDictionaryOfVariableBindings(containerView, cancelBtn, detailLab)]];
            [containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[cancelBtn(120)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(containerView, cancelBtn)]];
            [containerView addConstraint:[NSLayoutConstraint constraintWithItem:cancelBtn attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:containerView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
        }
        
    }else{
        cancelBtn.hidden = YES;
    }
    
    [self setNeedsUpdateConstraints];
    
    clickBlock = [block copy];
    
    [self show];

    
    
}

-(void)btnAction:(UIButton*)sender{
    NSInteger index = sender.tag;
    if (index == 0) {
        [self dismiss];
    }else{
        [self dismiss];
    }
    if (clickBlock) {
        clickBlock(index);
    }
}


-(void)bgTap:(id)sender{
    [self dismiss];
}


-(void)dismiss{
    if (backgroupView.superview) {
        
        [UIView animateWithDuration:0.3 animations:^{
            backgroupView.alpha = 0.0;
            //            backgroupView.transform = CGAffineTransformMakeScale(1.5, 1.5);
            //            containerView.transform = CGAffineTransformMakeScale(0.2, 0.2);
        } completion:^(BOOL finished) {
            containerView.transform = CGAffineTransformIdentity;
            backgroupView.transform = CGAffineTransformIdentity;
            [backgroupView removeFromSuperview];
        }];
    }
}

-(void)show{
    if (!backgroupView.superview) {
        UIWindow * window = [UIApplication sharedApplication].keyWindow;
        backgroupView.frame = window.bounds;
        [window addSubview:backgroupView];
        [self layoutIfNeeded];
        backgroupView.alpha = 0.;
        
        backgroupView.transform = CGAffineTransformMakeScale(1.5, 1.5);
        [UIView animateWithDuration:0.2 animations:^{
            backgroupView.alpha = 1.0;
            backgroupView.transform = CGAffineTransformIdentity;
            [containerView layoutIfNeeded];
            [self layoutIfNeeded];
        } completion:^(BOOL finished) {
            
        }];
    }else{
        
        [UIView animateWithDuration:0.2 animations:^{
            [self layoutIfNeeded];
        }];
        
    }
    
}
+(void)dismiss{
    [[JMActionSheet shareInstance] dismiss];
}

@end
