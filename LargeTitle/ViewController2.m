//
//  ViewController2.m
//  LargeTitle
//
//  Created by liulishuo on 2017/12/7.
//  Copyright © 2017年 liulishuo. All rights reserved.
//

#import "ViewController2.h"
#import "UIViewController+VKLargeTitle.h"

@interface ViewController2 ()
@property (weak, nonatomic) IBOutlet UIScrollView *sv;

@end

@implementation ViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
     [self showLargeTitle:@"title2" contentView:_sv];
}

- (void)viewWillAppear:(BOOL)animated {
    
}

- (void)viewDidAppear:(BOOL)animated {
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)click:(id)sender {
    NSLog(@"%s",__func__);
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
