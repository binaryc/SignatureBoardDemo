//
//  PDFGenerator.h
//  SignatureBoard
//
//  Created by Bin Chen on 15/2/8.
//  Copyright (c) 2015年 touchDream. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PDFGenerator : NSObject

+ (void)createPDFFileAtPath:(NSString *)path withImages:(NSArray *)images;

@end
