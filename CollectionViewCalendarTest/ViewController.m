//
//  ViewController.m
//  CollectionViewCalendarTest
//
//  Created by xzh on 15/12/24.
//  Copyright © 2015年 BY-R. All rights reserved.
//

#import "ViewController.h"
#import "BYCustomCollectionViewCell.h"
#import "NSDate+BYBaseCalendar.h"
#import "BYBaseDateTools.h"
@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>{
    CGFloat collW;
    int   currentWeekDay;
}
@property (nonatomic, strong)UICollectionView       *currentCollectionView;
@property (nonatomic, strong)NSMutableArray         *dataArray;;
@property (nonatomic, strong)NSMutableDictionary    *dictionary;

@end

@implementation ViewController
- (NSMutableArray *)dataArray{
    if (!_dataArray){
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
- (NSMutableDictionary *)dictionary{
    if (!_dictionary){
        _dictionary = [NSMutableDictionary dictionary];
    }
    return _dictionary;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    currentWeekDay = 0;
    [self loadData];
    
    UICollectionViewFlowLayout  *layout = [[UICollectionViewFlowLayout alloc] init];
    _currentCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(10, 60, self.view.frame.size.width-20, 244) collectionViewLayout:layout];
    _currentCollectionView.dataSource = self;
    _currentCollectionView.delegate = self;
    _currentCollectionView.backgroundColor = [UIColor orangeColor];
    _currentCollectionView.autoresizesSubviews = NO;
    [_currentCollectionView registerClass:[BYCustomCollectionViewCell class] forCellWithReuseIdentifier:@"qianCell"];
    [_currentCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    [self.view addSubview:_currentCollectionView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)loadData{
    NSDate *currentDate = [NSDate date];
    //获取当月天
    int monthNum = (int)[currentDate BYBaseNumberOfDaysInCurrentMonth];
    //获取第一天日期
    NSDate *firstDate = [currentDate BYBaseFirstDayOfCurrentMonth];
    int weekday = [firstDate BYBaseWeekly];
    weekday = weekday-1;
    
    int weekRow = 0;
    int tmp = monthNum;
    if (weekday!=7){
        currentWeekDay = weekday;
        weekRow ++;
        tmp = monthNum-(7-weekday);
    }
    weekRow += tmp/7;
    weekRow += (tmp%7)?1:0;
    int nextDate = 1;
    for (int i = 0; i < weekRow; i ++) {
        for (int j = 0; j < 7; j ++) {
            if (weekday != 7 && (i*7+j)<weekday){
                NSDate *preDate = [BYBaseDateTools getPreviousframDate:currentDate];
                int preDays = (int)[preDate BYBaseNumberOfDaysInCurrentMonth];
                CutomDataModel *obj = [[CutomDataModel alloc] init];
                obj.dateTitle = [NSString stringWithFormat:@"%d",preDays-weekday+j+1];
                NSLog(@"%d,%d",preDays,weekday);
                obj.isCurrentMoth = NO;
                [self.dataArray addObject:obj];
            }else if ((i*7+j+1-(weekday==7?0:weekday))<=monthNum){
                CutomDataModel *obj = [[CutomDataModel alloc] init];
                obj.dateTitle = [NSString stringWithFormat:@"%d",(i*7+j+1-(weekday==7?0:weekday))];
                obj.isCurrentMoth = YES;
                [self.dataArray addObject:obj];
            }else{
                CutomDataModel *obj = [[CutomDataModel alloc] init];
                obj.dateTitle = [NSString stringWithFormat:@"%d",nextDate++];
                obj.isCurrentMoth = NO;
                [self.dataArray addObject:obj];
            }
            
        }
    }
    
    for (int i = 1; i < 24; i ++) {
        if (i%7 == 0){
            [self.dictionary setObject:@{@"signCouponMoney":@(i/7*5)} forKey:@(i).stringValue];
        }else{
            [self.dictionary setObject:@(i).stringValue forKey:@(i).stringValue];
        }
    }
}


#pragma mark ------
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    BYCustomCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"qianCell" forIndexPath:indexPath];
    cell.indexPath = indexPath;
    cell.currentWeekDay = currentWeekDay;
    CutomDataModel *obj = self.dataArray[indexPath.row];
    [cell setContentModel:obj];
    if (self.dictionary){
        [cell setValueWithDictionary:self.dictionary];
    }
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((collectionView.frame.size.width - 6)/7, (collectionView.frame.size.width - 6)/7);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 1;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 1;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if (kind == UICollectionElementKindSectionHeader){
        UICollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
        NSArray *weekArray = @[@"日",@"一",@"二",@"三",@"四",@"五",@"六"];
        for (int i = 0; i < 7; i ++) {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake((collectionView.frame.size.width)/7*i, 0, collectionView.frame.size.width/7, 30)];
            if (i != 0 && i != 6){
                label.backgroundColor = [UIColor redColor];
            }else{
                label.backgroundColor = [UIColor purpleColor];
            }
            label.text = weekArray[i];
            label.textAlignment = NSTextAlignmentCenter;
            label.layer.borderWidth = 1;
            label.layer.borderColor = [UIColor grayColor].CGColor;
            label.font = [UIFont boldSystemFontOfSize:15.0f];
            label.textColor = [UIColor whiteColor];
            [header addSubview:label];
        }
        return header;
    }
    return nil;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(collectionView.frame.size.width, 30);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDate *currentDate = [NSDate date];
    CutomDataModel *obj = self.dataArray[indexPath.row];
    NSLog(@"%@",obj.dateTitle);
    if (!((obj.dateTitle.integerValue == [currentDate getDay]) && obj.isCurrentMoth)){
        return;
    }
    [self.dictionary setObject:@"24" forKey:@"24"];
    [self.currentCollectionView reloadData];
}

@end
