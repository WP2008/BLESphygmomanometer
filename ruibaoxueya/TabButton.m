//
//  TabButton.m
//  TCode
//
//  Created by  on 12-3-5.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "TabButton.h"

@implementation TabButton

@synthesize focus = _focus;

- (void)setFocus:(BOOL)focus
{
    if (_focus == focus) 
    {
        return;
    }
    _focus = focus;

    if (focus)
    {
        UIImage *defaultImage = [self backgroundImageForState:UIControlStateNormal] ;
        UIImage *selectedImage = [self backgroundImageForState:UIControlStateSelected];
        
        [self setBackgroundImage:selectedImage forState:UIControlStateNormal];
        [self setBackgroundImage:defaultImage forState:UIControlStateSelected];
         //[self setBackgroundImage:<#(UIImage *)#> forState:<#(UIControlState)#>]
        //[defaultImage release];
        //[selectedImage release];
    }
    else
    {
        UIImage *defaultImage = [self backgroundImageForState:UIControlStateSelected] ;
        UIImage *selectedImage = [self backgroundImageForState:UIControlStateNormal] ;
        
        [self setBackgroundImage:defaultImage forState:UIControlStateNormal];
        [self setBackgroundImage:selectedImage forState:UIControlStateSelected];
        
       // [defaultImage release];
        //[selectedImage release];
    }
    
   
}



@end
