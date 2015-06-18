//
//  ViewController.m
//  EncryptIDE
//
//  Created by Nick on 15/6/18.
//  Copyright (c) 2015年 guibi.td. All rights reserved.
//

#import "ViewController.h"

#import "NSString+IDEA.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textfield1;
@property (weak, nonatomic) IBOutlet UILabel *encryptlab1;
@property (weak, nonatomic) IBOutlet UILabel *encryptlab2;
@property (weak, nonatomic) IBOutlet UILabel *decode;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)encryptOnClick:(id)sender {
    if (![self.textfield1.text isEqualToString:@""]) {
        self.encryptlab1.text = [self.textfield1.text stringWithStrToIDEA];
        self.encryptlab2.text = [self.textfield1.text stringWithStrToIDEA];
    }
}
- (IBAction)decodeOnClick:(id)sender {
    if (![self.encryptlab2.text isEqualToString:@""]) {
        self.decode.text = [self.encryptlab2.text stringWithIDEAToStr];
    }
}

@end
