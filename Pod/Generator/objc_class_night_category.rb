# -*- coding: utf-8 -*-

module ObjcClassNightCategory

	def night_interface_string
		<<-OBJECT_C
//
//  #{name}+NightVersion.h
//  #{name}+NightVersion
//
//  Copyright (c) 2015 Draveness. All rights reserved.

#import <UIKit/UIKit.h>
#{night_interface_import_string}
@interface #{name} (NightVersion)

- (void)switchColor;

@end
		OBJECT_C
	end

	def night_interface_import_string
		properties.map { |property|
			"#import \"" + name + "+#{property.cap_name}.h\"\n"
		}.join
	end

	def night_implementation_string
		<<-OBJECT_C
//
//  #{name}+NightVersion.m
//  #{name}+NightVersion
//
//  Copyright (c) 2015 Draveness. All rights reserved.

#import "#{name}+NightVersion.h"
#{night_implementation_superclass_string}
#import "DKNightVersionManager.h"
#import "DKNightVersionConstants.h"

@implementation #{name} (NightVersion)

#pragma mark - SwitchColor

- (void)switchColor {
    #{night_implementation_method_string}[UIView animateWithDuration:NIGHT_ANIMATION_DURATION animations:^{
        #{night_implementation_property_string}
    }];
}

@end
		OBJECT_C
	end

	def night_implementation_superclass_string
		superclass ? "#import \"#{superclass}+NightVersion.h\"" : ""
	end

	def night_implementation_method_string
		superclass ? "[super switchColor];\n    " : ""
	end

	def night_implementation_property_string
		properties.map { |property|
			"self.#{property.name} = ([DKNightVersionManager currentThemeVersion] == DKThemeVersionNight) ? \
self.night#{property.cap_name} : self.normal#{property.cap_name};"
		}.join
	end

end