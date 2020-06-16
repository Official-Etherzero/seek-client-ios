//
//  YYSize.h
//  Video_edit
//
//  Created by yang on 2018/9/30.
//  Copyright © 2018年 m-h. All rights reserved.
//

#ifndef YYSize_h
#define YYSize_h

#define YYSCREEN_WIDTH  ([UIScreen mainScreen].bounds.size.width)
#define YYSCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

#define SWidth YYSCREEN_WIDTH < YYSCREEN_HEIGHT ? YYSCREEN_WIDTH : YYSCREEN_HEIGHT
#define SHeight YYSCREEN_HEIGHT > YYSCREEN_WIDTH ? YYSCREEN_HEIGHT : YYSCREEN_WIDTH

#define kmaximumLength (100)
#define kminimumColumn (0)

#define kCommentTextLimitLength (100)
#define kThumbnailViewColumn (3)

// 美工按 6s 切图，暂时按 6s 等比处理
#define UIWIDTH_IS_IPHONE6S 375.0f

#define GEOMETRIC (([UIScreen mainScreen].bounds.size.width > [UIScreen mainScreen].bounds.size.height)

#define YYSCALE  ([UIScreen mainScreen].bounds.size.width > [UIScreen mainScreen].bounds.size.height ? [UIScreen mainScreen].bounds.size.height/UIWIDTH_IS_IPHONE6S : [UIScreen mainScreen].bounds.size.width/UIWIDTH_IS_IPHONE6S)


