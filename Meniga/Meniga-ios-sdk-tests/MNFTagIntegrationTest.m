//
//  MNFTagIntegrationTest.m
//  Meniga-ios-sdk
//
//  Created by Mathieu Grettir Skulason on 11/9/15.
//  Copyright © 2015 Meniga. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MNFTag.h"
#import "MNFUser.h"
#import "Meniga.h"
#import "MNFSettings.h"
#import "NSObject+MenigaRuntimeExtension.h"
#import "NSString+MNFExtension.h"


@interface MNFTagIntegrationTest : XCTestCase

@end

@implementation MNFTagIntegrationTest

-(void)testTagCreationAndDeletion {
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"login"];
    
    [Meniga initWithSettings:[[MNFSettings alloc] initWithApiURL:@"http://menigais.test.meniga.net"]];
    
    [MNFUser logInWithUsername:@"mathieu@meniga.is" password:@"123456" withCompletion:^(MNFUser *user, NSError *error) {
        
        [MNFTag createTagWithName:[NSString c_randomStringWithLength:8] completion:^(MNFTag *tag, NSError *error) {
            
            XCTAssertNotNil(tag.tagId);
            XCTAssertNotNil(tag.tagName);
            XCTAssertTrue(tag.isDeleted == NO);
           
            if (error == nil) {
                
                [tag deleteTagWithCompletion:^(NSError *error) {
                    if (error == nil) {

                        XCTAssertTrue(tag.isDeleted == YES);
                        [expectation fulfill];
                    }
                }];
                
            }
            
        }];
        
    }];
    
    [self waitForExpectationsWithTimeout:20 handler:nil];
    
}

-(void)testGetTagWithId {
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"login"];
    
    [Meniga initWithSettings:[[MNFSettings alloc] initWithApiURL:@"http://menigais.test.meniga.net"]];
    
    [MNFUser logInWithUsername:@"mathieu@meniga.is" password:@"123456" withCompletion:^(MNFUser *user, NSError *error) {
        
        [MNFTag fetchWithId:[NSNumber numberWithInt:224] completion:^(MNFTag *tag, NSError *error) {
           
            if (error == nil) {
                XCTAssertNotNil(tag.tagId);
                XCTAssertNotNil(tag.tagName);
                [expectation fulfill];
            }
            
        }];
        
    }];
    
    [self waitForExpectationsWithTimeout:20 handler:nil];
    
}

-(void)testTagSave {
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"login"];
    
    [Meniga initWithSettings:[[MNFSettings alloc] initWithApiURL:@"http://menigais.test.meniga.net"]];
    
    [MNFUser logInWithUsername:@"mathieu@meniga.is" password:@"123456" withCompletion:^(MNFUser *user, NSError *error) {
        
        [MNFTag fetchWithId:[NSNumber numberWithInt:224] completion:^(MNFTag *tag, NSError *error) {
            
            if (error == nil) {
                tag.tagName = [NSString c_randomStringWithLength:10];
                XCTAssertTrue(tag.isDirty == YES);
                [tag saveWithCompletion:^(NSError *error) {
                   
                    if (error == nil) {
                        XCTAssertNotNil(tag.tagId);
                        XCTAssertNotNil(tag.tagName);
                        [expectation fulfill];
                    }
                    
                }];
            }
            
        }];
        
    }];
    
    [self waitForExpectationsWithTimeout:20 handler:nil];
    
}

-(void)testTagsUpdate {
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"TagsUpdate"];
    
    [Meniga initWithSettings:[[MNFSettings alloc] initWithApiURL:@"http://menigais.test.meniga.net"]];
    
    [MNFUser logInWithUsername:@"mathieu@meniga.is" password:@"123456" withCompletion:^(MNFUser *user, NSError *error) {
        
        [MNFTag fetchTagsWithCompletion:^(NSArray *tags, NSError *error) {
           
            if (error == nil) {
                
                for (MNFTag *tag in tags) {
                    tag.tagName = [NSString c_randomStringWithLength:10];
                }
                
                [MNFTag updateTags:tags withCompletion:^(NSError *error) {
                    
                    if (error == nil) {
                        [expectation fulfill];
                    }
                    
                }];
                
            }
            
        }];
        
    }];
    
    [self waitForExpectationsWithTimeout:20 handler:nil];
    
}

-(void)testGetTags {
    XCTestExpectation *expectation = [self expectationWithDescription:@"login"];
    
    [Meniga initWithSettings:[[MNFSettings alloc] initWithApiURL:@"http://menigais.test.meniga.net"]];
    
    [MNFUser logInWithUsername:@"mathieu@meniga.is" password:@"123456" withCompletion:^(MNFUser *user, NSError *error) {
        
        [MNFTag fetchTagsWithCompletion:^(NSArray *tags, NSError *error) {
            
            if (error == nil) {
                XCTAssertNotNil(tags);
                [expectation fulfill];
                
            }
            
        }];
        
    }];
    
    [self waitForExpectationsWithTimeout:20 handler:nil];
}

@end
