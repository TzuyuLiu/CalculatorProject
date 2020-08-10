//
//  CalculatorViewController.m
//  CalculatorProject
//
//  Created by Richard on 2020/7/14.
//  Copyright © 2020 CalculatorProject. All rights reserved.
//

#import "CalculatorViewController.h"
#import "math.h"

@interface CalculatorViewController ()

@property (weak, nonatomic) IBOutlet UITextField *m_tfDisplay;
@property (weak, nonatomic) IBOutlet UIButton *m_btnAC;
@end

@implementation CalculatorViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addBtnTarget];
}

- (void)addBtnTarget
{
    [self.m_btnAC addTarget:self
                  action:@selector(onClickAC:)
                  forControlEvents:UIControlEventTouchUpInside];
}

// Reset to Default
- (void)onClickAC:(UIButton *)sender
{
    if (_m_tfDisplay.text.length != 0)
    {
        _m_tfDisplay.text = @"";
    }
    
    [_m_btnAC setTitle:@"AC" forState:UIControlStateNormal];
}

- (IBAction)clickNegativeButton:(UIButton *)sender
{
    NSString *displayText = _m_tfDisplay.text;
    
    if (displayText.length != 0)
    {
        NSString *firstChar = [_m_tfDisplay.text substringToIndex:1];
        
        if ([firstChar isEqualToString:@"-"])
        {
            _m_tfDisplay.text = [displayText stringByReplacingOccurrencesOfString:@"-" withString:@""];
        }
        else
        {
            _m_tfDisplay.text = [@"-" stringByAppendingString:displayText];
        }
    }
}

- (IBAction)clickNumberAndDotButton:(UIButton *)sender
{
    [_m_btnAC setTitle:@"C" forState:UIControlStateNormal];
    NSString *senderTitle = sender.titleLabel.text;
    //檢查不是數字
    if ([_m_tfDisplay.text containsString:@"不是數字"])
    {
        _m_tfDisplay.text = @"";
    }
    //檢查dot
    if (_m_tfDisplay.text.length != 0)
    {
        NSString *lastCharacter = [_m_tfDisplay.text substringFromIndex:[_m_tfDisplay.text length] -1];
        if ([lastCharacter isEqualToString:@"."] && [senderTitle isEqualToString:@"."])
        {
            return;
        }
    }
    //檢查0
    if (![_m_tfDisplay.text containsString:@"."])
    {
        if ([_m_tfDisplay.text containsString:@"0"] && [senderTitle isEqualToString:@"0"])
        {
            return;
        }
    }
    
    _m_tfDisplay.text = [NSString stringWithFormat:@"%@%@",_m_tfDisplay.text,senderTitle];
}

- (IBAction)clickEqualButton:(UIButton *)sender
{
    if (_m_tfDisplay.text.length == 0)
    {
        return;
    }
    NSString *expression = [_m_tfDisplay.text stringByReplacingOccurrencesOfString:@"x" withString:@"*"];;
    expression = [expression stringByReplacingOccurrencesOfString:@"÷" withString:@"/"];
    
    @try
    {
        NSPredicate *parsed = [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"1.0 * %@.0 = 0",expression]];
        NSExpression *left = [(NSComparisonPredicate *)parsed leftExpression];
        NSNumber *caculatedResult = [left expressionValueWithObject:nil context:nil];
        _m_tfDisplay.text = [NSString stringWithFormat:@"%@",caculatedResult];
    } @catch(NSException *exception)
    {
        NSLog(@"Input is not an expression...!");
    } @finally
    {
    }
}

- (IBAction)clickOperateButton:(UIButton *)sender
{
    if (_m_tfDisplay.text.length == 0)
    {
        return;
    }
    NSString *lastCharacter = [_m_tfDisplay.text substringFromIndex: [_m_tfDisplay.text length] - 1];
    if ([lastCharacter isEqualToString:@"+"] || [lastCharacter isEqualToString:@"-"] || [lastCharacter isEqualToString:@"x"] || [lastCharacter isEqualToString:@"÷"])
    {
        _m_tfDisplay.text = [_m_tfDisplay.text substringToIndex:[_m_tfDisplay.text length]-1];
        _m_tfDisplay.text = [NSString stringWithFormat:@"%@%@",_m_tfDisplay.text,sender.titleLabel.text];
        return;
    }
    _m_tfDisplay.text = [NSString stringWithFormat:@"%@%@",_m_tfDisplay.text,sender.titleLabel.text];
}

- (IBAction)ClickfactorialButton:(UIButton *)sender
{
    NSString *number = _m_tfDisplay.text;
    if ([number containsString:@"."] || [number containsString:@"+"] || [number containsString:@"-"] || [number containsString:@"x"] || [number containsString:@"÷"])
    {
        _m_tfDisplay.text = @"不是數字";
        return;
    }
    int result = 1;
    for (int i=1; i<=[number intValue]; i++)
    {
        result = i * result;
    }
    _m_tfDisplay.text = [NSString stringWithFormat:@"%d", result];
}

@end
