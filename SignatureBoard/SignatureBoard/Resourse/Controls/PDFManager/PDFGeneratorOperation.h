//
//  PDFGeneratorOperation.h
//  SignatureBoard
//
//  Created by Bin Chen on 15/2/11.
//  Copyright (c) 2015年 touchDream. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PDFGeneratorOperation : NSOperation

@property (nonatomic, copy) NSString *pdfFilePath;
@property (nonatomic, copy) NSArray  *signatures;

@end
