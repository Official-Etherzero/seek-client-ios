//
//  YYButton.m
//  ETZClientForiOS
//
//  Created by yang on 2019/10/22.
//  Copyright © 2019 yang123. All rights reserved.
//

#import "YYButton.h"

@implementation YYButton

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    
    if (_stretchLength > 0) {
        CGRect hiteArea = CGRectMake(self.bounds.origin.x - _stretchLength, self.bounds.origin.y - _stretchLength, self.bounds.size.width + _stretchLength * 2, self.bounds.size.height + _stretchLength * 2);
        return CGRectContainsPoint(hiteArea, point);
    }
    if (_hiteFrame.size.width > 0) {
        return CGRectContainsPoint(_hiteFrame, point);
    }
    CGRect hiteArea = CGRectMake(self.bounds.origin.x - _hiteFrame.origin.x, self.bounds.origin.y - _topArea, self.bounds.size.width + _leftArea + _rightArea, self.bounds.size.height + _bottomArea + _topArea);
    return CGRectContainsPoint(hiteArea, point);
}

@end
