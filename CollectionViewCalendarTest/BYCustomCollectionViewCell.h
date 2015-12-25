//
//  BYCustomCollectionViewCell.h
//  CollectionViewCalendarTest
//
//  Created by xzh on 15/12/24.
//  Copyright © 2015年 BY-R. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CutomDataModel : NSObject

@property (nonatomic, strong)NSString   *dateTitle;
@property (nonatomic, assign)BOOL       isCurrentMoth;

@end

@interface BYCustomCollectionViewCell : UICollectionViewCell
@property (nonatomic, assign)int    currentWeekDay;
@property (nonatomic, strong)CutomDataModel *object;
@property (nonatomic, strong)NSIndexPath    *indexPath;
- (BOOL)setContentModel:(CutomDataModel *)obj;
- (void)setValueWithDictionary:(NSDictionary *)dict;
@end
