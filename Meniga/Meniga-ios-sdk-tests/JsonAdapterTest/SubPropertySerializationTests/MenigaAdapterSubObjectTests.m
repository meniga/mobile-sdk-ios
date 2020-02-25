//
//  MenigaAdapterSubObjectTests.m
//  Meniga-ios-sdk
//
//  Created by Mathieu Grettir Skulason on 3/23/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MNFJsonAdapter.h"

#import "MNFAdapterMainFirstUppercaseTestObj.h"
#import "MNFAdapterMainTestObject.h"
#import "MNFAdapterMainUppercaseTestObject.h"
#import "MNFAdapterSubFirstUppercaseTestObject.h"
#import "MNFAdapterSubTestObject.h"
#import "MNFAdapterSubUppercaseTestObject.h"

#import "MNFAdapterSubDelegateFirstUppercaseTestObj.h"
#import "MNFAdapterSubDelegateUppercaseTestObj.h"
#import "MNFAdapterSubTestDelegateObj.h"
#import "MNFMainAdapterDelegateFirstUppercaseTestObj.h"
#import "MNFMainAdapterDelegateTestObj.h"
#import "MNFMainAdapterDelegateUppercaseTestObj.h"

// without key mapping delegate
#import "MNFAdapterSubPropertyFirstUppercaseOptionDelegate.h"
#import "MNFAdapterSubPropertyUppercaseOptionDelegate.h"

// with key mapping delegate
#import "MNFAdapterSubPropertyMappingDelegateFirstUppercaseDelegate.h"
#import "MNFAdapterSubPropertyMappingDelegateUppercaseDelegate.h"

@interface MenigaAdapterSubObjectTests : XCTestCase

@end

@implementation MenigaAdapterSubObjectTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

#pragma mark - Serialization

- (void)testSubPropertySerializationNoOption {
    MNFAdapterMainTestObject *mainObject = [MNFAdapterMainTestObject
        adapterMainTestObjectWithTransactionId:@1
                               transactionInfo:@"info"
                                       comment:[MNFAdapterSubTestObject adapterSubTestObjectWithCommentId:@43
                                                                                             commentTitle:@"comment"]
                                   allComments:@[
                                       [MNFAdapterSubTestObject adapterSubTestObjectWithCommentId:@32
                                                                                     commentTitle:@"another comment"],
                                       [MNFAdapterSubTestObject
                                           adapterSubTestObjectWithCommentId:@18
                                                                commentTitle:@"yet another comment"]
                                   ]];

    NSDictionary *dict = [MNFJsonAdapter JSONDictFromObject:mainObject option:kMNFAdapterOptionNoOption error:nil];
    XCTAssertTrue(dict.allKeys.count == 4);

    XCTAssertEqualObjects([dict objectForKey:@"transactionId"], @1);
    XCTAssertEqualObjects([dict objectForKey:@"transactionInfo"], @"info");

    NSDictionary *commentDict = @{ @"commentId": @43, @"commentTitle": @"comment" };
    XCTAssertEqualObjects([dict objectForKey:@"comment"], commentDict);

    NSArray *commentsArray = @[
        @{ @"commentId": @32, @"commentTitle": @"another comment" },
        @{ @"commentId": @18, @"commentTitle": @"yet another comment" }
    ];
    XCTAssertEqualObjects([dict objectForKey:@"allComments"], commentsArray);
}

- (void)testSubPropertySerializationFirstLetterLowercaseOption {
    MNFAdapterMainFirstUppercaseTestObj *firstUpp = [MNFAdapterMainFirstUppercaseTestObj
        adapterMainFirstUppercaseTestObjWithTransactionId:@23
                                          transactionInfo:@"A lot of info"
                                                  comment:
                                                      [MNFAdapterSubFirstUppercaseTestObject
                                                          adapterSubFirstUppercaseTestObjWithCommentId:@13
                                                                                          commentTitle:@"cool comment"]
                                              allComments:@[
                                                  [MNFAdapterSubFirstUppercaseTestObject
                                                      adapterSubFirstUppercaseTestObjWithCommentId:@93
                                                                                      commentTitle:@"lax comment"],
                                                  [MNFAdapterSubFirstUppercaseTestObject
                                                      adapterSubFirstUppercaseTestObjWithCommentId:@71
                                                                                      commentTitle:@"worse comment"]
                                              ]];

    NSDictionary *dict = [MNFJsonAdapter JSONDictFromObject:firstUpp
                                                     option:kMNFAdapterOptionFirstLetterLowercase
                                                      error:nil];

    XCTAssertTrue(dict.allKeys.count == 4);

    XCTAssertEqualObjects([dict objectForKey:@"transactionId"], @23);
    XCTAssertEqualObjects([dict objectForKey:@"transactionInfo"], @"A lot of info");

    NSDictionary *commentDict = [dict objectForKey:@"comment"];
    XCTAssertEqualObjects([commentDict objectForKey:@"commentId"], @13);
    XCTAssertEqualObjects([commentDict objectForKey:@"commentTitle"], @"cool comment");

    NSArray *theComments = [dict objectForKey:@"allComments"];
    XCTAssertTrue(theComments.count == 2);

    NSDictionary *firstCommentDict = [theComments objectAtIndex:0];
    XCTAssertEqualObjects([firstCommentDict objectForKey:@"commentId"], @93);
    XCTAssertEqualObjects([firstCommentDict objectForKey:@"commentTitle"], @"lax comment");

    NSDictionary *secondCommentDict = [theComments objectAtIndex:1];
    XCTAssertEqualObjects([secondCommentDict objectForKey:@"commentId"], @71);
    XCTAssertEqualObjects([secondCommentDict objectForKey:@"commentTitle"], @"worse comment");
}

