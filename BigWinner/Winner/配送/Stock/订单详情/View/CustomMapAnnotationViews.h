//
//  CustomAnnotationView.h
//  MapBuildingDemo
//
//  Created by pro1 on 2017/9/5.
//  Copyright © 2017年 AutoNavi. All rights reserved.
//

#import <MAMapKit/MAMapKit.h>
#import "CustomMapCalloutView.h"

@interface CustomMapAnnotationViews : MAAnnotationView

@property (nonatomic, readonly) CustomMapCalloutView *calloutView;

@end
