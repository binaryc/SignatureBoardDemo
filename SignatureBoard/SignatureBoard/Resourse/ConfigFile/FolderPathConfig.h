//
//  FolderPathConfig.h
//  SignatureBoard
//
//  Created by Bin Chen on 15/2/6.
//  Copyright (c) 2015年 touchDream. All rights reserved.
//

#ifndef SignatureBoard_FolderPathConfig_h
#define SignatureBoard_FolderPathConfig_h

CG_INLINE NSString* signatureFolderPath()
{
  return [NSString stringWithFormat:@"%@/Documents/signatures", NSHomeDirectory()];
}

CG_INLINE NSString* pdfFolderPath()
{
  return [NSString stringWithFormat:@"%@/Documents/PDF/", NSHomeDirectory()];
}

#endif