- (void)testSubPropertySerializationLowercaseOption {
    MNFAdapterMainUppercaseTestObject *uppercaseObj = [MNFAdapterMainUppercaseTestObject
        adapterMainUppercaseTestObjWithTransactionId:@7
                                     transactionInfo:@"too much infooo"
                                             comment:[MNFAdapterSubUppercaseTestObject
                                                         adapterSubUppercaseTestObjectWithCommentId:@64
                                                                                       commentTitle:@"a comment title"]
                                         allComments:@[
                                             [MNFAdapterSubUppercaseTestObject
                                                 adapterSubUppercaseTestObjectWithCommentId:@56
                                                                               commentTitle:@"a title"],
                                             [MNFAdapterSubUppercaseTestObject
                                                 adapterSubUppercaseTestObjectWithCommentId:@47
                                                                               commentTitle:@"cool title"]
                                         ]];

    NSDictionary *dict = [MNFJsonAdapter JSONDictFromObject:uppercaseObj option:kMNFAdapterOptionLowercase error:nil];

    XCTAssertTrue(dict.allKeys.count == 4);

    XCTAssertEqualObjects([dict objectForKey:@"transactionid"], @7);
    XCTAssertEqualObjects([dict objectForKey:@"transactioninfo"], @"too much infooo");

    NSDictionary *commentDict = [dict objectForKey:@"comment"];
    XCTAssertEqualObjects([commentDict objectForKey:@"commentid"], @64);
    XCTAssertEqualObjects([commentDict objectForKey:@"commenttitle"], @"a comment title");

    NSArray *theComments = [dict objectForKey:@"allcomments"];
    XCTAssertTrue(theComments.count == 2);

    NSDictionary *firstComment = [theComments objectAtIndex:0];
    XCTAssertEqualObjects([firstComment objectForKey:@"commentid"], @56);
    XCTAssertEqualObjects([firstComment objectForKey:@"commenttitle"], @"a title");

    NSDictionary *secondComment = [theComments objectAtIndex:1];
    XCTAssertEqualObjects([secondComment objectForKey:@"commentid"], @47);
    XCTAssertEqualObjects([secondComment objectForKey:@"commenttitle"], @"cool title");
}

- (void)testSubPropertySerializationFirstUppercaseOptionDelegateMapping {
    MNFAdapterMainTestObject *mainObject = [MNFAdapterMainTestObject
        adapterMainTestObjectWithTransactionId:@1
                               transactionInfo:@"info"
                                       comment:[MNFAdapterSubTestObject adapterSubTestObjectWithCommentId:@43
                                                                                             commentTitle:@"comment"]
                                   allComments:@[
                                       [MNFAdapterSubTestObject adapterSubTestObjectWithCommentId:@32
                                                                                     commentTitle:@"another comment"],
                                       [MNFAdapterSubTestObject
                                           adapterSubTestObjectWithCommentId:@18
                                                                commentTitle:@"yet another comment"]
                                   ]];

    NSDictionary *dict =
        [MNFJsonAdapter JSONDictFromObject:mainObject
                                  delegate:[[MNFAdapterSubPropertyFirstUppercaseOptionDelegate alloc] init]
                                    option:kMNFAdapterOptionFirstLetterUppercase
                                     error:nil];
    XCTAssertTrue(dict.allKeys.count == 4);

    XCTAssertEqualObjects([dict objectForKey:@"TransactionId"], @1);
    XCTAssertEqualObjects([dict objectForKey:@"TransactionInfo"], @"info");

    NSDictionary *commentDict = @{ @"CommentId": @43, @"CommentTitle": @"comment" };
    XCTAssertEqualObjects([dict objectForKey:@"Comment"], commentDict);

    NSArray *commentsArray = @[
        @{ @"CommentId": @32, @"CommentTitle": @"another comment" },
        @{ @"CommentId": @18, @"CommentTitle": @"yet another comment" }
    ];
    XCTAssertEqualObjects([dict objectForKey:@"AllComments"], commentsArray);
}

