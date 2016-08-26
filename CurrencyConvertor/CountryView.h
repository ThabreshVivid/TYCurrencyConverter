//
//  CountryView.h
//  TYCurrencyConverter
//
//  Created by Thabresh on 8/25/16.
//  Copyright © 2016 VividInfotech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CountryView : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *countryTbl;
@property NSInteger selectedTag;
@end
