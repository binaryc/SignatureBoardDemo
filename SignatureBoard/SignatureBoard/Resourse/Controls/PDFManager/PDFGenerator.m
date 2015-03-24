//
//  PDFGenerator.m
//  SignatureBoard
//
//  Created by Bin Chen on 15/2/8.
//  Copyright (c) 2015年 touchDream. All rights reserved.
//

#import "PDFGenerator.h"

@implementation PDFGenerator

+ (void)createPDFFileAtPath:(NSString *)path withImages:(NSArray *)images
{
  CGContextRef pdfContext;
  CFStringRef pdfPath;
  CFURLRef url;
  CGRect pageRect;
  CFDataRef boxData = NULL;
  CFMutableDictionaryRef pdfPropertiesDictionary = NULL;
  CFMutableDictionaryRef pageDictionary = NULL;
  
  pdfPath = CFStringCreateWithCString (NULL, [path cStringUsingEncoding:NSUTF8StringEncoding],
                                    kCFStringEncodingUTF8);
  url = CFURLCreateWithFileSystemPath (NULL, pdfPath,
                                       kCFURLPOSIXPathStyle, 0);
  CFRelease (pdfPath);
  UIImage *img = images[0];
  pageRect = CGRectMake(0, 0, img.size.width, img.size.height);
  pdfPropertiesDictionary = CFDictionaryCreateMutable(NULL, 0,
                                           &kCFTypeDictionaryKeyCallBacks,
                                           &kCFTypeDictionaryValueCallBacks);
  CFDictionarySetValue(pdfPropertiesDictionary, kCGPDFContextTitle, CFSTR("Signature PDF"));
  CFDictionarySetValue(pdfPropertiesDictionary, kCGPDFContextCreator, CFSTR("BinaryC"));
  pdfContext = CGPDFContextCreateWithURL(url, &pageRect, pdfPropertiesDictionary);
  CFRelease(pdfPropertiesDictionary);
  CFRelease(url);
  pageDictionary = CFDictionaryCreateMutable(NULL, 0,
                                             &kCFTypeDictionaryKeyCallBacks,
                                             &kCFTypeDictionaryValueCallBacks);
  boxData = CFDataCreate(NULL,(const UInt8 *)&pageRect, sizeof (CGRect));
  CFDictionarySetValue(pageDictionary, kCGPDFContextMediaBox, boxData);
  
  for (UIImage *img in images) {
    CGPDFContextBeginPage (pdfContext, pageDictionary);
    [self drawContent:pdfContext withImg:img];
    CGPDFContextEndPage (pdfContext);
  }
  
  CGContextRelease (pdfContext);
  CFRelease(pageDictionary);
  CFRelease(boxData);
}

+ (void)drawContent:(CGContextRef)context
            withImg:(UIImage *)img
{
  CGContextDrawImage(context, CGRectMake(0, 0, img.size.width, img.size.height), img.CGImage);
}

@end
