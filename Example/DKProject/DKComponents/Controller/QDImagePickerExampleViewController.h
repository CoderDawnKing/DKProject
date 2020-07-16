//
//  QDImagePickerExampleViewController.h
//  qmuidemo
//
//  Created by QMUI Team on 15/5/16.
//  Copyright (c) 2015年 QMUI Team. All rights reserved.
//

#import "QDMultipleImagePickerPreviewViewController.h"
#import "QDSingleImagePickerPreviewViewController.h"
#import "DKBaseGroupListViewController.h"

@interface QDImagePickerExampleViewController : DKBaseGroupListViewController<QMUIAlbumViewControllerDelegate,QMUIImagePickerViewControllerDelegate,QDMultipleImagePickerPreviewViewControllerDelegate,QDSingleImagePickerPreviewViewControllerDelegate>

@end
