//
//  WalletNameViewController.m
//  qtum wallet
//
//  Created by Никита Федоренко on 30.12.16.
//  Copyright © 2016 Designsters. All rights reserved.
//

#import "WalletNameViewController.h"
#import "StartNavigationCoordinator.h"

@interface WalletNameViewController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *gradientViewBottomOffset;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;

@end

@implementation WalletNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    [self configTextField];
    [self.nameTextField becomeFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Configuration

-(void)configTextField{
    UIColor *color = [UIColor whiteColor];
    self.nameTextField.attributedPlaceholder =
    [[NSAttributedString alloc] initWithString:@"Enter Name"
                                    attributes:@{
                                                 NSForegroundColorAttributeName: color,
                                                 NSFontAttributeName : [UIFont fontWithName:@"SFUIDisplay-Thin" size:16.0]
                                                 }
     ];
}

#pragma mark - Notification

-(void)keyboardWillShow:(NSNotification *)sender{
    CGRect end = [[sender userInfo][UIKeyboardFrameEndUserInfoKey] CGRectValue];
    self.gradientViewBottomOffset.constant = end.size.height;
    [self.view layoutIfNeeded];
    
}

-(void)keyboardWillHide:(NSNotification *)sender{
    self.gradientViewBottomOffset.constant = 0;
    [self.view layoutIfNeeded];
}

#pragma mark - Actions

- (IBAction)actionConfirm:(id)sender {
    StartNavigationCoordinator* coordinator = (StartNavigationCoordinator*)self.navigationController;
    [coordinator addWalletName:self.nameTextField.text];
    [self performSegueWithIdentifier:@"createPin" sender:nil];
}



@end