- (void)testSubPropertySerializationUppercaseOptionDelegateMapping {
    MNFAdapterMainTestObject *mainObject = [MNFAdapterMainTestObject
        adapterMainTestObjectWithTransactionId:@1
                               transactionInfo:@"info"
                                       comment:[MNFAdapterSubTestObject adapterSubTestObjectWithCommentId:@43
                                                                                             commentTitle:@"comment"]
                                   allComments:@[
                                       [MNFAdapterSubTestObject adapterSubTestObjectWithCommentId:@32
                                                                                     commentTitle:@"another comment"],
                                       [MNFAdapterSubTestObject
                                           adapterSubTestObjectWithCommentId:@18
                                                                commentTitle:@"yet another comment"]
                                   ]];

    NSDictionary *dict = [MNFJsonAdapter JSONDictFromObject:mainObject
                                                   delegate:[[MNFAdapterSubPropertyUppercaseOptionDelegate alloc] init]
                                                     option:kMNFAdapterOptionUppercase
                                                      error:nil];
    XCTAssertTrue(dict.allKeys.count == 4);

    XCTAssertEqualObjects([dict objectForKey:@"TRANSACTIONID"], @1);
    XCTAssertEqualObjects([dict objectForKey:@"TRANSACTIONINFO"], @"info");

    NSDictionary *commentDict = @{ @"COMMENTID": @43, @"COMMENTTITLE": @"comment" };
    XCTAssertEqualObjects([dict objectForKey:@"COMMENT"], commentDict);

    NSArray *commentsArray = @[
        @{ @"COMMENTID": @32, @"COMMENTTITLE": @"another comment" },
        @{ @"COMMENTID": @18, @"COMMENTTITLE": @"yet another comment" }
    ];
    XCTAssertEqualObjects([dict objectForKey:@"ALLCOMMENTS"], commentsArray);
}

#pragma mark - Serialization delegate

- (void)testSubPropertySerializationDelegateNoOption {
    MNFMainAdapterDelegateTestObj *delegateObj = [MNFMainAdapterDelegateTestObj
        adapterDelegateTestObjWithTransactionId:@9
                                transactionInfo:@"disgusting info"
                                        comment:[MNFAdapterSubTestDelegateObj
                                                    adapterSubTestDelegateObjWithCommentId:@18
                                                                              commentTitle:@"the comment title"]
                                    allComments:@[
                                        [MNFAdapterSubTestDelegateObj
                                            adapterSubTestDelegateObjWithCommentId:@40
                                                                      commentTitle:@"sub test object one"],
                                        [MNFAdapterSubTestDelegateObj
                                            adapterSubTestDelegateObjWithCommentId:@107
                                                                      commentTitle:@"sub test object two"]
                                    ]];

    NSDictionary *dict = [MNFJsonAdapter JSONDictFromObject:delegateObj option:kMNFAdapterOptionNoOption error:nil];

    XCTAssertTrue(dict.allKeys.count == 4);

    XCTAssertEqualObjects([dict objectForKey:@"transactionId"], @9);
    XCTAssertEqualObjects([dict objectForKey:@"transactionInfo"], @"disgusting info");

    NSDictionary *commentDict = [dict objectForKey:@"comment"];
    XCTAssertEqualObjects([commentDict objectForKey:@"commentId"], @18);
    XCTAssertEqualObjects([commentDict objectForKey:@"commentTitle"], @"the comment title");

    NSArray *allComments = [dict objectForKey:@"allComments"];
    XCTAssertTrue(allComments.count == 2);

    NSDictionary *firstComment = [allComments objectAtIndex:0];
    XCTAssertEqualObjects([firstComment objectForKey:@"commentId"], @40);
    XCTAssertEqualObjects([firstComment objectForKey:@"commentTitle"], @"sub test object one");

    NSDictionary *secondComment = [allComments objectAtIndex:1];
    XCTAssertEqualObjects([secondComment objectForKey:@"commentId"], @107);
    XCTAssertEqualObjects([secondComment objectForKey:@"commentTitle"], @"sub test object two");
}

- (void)testSubPropertySerializationDelegateFirstLowercaseOption {
    MNFMainAdapterDelegateFirstUppercaseTestObj *delegateObj = [MNFMainAdapterDelegateFirstUppercaseTestObj
        adapterDelegateFirstUppercaseTestObjWithTransactionId:@56
                                              transactionInfo:@"Chuck norris!"
                                                      comment:
                                                          [MNFAdapterSubDelegateFirstUppercaseTestObj
                                                              adapterSubDelegateFirstUppercaseTestObjWithCommentId:@234
                                                                                                      commentTitle:
                                                                                                          @"chuck "
                                                                                                          @"norris "
                                                                                                          @"rules"]
                                                  allComments:@[
                                                      [MNFAdapterSubDelegateFirstUppercaseTestObj
                                                          adapterSubDelegateFirstUppercaseTestObjWithCommentId:@1123
                                                                                                  commentTitle:
                                                                                                      @"Chuck Norris "
                                                                                                      @"eats desks"],
                                                      [MNFAdapterSubDelegateFirstUppercaseTestObj
                                                          adapterSubDelegateFirstUppercaseTestObjWithCommentId:@932
                                                                                                  commentTitle:
                                                                                                      @"Chuck Norris "
                                                                                                      @"has his own "
                                                                                                      @"gravity "
                                                                                                      @"field"]
                                                  ]];

    NSDictionary *dict = [MNFJsonAdapter JSONDictFromObject:delegateObj
                                                     option:kMNFAdapterOptionFirstLetterLowercase
                                                      error:nil];

    XCTAssertTrue(dict.allKeys.count == 4);

    XCTAssertEqualObjects([dict objectForKey:@"transactionId"], @56);
    XCTAssertEqualObjects([dict objectForKey:@"transactionInfo"], @"Chuck norris!");

    NSDictionary *commentDict = [dict objectForKey:@"comment"];
    XCTAssertEqualObjects([commentDict objectForKey:@"commentId"], @234);
    XCTAssertEqualObjects([commentDict objectForKey:@"commentTitle"], @"chuck norris rules");

    NSArray *allComments = [dict objectForKey:@"allComments"];
    XCTAssertTrue(allComments.count == 2);

    NSDictionary *firstComment = [allComments objectAtIndex:0];
    XCTAssertEqualObjects([firstComment objectForKey:@"commentId"], @1123);
    XCTAssertEqualObjects([firstComment objectForKey:@"commentTitle"], @"Chuck Norris eats desks");

    NSDictionary *secondComment = [allComments objectAtIndex:1];
    XCTAssertEqualObjects([secondComment objectForKey:@"commentId"], @932);
    XCTAssertEqualObjects([secondComment objectForKey:@"commentTitle"], @"Chuck Norris has his own gravity field");
}

