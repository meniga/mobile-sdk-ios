

//
//  MNFValueTransformerTests.m
//  Meniga-ios-sdk
//
//  Created by Mathieu Grettir Skulason on 3/13/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSDateUtils.h"
#import "MNFBasicDateValueTransformer.h"

@interface MNFDateValueTransformerTests : XCTestCase {
    
    NSString *_dateFormatOne;
    NSString *_dateFormatTwo;
    NSString *_dateFormatThree;
    NSString *_dateFormatFour;
    
    NSDateFormatter *_dateFormatter;
    
}

@end



@implementation MNFDateValueTransformerTests

- (void)setUp {
    [super setUp];
    
    // Put setup code here. This method is called before the invocation of each test method in the class.
    _dateFormatOne = @"yyyy-MM-dd'T'HH':'mm':'ss";
    _dateFormatTwo = @"yyyy-MM-dd'T'HH':'mm':'ss'.'S";
    _dateFormatThree = @"yyyy-MM-dd'T'HH':'mm':'ss'.'SS";
    _dateFormatFour = @"yyyy-MM-dd'T'HH':'mm':'ss'.'SSS";
    
    _dateFormatter = [[NSDateFormatter alloc] init];
    
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

#pragma mark - Date Format Tests

-(void)testDateWithSecondAccuracy {
    
    NSString *dateString = @"2016-03-08T13:27:02";
    
    [_dateFormatter setDateFormat:_dateFormatOne];
    NSDate *dateFormatOne = [_dateFormatter dateFromString:dateString];
    XCTAssertNotNil(dateFormatOne);
    
    [_dateFormatter setDateFormat:_dateFormatTwo];
    NSDate *dateFormatTwo = [_dateFormatter dateFromString:dateString];
    XCTAssertNil(dateFormatTwo);
    
    
    [_dateFormatter setDateFormat:_dateFormatThree];
    NSDate *dateFormatThree = [_dateFormatter dateFromString:dateString];
    XCTAssertNil(dateFormatThree);

    
    [_dateFormatter setDateFormat:_dateFormatFour];
    NSDate *dateFormatFour = [_dateFormatter dateFromString:dateString];
    XCTAssertNil(dateFormatFour);
    
    
}

-(void)testDateTwoPointMillisecondAccuracy {
    
    NSString *dateString = @"2016-03-08T13:27:02.85";
    
    [_dateFormatter setDateFormat:_dateFormatOne];
    
    NSDate *dateFormatOne = [_dateFormatter dateFromString:dateString];
    XCTAssertNil(dateFormatOne);
    
    [_dateFormatter setDateFormat:_dateFormatTwo];
    
    NSDate *dateFormatTwo = [_dateFormatter dateFromString:dateString];
    XCTAssertNotNil(dateFormatTwo);
    
    NSDateComponents *dateComponentsTwo = [NSDateUtils allComponentsFromDate:dateFormatTwo];
    XCTAssertTrue(dateComponentsTwo.year == 2016);
    XCTAssertTrue(dateComponentsTwo.month == 3);
    XCTAssertTrue(dateComponentsTwo.day == 8);
    XCTAssertTrue(dateComponentsTwo.hour == 13);
    XCTAssertTrue(dateComponentsTwo.minute == 27);
    XCTAssertTrue(dateComponentsTwo.second == 2);
    XCTAssertTrue(dateComponentsTwo.nanosecond == 849999904);
    
    [_dateFormatter setDateFormat:_dateFormatThree];
    
   [_dateFormatter setDateFormat:_dateFormatThree];
    NSDate *dateFormatThree = [_dateFormatter dateFromString:dateString];
    XCTAssertNotNil(dateFormatThree);
    
    NSDateComponents *dateComponentsThree = [NSDateUtils allComponentsFromDate:dateFormatThree];
    XCTAssertTrue(dateComponentsThree.year == 2016);
    XCTAssertTrue(dateComponentsThree.month == 3);
    XCTAssertTrue(dateComponentsThree.day == 8);
    XCTAssertTrue(dateComponentsThree.hour == 13);
    XCTAssertTrue(dateComponentsThree.minute == 27);
    XCTAssertTrue(dateComponentsThree.second == 2);
    XCTAssertTrue(dateComponentsThree.nanosecond = 849999904);
    
    
    [_dateFormatter setDateFormat:_dateFormatFour];
    NSDate *dateFormatFour = [_dateFormatter dateFromString:dateString];
    XCTAssertNotNil(dateFormatFour);
    
    NSDateComponents *dateComponentsFour = [NSDateUtils allComponentsFromDate:dateFormatFour];
    XCTAssertTrue(dateComponentsFour.year == 2016);
    XCTAssertTrue(dateComponentsFour.month == 3);
    XCTAssertTrue(dateComponentsFour.day == 8);
    XCTAssertTrue(dateComponentsFour.hour == 13);
    XCTAssertTrue(dateComponentsFour.minute == 27);
    XCTAssertTrue(dateComponentsFour.second == 02);
    XCTAssertTrue(dateComponentsFour.nanosecond = 849999904);
}

-(void)testDateThreePointMillisecondAccuracy {
    
    NSString *dateString = @"2016-03-08T13:27:02.817";
    
    [_dateFormatter setDateFormat:_dateFormatOne];
    
    NSDate *dateFormatOne = [_dateFormatter dateFromString:dateString];
    XCTAssertNil(dateFormatOne);
    
    [_dateFormatter setDateFormat:_dateFormatTwo];
    
    NSDate *dateFormatTwo = [_dateFormatter dateFromString:dateString];
    XCTAssertNotNil(dateFormatTwo);
    
    NSDateComponents *dateComponentsTwo = [NSDateUtils allComponentsFromDate:dateFormatTwo];
    XCTAssertTrue(dateComponentsTwo.year == 2016);
    XCTAssertTrue(dateComponentsTwo.month == 3);
    XCTAssertTrue(dateComponentsTwo.day == 8);
    XCTAssertTrue(dateComponentsTwo.hour == 13);
    XCTAssertTrue(dateComponentsTwo.minute == 27);
    XCTAssertTrue(dateComponentsTwo.second == 2);
    XCTAssertTrue(dateComponentsTwo.nanosecond == 816999912);
    
    [_dateFormatter setDateFormat:_dateFormatThree];
    
    [_dateFormatter setDateFormat:_dateFormatThree];
    NSDate *dateFormatThree = [_dateFormatter dateFromString:dateString];
    XCTAssertNotNil(dateFormatThree);
    
    NSDateComponents *dateComponentsThree = [NSDateUtils allComponentsFromDate:dateFormatThree];
    XCTAssertTrue(dateComponentsThree.year == 2016);
    XCTAssertTrue(dateComponentsThree.month == 3);
    XCTAssertTrue(dateComponentsThree.day == 8);
    XCTAssertTrue(dateComponentsThree.hour == 13);
    XCTAssertTrue(dateComponentsThree.minute == 27);
    XCTAssertTrue(dateComponentsThree.second == 2);
    XCTAssertTrue(dateComponentsThree.nanosecond = 816999912);
    
    
    [_dateFormatter setDateFormat:_dateFormatFour];
    NSDate *dateFormatFour = [_dateFormatter dateFromString:dateString];
    XCTAssertNotNil(dateFormatFour);
    
    NSDateComponents *dateComponentsFour = [NSDateUtils allComponentsFromDate:dateFormatFour];
    XCTAssertTrue(dateComponentsFour.year == 2016);
    XCTAssertTrue(dateComponentsFour.month == 3);
    XCTAssertTrue(dateComponentsFour.day == 8);
    XCTAssertTrue(dateComponentsFour.hour == 13);
    XCTAssertTrue(dateComponentsFour.minute == 27);
    XCTAssertTrue(dateComponentsFour.second == 02);
    XCTAssertTrue(dateComponentsFour.nanosecond = 816999912);

}

-(void)testDateOnePointMillisecondAccuracy {
    
    NSString *dateString = @"2016-03-08T13:27:02.8";
    
    [_dateFormatter setDateFormat:_dateFormatOne];
    
    NSDate *dateFormatOne = [_dateFormatter dateFromString:dateString];
    XCTAssertNil(dateFormatOne);
    
    [_dateFormatter setDateFormat:_dateFormatTwo];
    
    NSDate *dateFormatTwo = [_dateFormatter dateFromString:dateString];
    XCTAssertNotNil(dateFormatTwo);
    
    NSDateComponents *dateComponentsTwo = [NSDateUtils allComponentsFromDate:dateFormatTwo];
    XCTAssertTrue(dateComponentsTwo.year == 2016);
    XCTAssertTrue(dateComponentsTwo.month == 3);
    XCTAssertTrue(dateComponentsTwo.day == 8);
    XCTAssertTrue(dateComponentsTwo.hour == 13);
    XCTAssertTrue(dateComponentsTwo.minute == 27);
    XCTAssertTrue(dateComponentsTwo.second == 2);
    XCTAssertTrue(dateComponentsTwo.nanosecond == 799999952);
    
    [_dateFormatter setDateFormat:_dateFormatThree];
    
    [_dateFormatter setDateFormat:_dateFormatThree];
    NSDate *dateFormatThree = [_dateFormatter dateFromString:dateString];
    XCTAssertNotNil(dateFormatThree);
    NSDateComponents *dateComponentsThree = [NSDateUtils allComponentsFromDate:dateFormatThree];
    XCTAssertTrue(dateComponentsThree.year == 2016);
    XCTAssertTrue(dateComponentsThree.month == 3);
    XCTAssertTrue(dateComponentsThree.day == 8);
    XCTAssertTrue(dateComponentsThree.hour == 13);
    XCTAssertTrue(dateComponentsThree.minute == 27);
    XCTAssertTrue(dateComponentsThree.second == 2);
    XCTAssertTrue(dateComponentsThree.nanosecond = 799999952);
    
    
    [_dateFormatter setDateFormat:_dateFormatFour];
    NSDate *dateFormatFour = [_dateFormatter dateFromString:dateString];
    XCTAssertNotNil(dateFormatFour);
    
    NSDateComponents *dateComponentsFour = [NSDateUtils allComponentsFromDate:dateFormatFour];
    XCTAssertTrue(dateComponentsFour.year == 2016);
    XCTAssertTrue(dateComponentsFour.month == 3);
    XCTAssertTrue(dateComponentsFour.day == 8);
    XCTAssertTrue(dateComponentsFour.hour == 13);
    XCTAssertTrue(dateComponentsFour.minute == 27);
    XCTAssertTrue(dateComponentsFour.second == 02);
    XCTAssertTrue(dateComponentsFour.nanosecond = 799999952);
    
}

-(void)testDateFour {
    
    NSString *dateString = @"2016-03-08T13:27:02.8888";
    
    [_dateFormatter setDateFormat:_dateFormatOne];
    
    NSDate *dateFormatOne = [_dateFormatter dateFromString:dateString];
    XCTAssertNil(dateFormatOne);
    
    [_dateFormatter setDateFormat:_dateFormatTwo];
    
    NSDate *dateFormatTwo = [_dateFormatter dateFromString:dateString];
    XCTAssertNotNil(dateFormatTwo);
    
    NSDateComponents *dateComponentsTwo = [NSDateUtils allComponentsFromDate:dateFormatTwo];
    XCTAssertTrue(dateComponentsTwo.year == 2016);
    XCTAssertTrue(dateComponentsTwo.month == 3);
    XCTAssertTrue(dateComponentsTwo.day == 8);
    XCTAssertTrue(dateComponentsTwo.hour == 13);
    XCTAssertTrue(dateComponentsTwo.minute == 27);
    XCTAssertTrue(dateComponentsTwo.second == 2);
    XCTAssertTrue(dateComponentsTwo.nanosecond == 888000011);
    
    [_dateFormatter setDateFormat:_dateFormatThree];
    
    [_dateFormatter setDateFormat:_dateFormatThree];
    NSDate *dateFormatThree = [_dateFormatter dateFromString:dateString];
    XCTAssertNotNil(dateFormatThree);
    
    NSDateComponents *dateComponentsThree = [NSDateUtils allComponentsFromDate:dateFormatThree];
    XCTAssertTrue(dateComponentsThree.year == 2016);
    XCTAssertTrue(dateComponentsThree.month == 3);
    XCTAssertTrue(dateComponentsThree.day == 8);
    XCTAssertTrue(dateComponentsThree.hour == 13);
    XCTAssertTrue(dateComponentsThree.minute == 27);
    XCTAssertTrue(dateComponentsThree.second == 2);
    XCTAssertTrue(dateComponentsThree.nanosecond = 888000011);
    
    
    [_dateFormatter setDateFormat:_dateFormatFour];
    NSDate *dateFormatFour = [_dateFormatter dateFromString:dateString];
    XCTAssertNotNil(dateFormatFour);
    
    NSDateComponents *dateComponentsFour = [NSDateUtils allComponentsFromDate:dateFormatFour];
    XCTAssertTrue(dateComponentsFour.year == 2016);
    XCTAssertTrue(dateComponentsFour.month == 3);
    XCTAssertTrue(dateComponentsFour.day == 8);
    XCTAssertTrue(dateComponentsFour.hour == 13);
    XCTAssertTrue(dateComponentsFour.minute == 27);
    XCTAssertTrue(dateComponentsFour.second == 2);
    XCTAssertTrue(dateComponentsFour.nanosecond = 888000011);
}

#pragma mark - Value Transformer tests

-(void)testBasicDefaultValueTransformerToDateWithSecondAccuracy {
    MNFBasicDateValueTransformer *dateValueTransformer = [MNFBasicDateValueTransformer transformer];
    
    NSString *dateStringOne = @"2016-03-08T13:27:02";
    
    NSDate *dateOneFromTransformer = [dateValueTransformer transformedValue:dateStringOne];
    XCTAssertNotNil(dateOneFromTransformer);
    
    
    NSDateComponents *dateComponents = [NSDateUtils allComponentsFromDate:dateOneFromTransformer];
    
    XCTAssertTrue(dateComponents.year == 2016);
    XCTAssertTrue(dateComponents.month == 3);
    XCTAssertTrue(dateComponents.day == 8);
    XCTAssertTrue(dateComponents.hour == 13);
    XCTAssertTrue(dateComponents.minute == 27);
    XCTAssertTrue(dateComponents.second = 2);
    XCTAssertTrue(dateComponents.nanosecond == 0);
}

-(void)testBasicDefaultValueTransformerToDateWithOnePointMillisecondAccuracy {
    
    MNFBasicDateValueTransformer *dateValueTransformer = [MNFBasicDateValueTransformer transformer];
    
    NSString *dateStringOne = @"2016-03-08T13:27:02.8";
    
    NSDate *dateOneFromTransformer = [dateValueTransformer transformedValue:dateStringOne];
    XCTAssertNotNil(dateOneFromTransformer);
    
    
    NSDateComponents *dateComponents = [NSDateUtils allComponentsFromDate:dateOneFromTransformer];

    XCTAssertTrue(dateComponents.year == 2016);
    XCTAssertTrue(dateComponents.month == 3);
    XCTAssertTrue(dateComponents.day == 8);
    XCTAssertTrue(dateComponents.hour == 13);
    XCTAssertTrue(dateComponents.minute == 27);
    XCTAssertTrue(dateComponents.second = 2);
//    NSLog(@"Nanoseconds: %ld",dateComponents.nanosecond);
    XCTAssertTrue(dateComponents.nanosecond/100000000 == 8);
//    XCTAssertTrue(dateComponents.nanosecond == 799999952);
    
}

-(void)testBasicDefaultValueTransformerToDateWithTwoPointMillisecondAccuracy {
    
    MNFBasicDateValueTransformer *dateValueTransformer = [MNFBasicDateValueTransformer transformer];
    
    NSString *dateStringOne = @"2016-03-08T13:27:02.34";
    
    NSDate *dateOneFromTransformer = [dateValueTransformer transformedValue:dateStringOne];
    XCTAssertNotNil(dateOneFromTransformer);
    
    
    NSDateComponents *dateComponents = [NSDateUtils allComponentsFromDate:dateOneFromTransformer];

    XCTAssertTrue(dateComponents.year == 2016);
    XCTAssertTrue(dateComponents.month == 3);
    XCTAssertTrue(dateComponents.day == 8);
    XCTAssertTrue(dateComponents.hour == 13);
    XCTAssertTrue(dateComponents.minute == 27);
    XCTAssertTrue(dateComponents.second = 2);
    XCTAssertTrue(dateComponents.nanosecond/10000000 == 33);
//    XCTAssertTrue(dateComponents.nanosecond == 339999914);
    
}

-(void)testBasicDefaultValueTransformerToDateWithThreePointMillisecondAccuracy {
    MNFBasicDateValueTransformer *dateValueTransformer = [MNFBasicDateValueTransformer transformer];
    
    NSString *dateStringOne = @"2016-03-08T13:27:02.347";
    
    NSDate *dateOneFromTransformer = [dateValueTransformer transformedValue:dateStringOne];
    XCTAssertNotNil(dateOneFromTransformer);
    
    
    NSDateComponents *dateComponents = [NSDateUtils allComponentsFromDate:dateOneFromTransformer];

    XCTAssertTrue(dateComponents.year == 2016);
    XCTAssertTrue(dateComponents.month == 3);
    XCTAssertTrue(dateComponents.day == 8);
    XCTAssertTrue(dateComponents.hour == 13);
    XCTAssertTrue(dateComponents.minute == 27);
    XCTAssertTrue(dateComponents.second = 2);
    XCTAssertTrue(dateComponents.nanosecond/1000000 == 347);
//    XCTAssertTrue(dateComponents.nanosecond == 346999883);
}


@end
