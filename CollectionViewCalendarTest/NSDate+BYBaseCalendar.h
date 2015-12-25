//
//  NSDate+BYBaseCalendar.h
//  BYCalendarPickerTest
//
//  Created by xzh on 15/12/22.
//  Copyright © 2015年 BY-R. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (BYBaseCalendar)
/*!
 *  获取当月天数
 */
- (NSUInteger)BYBaseNumberOfDaysInCurrentMonth;
/*!
 *  获取本月第一天
 */
- (NSDate *)BYBaseFirstDayOfCurrentMonth;
/*!
 *  确定某天是周几
 */
- (int)BYBaseWeekly;
/*!
 *  年月日 时分秒
 */
- (int)getYear;
- (int)getMonth;
- (int)getDay;
- (int)getHour;
- (int)getMinute;
- (int)getSecond;


@end
