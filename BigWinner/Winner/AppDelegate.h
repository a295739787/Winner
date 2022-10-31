//
//  AppDelegate.h
//  Winner
//
//  Created by 廖利君 on 2022/1/10.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>
-(void)loginVc;
-(void)showLoginVc;
-(void)loginPeisongVc;
-(void)loginMainVc;
@property (strong, nonatomic) UIWindow *window;
@property (nonatomic,assign) RoleStatus status ;/** <#class#> **/
-(void)showAlertVc;
-(void)showAlertReforceVc;
@end

