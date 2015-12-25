//
//  BYCustomCollectionViewCell.m
//  CollectionViewCalendarTest
//
//  Created by xzh on 15/12/24.
//  Copyright © 2015年 BY-R. All rights reserved.
//

#import "BYCustomCollectionViewCell.h"

@interface BYCustomCollectionViewCell ()

@property (nonatomic, strong)UILabel    *titleLabel;
@property (nonatomic, strong)UIImageView    *checkImageView;
@property (nonatomic, strong)UIImageView    *topImageView;
@property (nonatomic, strong)UILabel        *priceLabel;
@property (nonatomic, strong)UIImageView    *checkV;

@end

@implementation BYCustomCollectionViewCell

- (id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]){
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.adjustsFontSizeToFitWidth = YES;
        _titleLabel.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
        
        _checkImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        
        _checkV = [[UIImageView alloc] initWithFrame:CGRectZero];
        _checkV.image = [UIImage imageNamed:@"qiandao2_013.png"];
        _checkV.hidden = YES;
        
        _priceLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _priceLabel.textColor = [UIColor whiteColor];
        _priceLabel.backgroundColor = [UIColor redColor];
        _priceLabel.textAlignment = NSTextAlignmentCenter;
        _priceLabel.adjustsFontSizeToFitWidth = YES;
        _priceLabel.hidden = YES;
        
        _topImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        
        [_checkImageView addSubview:_checkV];
        [_checkImageView addSubview:_priceLabel];
        [self.contentView addSubview:_titleLabel];
        [self.contentView addSubview:_checkImageView];
        [self.contentView addSubview:_topImageView];
        
        self.backgroundColor = [UIColor colorWithRed:255/255.0 green:212/255.0 blue:208/255.0 alpha:1];
    }
    return self;
}

- (void)layoutSubviews{
    CGFloat margin = 2;
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    CGFloat tw = (width - margin*2)/2;
    _titleLabel.frame = CGRectMake(margin, 0, tw, tw);
    _topImageView.frame = CGRectMake(CGRectGetMaxX(_titleLabel.frame), 0, tw, tw);
    _checkImageView.frame = CGRectMake(margin, CGRectGetMaxY(_titleLabel.frame), width-margin*2, height-tw);
    _priceLabel.frame = CGRectMake(0, 0, _checkImageView.bounds.size.width, _checkImageView.bounds.size.height);
    _checkV.frame = CGRectMake(_checkImageView.frame.size.width/2-24.5/2.0, _checkImageView.frame.size.height/2.0-23.0/2.0, 25.50, 23.0);
    [super layoutSubviews];
}

- (void)setIndexPath:(NSIndexPath *)indexPath{
    _indexPath = indexPath;
}

- (BOOL)setContentModel:(CutomDataModel *)obj{
    if (!obj)
        return NO;
    self.object = obj;
    _titleLabel.text = obj.dateTitle;
    if (obj.isCurrentMoth){
        _titleLabel.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
    }else{
        _titleLabel.textColor = [UIColor lightGrayColor];
    }
    
    return YES;
}

- (void)setValueWithDictionary:(NSDictionary *)dict{
    if (!dict)
        return;
    if ([dict[@(self.indexPath.row+1-self.currentWeekDay).stringValue] isKindOfClass:[NSDictionary class]] && self.object.isCurrentMoth){
        NSDictionary *dictionary = dict[@(self.indexPath.row+1-self.currentWeekDay).stringValue];
        if (dictionary){
            NSNumber *signCouponMoney = dictionary[@"signCouponMoney"];
            if (signCouponMoney.doubleValue>0){
                _checkV.hidden = YES;
                _priceLabel.hidden = NO;
                _priceLabel.text = [NSString stringWithFormat:@"￥%@",signCouponMoney.stringValue];
                _topImageView.image = [UIImage imageNamed:@"qiandao2_10.png"];
            }else{
                _priceLabel.hidden = YES;
                _checkV.hidden = NO;
                _topImageView.image = nil;
            }
        }
    }else{
        if ([dict[@(self.indexPath.row+1-self.currentWeekDay).stringValue] isEqualToString:self.object.dateTitle] && self.object.isCurrentMoth){
            _priceLabel.hidden = YES;
            _checkV.hidden = NO;
            _topImageView.image = nil;
        }else{
            _checkV.hidden = YES;
            _priceLabel.hidden = YES;
            _topImageView.image = nil;
        }
    }
}

@end

@implementation CutomDataModel


@end