- (void)testSubPropertySerializationDelegateLowercaseOption {
    MNFMainAdapterDelegateUppercaseTestObj *delegateObj = [MNFMainAdapterDelegateUppercaseTestObj
        adapterDelegateUppercaseTestObjWithTransactionId:@94
                                         transactionInfo:@"Trump running for president"
                                                 comment:[MNFAdapterSubDelegateUppercaseTestObj
                                                             adapterSubDelegateUppercaseTestObjWithCommentId:@84
                                                                                                commentTitle:
                                                                                                    @"he cannot run "
                                                                                                    @"for shit"]
                                             allComments:@[
                                                 [MNFAdapterSubDelegateUppercaseTestObj
                                                     adapterSubDelegateUppercaseTestObjWithCommentId:@678
                                                                                        commentTitle:@"trump it up!"],
                                                 [MNFAdapterSubDelegateUppercaseTestObj
                                                     adapterSubDelegateUppercaseTestObjWithCommentId:@35
                                                                                        commentTitle:
                                                                                            @"trump should definitely "
                                                                                            @"not be president"]
                                             ]];

    NSDictionary *dict = [MNFJsonAdapter JSONDictFromObject:delegateObj option:kMNFAdapterOptionLowercase error:nil];

    XCTAssertTrue(dict.allKeys.count == 4);

    XCTAssertEqualObjects([dict objectForKey:@"transactionid"], @94);
    XCTAssertEqualObjects([dict objectForKey:@"transactioninfo"], @"Trump running for president");

    NSDictionary *commentDict = [dict objectForKey:@"comment"];
    XCTAssertEqualObjects([commentDict objectForKey:@"commentid"], @84);
    XCTAssertEqualObjects([commentDict objectForKey:@"commenttitle"], @"he cannot run for shit");

    NSArray *allComments = [dict objectForKey:@"allcomments"];
    XCTAssertTrue(allComments.count == 2);

    NSDictionary *firstComment = [allComments objectAtIndex:0];
    XCTAssertEqualObjects([firstComment objectForKey:@"commentid"], @678);
    XCTAssertEqualObjects([firstComment objectForKey:@"commenttitle"], @"trump it up!");

    NSDictionary *secondComment = [allComments objectAtIndex:1];
    XCTAssertEqualObjects([secondComment objectForKey:@"commentid"], @35);
    XCTAssertEqualObjects([secondComment objectForKey:@"commenttitle"], @"trump should definitely not be president");
}

- (void)testSubPropertySerializationDelegateFirstUppercaseOptionDelegateMapping {
    MNFMainAdapterDelegateTestObj *delegateObj = [MNFMainAdapterDelegateTestObj
        adapterDelegateTestObjWithTransactionId:@9
                                transactionInfo:@"disgusting info"
                                        comment:[MNFAdapterSubTestDelegateObj
                                                    adapterSubTestDelegateObjWithCommentId:@18
                                                                              commentTitle:@"the comment title"]
                                    allComments:@[
                                        [MNFAdapterSubTestDelegateObj
                                            adapterSubTestDelegateObjWithCommentId:@40
                                                                      commentTitle:@"sub test object one"],
                                        [MNFAdapterSubTestDelegateObj
                                            adapterSubTestDelegateObjWithCommentId:@107
                                                                      commentTitle:@"sub test object two"]
                                    ]];

    NSDictionary *dict =
        [MNFJsonAdapter JSONDictFromObject:delegateObj
                                  delegate:[[MNFAdapterSubPropertyMappingDelegateFirstUppercaseDelegate alloc] init]
                                    option:kMNFAdapterOptionFirstLetterUppercase
                                     error:nil];

    XCTAssertTrue(dict.allKeys.count == 4);

    XCTAssertEqualObjects([dict objectForKey:@"TransactionId"], @9);
    XCTAssertEqualObjects([dict objectForKey:@"TransactionInfo"], @"disgusting info");

    NSDictionary *commentDict = [dict objectForKey:@"Comment"];
    XCTAssertEqualObjects([commentDict objectForKey:@"CommentId"], @18);
    XCTAssertEqualObjects([commentDict objectForKey:@"CommentTitle"], @"the comment title");

    NSArray *allComments = [dict objectForKey:@"AllComments"];
    XCTAssertTrue(allComments.count == 2);

    NSDictionary *firstComment = [allComments objectAtIndex:0];
    XCTAssertEqualObjects([firstComment objectForKey:@"CommentId"], @40);
    XCTAssertEqualObjects([firstComment objectForKey:@"CommentTitle"], @"sub test object one");

    NSDictionary *secondComment = [allComments objectAtIndex:1];
    XCTAssertEqualObjects([secondComment objectForKey:@"CommentId"], @107);
    XCTAssertEqualObjects([secondComment objectForKey:@"CommentTitle"], @"sub test object two");
}

