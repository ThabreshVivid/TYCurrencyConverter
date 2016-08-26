//
//  CountryView.m
//  TYCurrencyConverter
//
//  Created by Thabresh on 8/25/16.
//  Copyright © 2016 VividInfotech. All rights reserved.
//

#import "CountryView.h"
#import "CountryCell.h"
#import "ViewController.h"
#import "AppDelegate.h"
@interface CountryView ()
{
    NSMutableArray *infoList;
}
@end

@implementation CountryView
@synthesize selectedTag;
- (void)viewDidLoad {
    [super viewDidLoad];    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(backButtonAction:)];
    [self.countryTbl registerNib:[UINib nibWithNibName:@"CountryCell" bundle:nil] forCellReuseIdentifier:@"CountryCell"];
    self.countryTbl.estimatedRowHeight = 83;
    self.countryTbl.rowHeight = UITableViewAutomaticDimension;
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"currency" ofType:@"plist"];
    infoList =[NSMutableArray arrayWithContentsOfFile:filePath];  
    // Do any additional setup after loading the view.
}
-(void) backButtonAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return infoList.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CountryCell *cell =[tableView dequeueReusableCellWithIdentifier:@"CountryCell"];
    cell.CurrencyCode.text = [NSString stringWithFormat:@"CountryName :%@\nCountryCode :%@\nCurrencyCode :%@\nCurrencySymbol :%@",[infoList valueForKey:@"name"][indexPath.row],[infoList valueForKey:@"countryCode"][indexPath.row],[infoList valueForKey:@"currencyCode"][indexPath.row],[infoList valueForKey:@"currencytSymbol"][indexPath.row]];
    cell.flagImage.image = [UIImage imageNamed:[infoList valueForKey:@"countryCode"][indexPath.row]];
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    app.textTag = selectedTag;
    if (selectedTag==1) {
        [app.selectedCountry setObject:[infoList objectAtIndex:indexPath.row] forKey:@"to"];
    }else{
        [app.selectedCountry setObject:[infoList objectAtIndex:indexPath.row] forKey:@"from"];
    }
    [self.navigationController popViewControllerAnimated:YES];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
