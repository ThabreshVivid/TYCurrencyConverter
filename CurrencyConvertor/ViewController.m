//
//  ViewController.m
//  TYCurrencyConverter
//
//  Created by Thabresh on 8/25/16.
//  Copyright © 2016 VividInfotech. All rights reserved.
//

#import "ViewController.h"
#import "CountryView.h"
#import "AppDelegate.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
-(void)viewWillAppear:(BOOL)animated
{
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    if (app.selectedCountry.count == 1) {
        self.navigationItem.prompt = [[app.selectedCountry objectForKey:@"from"]valueForKey:@"name"];
    }else if (app.selectedCountry.count == 2) {
           self.navigationItem.prompt = [NSString stringWithFormat:@"%@ = %@",[[app.selectedCountry objectForKey:@"from"] valueForKey:@"name"],[[app.selectedCountry objectForKey:@"to"] valueForKey:@"name"]];
    }
    if (app.selectedCountry.count>0) {
        if (app.textTag == 0) {
            self.fromCountry.text = [[app.selectedCountry objectForKey:@"from"]valueForKey:@"currencyCode"];
            NSURLSession *session = [NSURLSession sharedSession];
                [[session dataTaskWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://api.fixer.io/latest?base=%@",self.fromCountry.text]]
                        completionHandler:^(NSData *data,
                                            NSURLResponse *response,
                                            NSError *error) {
                            if (data.length > 0 && error == nil)
                            {
                                _countriesCurr = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];                                
                            }else {
                                [self ShowAlert:error.localizedDescription];
                            }
                        }] resume];
            }else{
            self.toCountry.text = [[app.selectedCountry objectForKey:@"to"] valueForKey:@"currencyCode"];
        }
    }
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    app.textTag = 0;
    if (textField.tag == 1) {
        app.textTag = 1;
    }
    if (textField.tag == 1 || textField.tag == 0) {
        [self performSegueWithIdentifier:@"getCountry" sender:self];
        return NO;
    }
    return YES;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    CountryView *view =[segue destinationViewController];
    view.selectedTag = app.textTag;
    // Pass the selected object to the new view controller.
}
- (IBAction)clickOnConvert:(id)sender {
    if ([self CheckValidation]) {
        CGFloat inr = [[[_countriesCurr objectForKey:@"rates"]valueForKey:self.toCountry.text]floatValue];
        
        self.toValue.text = [NSString stringWithFormat:@"%f",[self.fromValue.text floatValue]*inr];
    }
}
-(BOOL)CheckValidation
{
    if (self.fromCountry.text.length == 0) {
        [self ShowAlert:@"Please choose from country"];
        return NO;
    }else if (self.toCountry.text.length == 0) {
        [self ShowAlert:@"Please choose to country"];
        return NO;
    }else if (self.fromValue.text.length == 0) {
        [self ShowAlert:@"Please enter the value to convert"];
        return NO;
    }
    return YES;
}
-(void)ShowAlert:(NSString*)Message
{
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:@"Warning"
                                 message:Message
                                 preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* yesButton = [UIAlertAction
                                actionWithTitle:@"OK"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action) {
                                    //Handle your yes please button action here
                                }];
    [alert addAction:yesButton];
    [self presentViewController:alert animated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
