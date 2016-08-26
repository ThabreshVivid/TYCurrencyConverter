//
//  CountryCell.h
//  TYCurrencyConverter
//
//  Created by Thabresh on 8/25/16.
//  Copyright © 2016 VividInfotech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CountryCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *CurrencyCode;
@property (weak, nonatomic) IBOutlet UIImageView *flagImage;
@end