- (void)testSubPropertySerializationDelegateUppercaseOptionDelegateMapping {
    MNFMainAdapterDelegateTestObj *delegateObj = [MNFMainAdapterDelegateTestObj
        adapterDelegateTestObjWithTransactionId:@9
                                transactionInfo:@"disgusting info"
                                        comment:[MNFAdapterSubTestDelegateObj
                                                    adapterSubTestDelegateObjWithCommentId:@18
                                                                              commentTitle:@"the comment title"]
                                    allComments:@[
                                        [MNFAdapterSubTestDelegateObj
                                            adapterSubTestDelegateObjWithCommentId:@40
                                                                      commentTitle:@"sub test object one"],
                                        [MNFAdapterSubTestDelegateObj
                                            adapterSubTestDelegateObjWithCommentId:@107
                                                                      commentTitle:@"sub test object two"]
                                    ]];

    NSDictionary *dict =
        [MNFJsonAdapter JSONDictFromObject:delegateObj
                                  delegate:[[MNFAdapterSubPropertyMappingDelegateUppercaseDelegate alloc] init]
                                    option:kMNFAdapterOptionUppercase
                                     error:nil];

    XCTAssertTrue(dict.allKeys.count == 4);

    XCTAssertEqualObjects([dict objectForKey:@"TRANSACTIONID"], @9);
    XCTAssertEqualObjects([dict objectForKey:@"TRANSACTIONINFO"], @"disgusting info");

    NSDictionary *commentDict = [dict objectForKey:@"COMMENT"];
    XCTAssertEqualObjects([commentDict objectForKey:@"COMMENTID"], @18);
    XCTAssertEqualObjects([commentDict objectForKey:@"COMMENTTITLE"], @"the comment title");

    NSArray *allComments = [dict objectForKey:@"ALLCOMMENTS"];
    XCTAssertTrue(allComments.count == 2);

    NSDictionary *firstComment = [allComments objectAtIndex:0];
    XCTAssertEqualObjects([firstComment objectForKey:@"COMMENTID"], @40);
    XCTAssertEqualObjects([firstComment objectForKey:@"COMMENTTITLE"], @"sub test object one");

    NSDictionary *secondComment = [allComments objectAtIndex:1];
    XCTAssertEqualObjects([secondComment objectForKey:@"COMMENTID"], @107);
    XCTAssertEqualObjects([secondComment objectForKey:@"COMMENTTITLE"], @"sub test object two");
}

#pragma mark - Serialization Separate Delegate

#pragma mark - Deserialization

- (void)testSingleSubPropertyDeserializationNoOption {
    MNFAdapterMainTestObject *mainTestObject = [MNFJsonAdapter objectOfClass:[MNFAdapterMainTestObject class]
                                                                    jsonDict:[self dictForFileName:@"JsonSubObjectTest"
                                                                                            ofType:@"json"]
                                                                      option:kMNFAdapterOptionNoOption
                                                                       error:nil];

    XCTAssertNotNil(mainTestObject);
    XCTAssertNotNil(mainTestObject.comment);

    XCTAssertEqualObjects(mainTestObject.transactionId, @2);
    XCTAssertEqualObjects(mainTestObject.transactionInfo, @"Some info");

    XCTAssertEqualObjects(mainTestObject.comment.commentId, @3);
    XCTAssertEqualObjects(mainTestObject.comment.commentTitle, @"Some title");

    XCTAssertTrue(mainTestObject.allComments.count == 2);

    MNFAdapterSubTestObject *subTestObj = [mainTestObject.allComments objectAtIndex:0];

    XCTAssertEqualObjects(subTestObj.commentId, @5);
    XCTAssertEqualObjects(subTestObj.commentTitle, @"Another title");

    MNFAdapterSubTestObject *subTestObjTwo = [mainTestObject.allComments objectAtIndex:1];

    XCTAssertEqualObjects(subTestObjTwo.commentId, @6);
    XCTAssertEqualObjects(subTestObjTwo.commentTitle, @"Swag title");
}