// 尺寸取自宏文件 常用的尺寸
#define YYSIZE_01      YYSCALE* 1.0f
#define YYSIZE_02      YYSCALE* 2.0f
#define YYSIZE_03      YYSCALE* 3.0f
#define YYSIZE_04      YYSCALE* 4.0f
#define YYSIZE_05      YYSCALE* 5.0f
#define YYSIZE_06      YYSCALE* 6.0f
#define YYSIZE_07      YYSCALE* 7.0f
#define YYSIZE_08      YYSCALE* 8.0f
#define YYSIZE_09      YYSCALE* 9.0f
#define YYSIZE_10      YYSCALE* 10.0f
#define YYSIZE_11      YYSCALE* 11.0f
#define YYSIZE_12      YYSCALE* 12.0f
#define YYSIZE_13      YYSCALE* 13.0f
#define YYSIZE_14      YYSCALE* 14.0f
#define YYSIZE_15      YYSCALE* 15.0f
#define YYSIZE_16      YYSCALE* 16.0f
#define YYSIZE_17      YYSCALE* 17.0f
#define YYSIZE_18      YYSCALE* 18.0f
#define YYSIZE_19      YYSCALE* 19.0f
#define YYSIZE_20      YYSCALE* 20.0f
#define YYSIZE_21      YYSCALE* 21.0f
#define YYSIZE_22      YYSCALE* 22.0f
#define YYSIZE_23      YYSCALE* 23.0f
#define YYSIZE_24      YYSCALE* 24.0f
#define YYSIZE_25      YYSCALE* 25.0f
#define YYSIZE_26      YYSCALE* 26.0f
#define YYSIZE_27      YYSCALE* 27.0f
#define YYSIZE_28      YYSCALE* 28.0f
#define YYSIZE_30      YYSCALE* 30.0f
#define YYSIZE_31      YYSCALE* 31.0f
#define YYSIZE_32      YYSCALE* 32.0f
#define YYSIZE_33      YYSCALE* 33.0f
#define YYSIZE_34      YYSCALE* 34.0f
#define YYSIZE_35      YYSCALE* 35.0f
#define YYSIZE_36      YYSCALE* 36.0f
#define YYSIZE_37      YYSCALE* 37.0f
#define YYSIZE_38      YYSCALE* 38.0f
#define YYSIZE_39      YYSCALE* 39.0f
#define YYSIZE_40      YYSCALE* 40.0f
#define YYSIZE_42      YYSCALE* 42.0f
#define YYSIZE_44      YYSCALE* 24.0f
#define YYSIZE_45      YYSCALE* 45.0f
#define YYSIZE_46      YYSCALE* 46.0f
#define YYSIZE_47      YYSCALE* 47.0f
#define YYSIZE_48      YYSCALE* 48.0f
#define YYSIZE_50      YYSCALE* 50.0f
#define YYSIZE_52      YYSCALE* 52.0f
#define YYSIZE_54      YYSCALE* 54.0f
#define YYSIZE_56      YYSCALE* 56.0f
#define YYSIZE_57      YYSCALE* 57.0f
#define YYSIZE_58      YYSCALE* 58.0f
#define YYSIZE_60      YYSCALE* 60.0f
#define YYSIZE_62      YYSCALE* 62.0f
#define YYSIZE_64      YYSCALE* 64.0f
#define YYSIZE_66      YYSCALE* 66.0f
#define YYSIZE_68      YYSCALE* 68.0f
#define YYSIZE_70      YYSCALE* 70.0f
#define YYSIZE_74      YYSCALE* 74.0f
#define YYSIZE_76      YYSCALE* 76.0f
#define YYSIZE_78      YYSCALE* 78.0f
#define YYSIZE_80      YYSCALE* 80.0f
#define YYSIZE_82      YYSCALE* 82.0f
#define YYSIZE_84      YYSCALE* 84.0f
#define YYSIZE_88      YYSCALE* 88.0f
#define YYSIZE_90      YYSCALE* 90.0f
#define YYSIZE_91      YYSCALE* 91.0f
#define YYSIZE_94      YYSCALE* 94.0f
#define YYSIZE_95      YYSCALE* 95.0f
#define YYSIZE_96      YYSCALE* 96.0f
#define YYSIZE_98      YYSCALE* 98.0f
#define YYSIZE_100     YYSCALE* 100.0f
#define YYSIZE_102     YYSCALE* 102.0f
#define YYSIZE_106     YYSCALE* 106.0f
#define YYSIZE_108     YYSCALE* 108.0f
#define YYSIZE_110     YYSCALE* 110.0f
#define YYSIZE_112     YYSCALE* 112.0f
#define YYSIZE_113     YYSCALE* 113.0f
#define YYSIZE_114     YYSCALE* 114.0f
#define YYSIZE_117     YYSCALE* 117.0f
#define YYSIZE_119     YYSCALE* 119.0f
#define YYSIZE_120     YYSCALE* 120.0f
#define YYSIZE_128     YYSCALE* 128.0f
#define YYSIZE_132     YYSCALE* 132.0f
#define YYSIZE_135     YYSCALE* 135.0f
#define YYSIZE_140     YYSCALE* 140.0f
#define YYSIZE_148     YYSCALE* 148.0f
#define YYSIZE_150     YYSCALE* 150.0f
#define YYSIZE_158     YYSCALE* 158.0f
#define YYSIZE_160     YYSCALE* 160.0f
#define YYSIZE_164     YYSCALE* 164.0f
#define YYSIZE_165     YYSCALE* 165.0f
#define YYSIZE_182     YYSCALE* 182.0f
#define YYSIZE_191     YYSCALE* 191.0f
#define YYSIZE_200     YYSCALE* 200.0f
#define YYSIZE_201     YYSCALE* 201.0f
#define YYSIZE_210     YYSCALE* 210.0f
#define YYSIZE_218     YYSCALE* 218.0f
#define YYSIZE_204     YYSCALE* 204.0f
#define YYSIZE_230     YYSCALE* 230.0f
#define YYSIZE_240     YYSCALE* 240.0f
#define YYSIZE_250     YYSCALE* 250.0f
#define YYSIZE_275     YYSCALE* 275.0f
#define YYSIZE_292     YYSCALE* 292.0f
#define YYSIZE_293     YYSCALE* 293.0f
#define YYSIZE_329     YYSCALE* 329.0f
#define YYSIZE_330     YYSCALE* 330.0f
#define YYSIZE_331     YYSCALE* 331.0f
#define YYSIZE_333     YYSCALE* 333.0f
#define YYSIZE_335     YYSCALE* 335.0f
#define YYSIZE_340     YYSCALE* 340.0f
#define YYSIZE_354     YYSCALE* 354.0f
#define YYSIZE_355     YYSCALE* 355.0f
#define YYSIZE_360     YYSCALE* 360.0f
#define YYSIZE_364     YYSCALE* 364.0f
#define YYSIZE_390     YYSCALE* 390.0f
#define YYSIZE_396     YYSCALE* 396.0f
#define YYSIZE_560     YYSCALE* 560.0f
#define YYSIZE_570     YYSCALE* 570.0f
#define YYSIZE_600     YYSCALE* 600.0f

#endif /* YYSize_h */
