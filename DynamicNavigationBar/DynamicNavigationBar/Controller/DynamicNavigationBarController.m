//
//  DynamicNavigationBarController.m
//  DynamicNavigationBar
//
//  Created by liuzhiyi on 15/10/19.
//  Copyright © 2015年 liuzhiyi. All rights reserved.
//

#import "DynamicNavigationBarController.h"
#import "UIView+Utils.h"

typedef enum : NSUInteger {
    MyTopBarStatusDown = 0,
    MyTopBarStatusUp = 1,
} MyTopBarStatus;

@interface DynamicNavigationBarController ()
@property (strong, nonatomic) IBOutlet UIView *myTopBar;
@property (weak, nonatomic) IBOutlet UIView *myTopSearchBar;
@property (weak, nonatomic) IBOutlet UITableView *dateTableView;
@property (strong, nonatomic) NSMutableArray *dateList;
@property (assign, nonatomic) CGFloat scrollViewDragContentOffsetY;
@property (assign, nonatomic) MyTopBarStatus myTopBarStatus;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mySearchBarTopconstraint;
@property (weak, nonatomic) IBOutlet UITextField *mySearchBar;

@end

@implementation DynamicNavigationBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.dateTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    
    [self initSubView];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void)initSubView {
    [self.myTopBar setFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 64)];
    [[UIApplication sharedApplication].keyWindow addSubview:self.myTopBar];
}

- (void)resignMyTopBar {
    [self.myTopBar removeFromSuperview];
}

#pragma mark UITableViewDatasource,Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    cell.textLabel.text = @"cell";
    
    return cell;
}

#pragma mark UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.mySearchBar resignFirstResponder];
    self.scrollViewDragContentOffsetY = scrollView.contentOffset.y;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat progress = scrollView.contentOffset.y - self.scrollViewDragContentOffsetY;
    if(progress > 150) {
        self.scrollViewDragContentOffsetY = scrollView.contentOffset.y;
        
        if(scrollView.contentOffset.y > 0 && self.myTopBarStatus == MyTopBarStatusDown) {//防止在顶端拉扯时生效
            self.myTopBarStatus = MyTopBarStatusUp;
            self.mySearchBarTopconstraint.constant = 0;
            [UIView animateWithDuration:0.5 animations:^{
                [self.myTopBar updateOriginY:-44];
                [self.myTopSearchBar updateOriginY:0];
            }];
        }
    }else if(progress < -150){
        self.scrollViewDragContentOffsetY = scrollView.contentOffset.y;
        
        if(self.myTopBarStatus == MyTopBarStatusUp) {
            self.myTopBarStatus = MyTopBarStatusDown;
            self.mySearchBarTopconstraint.constant = 20;
            [UIView animateWithDuration:0.5 animations:^{
                [self.myTopBar updateOriginY:0];
                [self.myTopSearchBar updateOriginY:20];
            }];
        }
    }
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