- (void)testSingleSubPropertyDeserializationFirstLowercaseOption {
    MNFAdapterMainFirstUppercaseTestObj *mainTestObject =
        [MNFJsonAdapter objectOfClass:[MNFAdapterMainFirstUppercaseTestObj class]
                             jsonDict:[self dictForFileName:@"JsonSubObjectTest" ofType:@"json"]
                               option:kMNFAdapterOptionFirstLetterLowercase
                                error:nil];

    XCTAssertNotNil(mainTestObject);
    XCTAssertNotNil(mainTestObject.Comment);
    XCTAssertNotNil(mainTestObject.AllComments);

    XCTAssertEqualObjects(mainTestObject.TransactionId, @2);
    XCTAssertEqualObjects(mainTestObject.TransactionInfo, @"Some info");

    XCTAssertEqualObjects(mainTestObject.Comment.CommentId, @3);
    XCTAssertEqualObjects(mainTestObject.Comment.CommentTitle, @"Some title");

    XCTAssertTrue(mainTestObject.AllComments.count == 2);

    MNFAdapterSubFirstUppercaseTestObject *subTestObj = [mainTestObject.AllComments objectAtIndex:0];

    XCTAssertEqualObjects(subTestObj.CommentId, @5);
    XCTAssertEqualObjects(subTestObj.CommentTitle, @"Another title");

    MNFAdapterSubFirstUppercaseTestObject *subSecondTestObj = [mainTestObject.AllComments objectAtIndex:1];

    XCTAssertEqualObjects(subSecondTestObj.CommentId, @6);
    XCTAssertEqualObjects(subSecondTestObj.CommentTitle, @"Swag title");
}

- (void)testSingleSubPropertyDeserializationLowercaseOption {
    MNFAdapterMainUppercaseTestObject *maintTestObject =
        [MNFJsonAdapter objectOfClass:[MNFAdapterMainUppercaseTestObject class]
                             jsonDict:[self dictForFileName:@"JsonSubObjectLowercaseTest" ofType:@"json"]
                               option:kMNFAdapterOptionLowercase
                                error:nil];

    XCTAssertNotNil(maintTestObject);
    XCTAssertNotNil(maintTestObject.COMMENT);

    XCTAssertEqualObjects(maintTestObject.TRANSACTIONID, @2);
    XCTAssertEqualObjects(maintTestObject.TRANSACTIONINFO, @"Some info");

    XCTAssertEqualObjects(maintTestObject.COMMENT.COMMENTID, @3);
    XCTAssertEqualObjects(maintTestObject.COMMENT.COMMENTTITLE, @"Some title");

    XCTAssertTrue(maintTestObject.ALLCOMMENTS.count == 2);

    MNFAdapterSubUppercaseTestObject *subTestObject = [maintTestObject.ALLCOMMENTS objectAtIndex:0];

    XCTAssertEqualObjects(subTestObject.COMMENTID, @5);
    XCTAssertEqualObjects(subTestObject.COMMENTTITLE, @"Another title");

    MNFAdapterSubUppercaseTestObject *subTestObjectTwo = [maintTestObject.ALLCOMMENTS objectAtIndex:1];

    XCTAssertEqualObjects(subTestObjectTwo.COMMENTID, @6);
    XCTAssertEqualObjects(subTestObjectTwo.COMMENTTITLE, @"Swag title");
}

- (void)testSingleSubPropertyDeserializationFirstUppercaseOptionDelegateMapping {
    MNFAdapterMainTestObject *mainTestObject =
        [MNFJsonAdapter objectOfClass:[MNFAdapterMainTestObject class]
                             delegate:[[MNFAdapterSubPropertyFirstUppercaseOptionDelegate alloc] init]
                             jsonDict:[self dictForFileName:@"JsonSubObjectFirstUppercaseTest" ofType:@"json"]
                               option:kMNFAdapterOptionFirstLetterUppercase
                                error:nil];

    XCTAssertNotNil(mainTestObject);
    XCTAssertNotNil(mainTestObject.comment);

    XCTAssertEqualObjects(mainTestObject.transactionId, @2);
    XCTAssertEqualObjects(mainTestObject.transactionInfo, @"Some info");

    XCTAssertEqualObjects(mainTestObject.comment.commentId, @3);
    XCTAssertEqualObjects(mainTestObject.comment.commentTitle, @"Some title");

    XCTAssertTrue(mainTestObject.allComments.count == 2);

    MNFAdapterSubTestObject *subTestObj = [mainTestObject.allComments objectAtIndex:0];

    XCTAssertEqualObjects(subTestObj.commentId, @5);
    XCTAssertEqualObjects(subTestObj.commentTitle, @"Another title");

    MNFAdapterSubTestObject *subTestObjTwo = [mainTestObject.allComments objectAtIndex:1];

    XCTAssertEqualObjects(subTestObjTwo.commentId, @6);
    XCTAssertEqualObjects(subTestObjTwo.commentTitle, @"Swag title");
}

