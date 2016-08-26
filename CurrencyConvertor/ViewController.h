//
//  ViewController.h
//  TYCurrencyConverter
//
//  Created by Thabresh on 8/25/16.
//  Copyright © 2016 VividInfotech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITextFieldDelegate>
@property NSDictionary *countriesCurr;
@property (weak, nonatomic) IBOutlet UITextField *fromCountry;
@property (weak, nonatomic) IBOutlet UITextField *toCountry;
@property (weak, nonatomic) IBOutlet UITextField *fromValue;
@property (weak, nonatomic) IBOutlet UITextField *toValue;
@end

