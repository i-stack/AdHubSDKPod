//
//  HaoBoInputView.m
//  AdHubSDK
//
//  Created by Mac on 2017/6/22.
//  Copyright © 2017年 AdHub. All rights reserved.
//

#import "HaoBoInputView.h"
#import "HaoBoInputModel.h"

@interface HaoBoInputView ()

@property (nonatomic,strong)HaoBoInputViewTextFieldTextBlock textFieldTextBlock;
@property (nonatomic,strong)HaoBoInputModel *inputModel;

@end

@implementation HaoBoInputView

- (void)dealloc
{
    
}

- (instancetype)initWithFrame:(CGRect)frame textFieldText:(HaoBoInputViewTextFieldTextBlock)textFieldTextBlock
{
    if (self = [super initWithFrame:frame]) {
        self.textFieldTextBlock = textFieldTextBlock;
    }
    return self;
}

- (void)createTextField
{
    if ([HaoBoUtls currentSystemVersion_iOS8]) {
        [self alertViewController];
    }
}

- (void)alertViewController
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:self.inputModel.title message:self.inputModel.message preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = self.inputModel.placeholder;
    }];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSArray *textfields = alertController.textFields;
        HaoBoInputModel *model = [[HaoBoInputModel alloc]init];
        model.outputText = textfields[0];
        if (self.textFieldTextBlock) {
            self.textFieldTextBlock(model);
        }
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [alertController dismissViewControllerAnimated:YES completion:nil];
    }]];
    
    UIViewController *vc = [self getCurrentViewController:self];
    [vc presentViewController:alertController animated:YES completion:^{
        
    }];
}

- (void)configueTextField:(HaoBoInputModel *)inputModel
{
    self.inputModel = inputModel;
    [self createTextField];
}

- (UIViewController *)getCurrentViewController:(UIView *)currentView
{
    for (UIView *next = [currentView superview]; next; next = next.superview){
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]){
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

@end