- (void)testSingleSubPropertyDeserializationUppercaseOptionDelegateMapping {
    MNFAdapterMainTestObject *mainTestObject =
        [MNFJsonAdapter objectOfClass:[MNFAdapterMainTestObject class]
                             delegate:[[MNFAdapterSubPropertyUppercaseOptionDelegate alloc] init]
                             jsonDict:[self dictForFileName:@"JsonSubObjectUppercaseTest" ofType:@"json"]
                               option:kMNFAdapterOptionUppercase
                                error:nil];

    XCTAssertNotNil(mainTestObject);
    XCTAssertNotNil(mainTestObject.comment);

    XCTAssertEqualObjects(mainTestObject.transactionId, @2);
    XCTAssertEqualObjects(mainTestObject.transactionInfo, @"Some info");

    XCTAssertEqualObjects(mainTestObject.comment.commentId, @3);
    XCTAssertEqualObjects(mainTestObject.comment.commentTitle, @"Some title");

    XCTAssertTrue(mainTestObject.allComments.count == 2);

    MNFAdapterSubTestObject *subTestObj = [mainTestObject.allComments objectAtIndex:0];

    XCTAssertEqualObjects(subTestObj.commentId, @5);
    XCTAssertEqualObjects(subTestObj.commentTitle, @"Another title");

    MNFAdapterSubTestObject *subTestObjTwo = [mainTestObject.allComments objectAtIndex:1];

    XCTAssertEqualObjects(subTestObjTwo.commentId, @6);
    XCTAssertEqualObjects(subTestObjTwo.commentTitle, @"Swag title");
}

#pragma mark - Deserialization delegate

- (void)testSubPropertyDeserializationDelegateNoOption {
    MNFMainAdapterDelegateTestObj *delegateObj =
        [MNFJsonAdapter objectOfClass:[MNFMainAdapterDelegateTestObj class]
                             jsonDict:[self dictForFileName:@"JsonSubObjectTest" ofType:@"json"]
                               option:kMNFAdapterOptionNoOption
                                error:nil];

    XCTAssertNotNil(delegateObj);
    XCTAssertNotNil(delegateObj.uglyComment);
    XCTAssertNotNil(delegateObj.allUglyComments);

    XCTAssertEqualObjects(delegateObj.uglyTransactionId, @2);
    XCTAssertEqualObjects(delegateObj.uglyTransactionInfo, @"Some info");

    XCTAssertEqualObjects(delegateObj.uglyComment.uglyCommentId, @3);
    XCTAssertEqualObjects(delegateObj.uglyComment.uglyCommentTitle, @"Some title");

    XCTAssertTrue(delegateObj.allUglyComments.count == 2);

    MNFAdapterSubTestDelegateObj *subTestObj = [delegateObj.allUglyComments objectAtIndex:0];

    XCTAssertEqualObjects(subTestObj.uglyCommentId, @5);
    XCTAssertEqualObjects(subTestObj.uglyCommentTitle, @"Another title");

    MNFAdapterSubTestDelegateObj *subSecondTestObj = [delegateObj.allUglyComments objectAtIndex:1];

    XCTAssertEqualObjects(subSecondTestObj.uglyCommentId, @6);
    XCTAssertEqualObjects(subSecondTestObj.uglyCommentTitle, @"Swag title");
}

- (void)testSubPropertyDeserializationDelegateFirstLowercaseOption {
    MNFMainAdapterDelegateFirstUppercaseTestObj *delegateObj =
        [MNFJsonAdapter objectOfClass:[MNFMainAdapterDelegateFirstUppercaseTestObj class]
                             jsonDict:[self dictForFileName:@"JsonSubObjectTest" ofType:@"json"]
                               option:kMNFAdapterOptionFirstLetterLowercase
                                error:nil];

    XCTAssertNotNil(delegateObj);
    XCTAssertNotNil(delegateObj.UglyComment);
    XCTAssertNotNil(delegateObj.AllUglyComments);

    XCTAssertEqualObjects(delegateObj.UglyTransactionId, @2);
    XCTAssertEqualObjects(delegateObj.UglyTransactionInfo, @"Some info");

    XCTAssertEqualObjects(delegateObj.UglyComment.UglyCommentId, @3);
    XCTAssertEqualObjects(delegateObj.UglyComment.UglyCommentTitle, @"Some title");

    XCTAssertTrue(delegateObj.AllUglyComments.count == 2);

    MNFAdapterSubDelegateFirstUppercaseTestObj *subTestObj = [delegateObj.AllUglyComments objectAtIndex:0];

    XCTAssertEqualObjects(subTestObj.UglyCommentId, @5);
    XCTAssertEqualObjects(subTestObj.UglyCommentTitle, @"Another title");

    MNFAdapterSubDelegateFirstUppercaseTestObj *subSecondTestObj = [delegateObj.AllUglyComments objectAtIndex:1];

    XCTAssertEqualObjects(subSecondTestObj.UglyCommentId, @6);
    XCTAssertEqualObjects(subSecondTestObj.UglyCommentTitle, @"Swag title");
}

- (void)testSubPropertyDeserializationDelegateLowercaseOption {
    MNFMainAdapterDelegateUppercaseTestObj *delegateObj =
        [MNFJsonAdapter objectOfClass:[MNFMainAdapterDelegateUppercaseTestObj class]
                             jsonDict:[self dictForFileName:@"JsonSubObjectLowercaseTest" ofType:@"json"]
                               option:kMNFAdapterOptionLowercase
                                error:nil];

    XCTAssertNotNil(delegateObj);
    XCTAssertNotNil(delegateObj.UGLYCOMMENT);
    XCTAssertNotNil(delegateObj.ALLUGLYCOMMENTS);

    XCTAssertEqualObjects(delegateObj.UGLYTRANSACTIONID, @2);
    XCTAssertEqualObjects(delegateObj.UGLYTRANSACTIONINFO, @"Some info");

    XCTAssertEqualObjects(delegateObj.UGLYCOMMENT.UGLYCOMMENTID, @3);
    XCTAssertEqualObjects(delegateObj.UGLYCOMMENT.UGLYCOMMENTTITLE, @"Some title");

    XCTAssertTrue(delegateObj.ALLUGLYCOMMENTS.count == 2);

    MNFAdapterSubDelegateUppercaseTestObj *subTestObj = [delegateObj.ALLUGLYCOMMENTS objectAtIndex:0];

    XCTAssertEqualObjects(subTestObj.UGLYCOMMENTID, @5);
    XCTAssertEqualObjects(subTestObj.UGLYCOMMENTTITLE, @"Another title");

    MNFAdapterSubDelegateUppercaseTestObj *subSecondTestObj = [delegateObj.ALLUGLYCOMMENTS objectAtIndex:1];

    XCTAssertEqualObjects(subSecondTestObj.UGLYCOMMENTID, @6);
    XCTAssertEqualObjects(subSecondTestObj.UGLYCOMMENTTITLE, @"Swag title");
}

- (void)testSubPropertyDeserializationFirstUppercaseOptionDelegateMapping {
    MNFMainAdapterDelegateTestObj *delegateObj =
        [MNFJsonAdapter objectOfClass:[MNFMainAdapterDelegateTestObj class]
                             delegate:[[MNFAdapterSubPropertyMappingDelegateFirstUppercaseDelegate alloc] init]
                             jsonDict:[self dictForFileName:@"JsonSubObjectFirstUppercaseTest" ofType:@"json"]
                               option:kMNFAdapterOptionFirstLetterUppercase
                                error:nil];

    XCTAssertNotNil(delegateObj);
    XCTAssertNotNil(delegateObj.uglyComment);
    XCTAssertNotNil(delegateObj.allUglyComments);

    XCTAssertEqualObjects(delegateObj.uglyTransactionId, @2);
    XCTAssertEqualObjects(delegateObj.uglyTransactionInfo, @"Some info");

    XCTAssertEqualObjects(delegateObj.uglyComment.uglyCommentId, @3);
    XCTAssertEqualObjects(delegateObj.uglyComment.uglyCommentTitle, @"Some title");

    XCTAssertTrue(delegateObj.allUglyComments.count == 2);

    MNFAdapterSubTestDelegateObj *subTestObj = [delegateObj.allUglyComments objectAtIndex:0];

    XCTAssertEqualObjects(subTestObj.uglyCommentId, @5);
    XCTAssertEqualObjects(subTestObj.uglyCommentTitle, @"Another title");

    MNFAdapterSubTestDelegateObj *subSecondTestObj = [delegateObj.allUglyComments objectAtIndex:1];

    XCTAssertEqualObjects(subSecondTestObj.uglyCommentId, @6);
    XCTAssertEqualObjects(subSecondTestObj.uglyCommentTitle, @"Swag title");
}

- (void)testSubPropertyDeserializationUppercaseOptionDelegateMapping {
    MNFMainAdapterDelegateTestObj *delegateObj =
        [MNFJsonAdapter objectOfClass:[MNFMainAdapterDelegateTestObj class]
                             delegate:[[MNFAdapterSubPropertyMappingDelegateUppercaseDelegate alloc] init]
                             jsonDict:[self dictForFileName:@"JsonSubObjectUppercaseTest" ofType:@"json"]
                               option:kMNFAdapterOptionUppercase
                                error:nil];

    XCTAssertNotNil(delegateObj);
    XCTAssertNotNil(delegateObj.uglyComment);
    XCTAssertNotNil(delegateObj.allUglyComments);

    XCTAssertEqualObjects(delegateObj.uglyTransactionId, @2);
    XCTAssertEqualObjects(delegateObj.uglyTransactionInfo, @"Some info");

    XCTAssertEqualObjects(delegateObj.uglyComment.uglyCommentId, @3);
    XCTAssertEqualObjects(delegateObj.uglyComment.uglyCommentTitle, @"Some title");

    XCTAssertTrue(delegateObj.allUglyComments.count == 2);

    MNFAdapterSubTestDelegateObj *subTestObj = [delegateObj.allUglyComments objectAtIndex:0];

    XCTAssertEqualObjects(subTestObj.uglyCommentId, @5);
    XCTAssertEqualObjects(subTestObj.uglyCommentTitle, @"Another title");

    MNFAdapterSubTestDelegateObj *subSecondTestObj = [delegateObj.allUglyComments objectAtIndex:1];

    XCTAssertEqualObjects(subSecondTestObj.uglyCommentId, @6);
    XCTAssertEqualObjects(subSecondTestObj.uglyCommentTitle, @"Swag title");
}

#pragma mark - Helpers

- (NSDictionary *)dictForFileName:(NSString *)theFileName ofType:(NSString *)theType {
    NSString *jsonPath = [[NSBundle bundleForClass:[self class]] pathForResource:theFileName ofType:theType];
    NSData *jsonData = [NSData dataWithContentsOfFile:jsonPath];

    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];

    return jsonDict;
}

@end
