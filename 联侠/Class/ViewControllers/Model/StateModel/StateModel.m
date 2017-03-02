//
//  StateModel.m
//  AEFT冷风扇
//
//  Created by 杭州阿尔法特 on 16/4/12.
//  Copyright © 2016年 阿尔法特. All rights reserved.
//

#import "StateModel.h"

@implementation StateModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {

}

- (void)setValue:(id)value forKey:(NSString *)key {
    
    
    if ([key isEqualToString:@"fLock"]) {
        if ([value isKindOfClass:[NSNull class]]) {
            _fLock = 0;
        } else {
            _fLock = [value integerValue];
        }
    }  if ([key isEqualToString:@"fMode"]) {
        if ([value isKindOfClass:[NSNull class]]) {
            _fMode = 0;
        } else {
            _fMode = [value integerValue];
        }
    }  if ([key isEqualToString:@"fState"]) {
        if ([value isKindOfClass:[NSNull class]]) {
            _fState = 0;
        } else {
            _fState = [value integerValue];
        }
    }  if ([key isEqualToString:@"fSwing"]) {
        
        if ([value isKindOfClass:[NSNull class]]) {
            _fSwing = 0;
        } else {
            _fSwing = [value integerValue];
        }
        
    }  if ([key isEqualToString:@"fSwitch"]) {
        
        if ([value isKindOfClass:[NSNull class]]) {
            _fSwitch = 0;
        } else {
            _fSwitch = [value integerValue];
        }
        
    }  if ([key isEqualToString:@"fUV"]) {
        
        if ([value isKindOfClass:[NSNull class]]) {
            _fUV = 0;
        } else {
            _fUV = [value integerValue];
        }
        
    } if ([key isEqualToString:@"fWind"]) {
        
        if ([value isKindOfClass:[NSNull class]]) {
            _fWind = 0;
        } else {
            _fWind = [value integerValue];
        }
        
    }  if ([key isEqualToString:@"fAuto"]) {
        
        if ([value isKindOfClass:[NSNull class]]) {
            _fAuto = 0;
        } else {
            _fAuto = [value integerValue];
        }
        
    }  if ([key isEqualToString:@"fSleep"]) {
        
        if ([value isKindOfClass:[NSNull class]]) {
            _fSleep = 0;
        } else {
            _fSleep = [value integerValue];
        }
        
    }  if ([key isEqualToString:@"fAnion"]) {
        
        if ([value isKindOfClass:[NSNull class]]) {
            _fAnion = 0;
        } else {
            _fAnion = [value integerValue];
        }
        
    } if ([key isEqualToString:@"fShift"]) {
        
        if ([value isKindOfClass:[NSNull class]]) {
            _fShift = 0;
        } else {
            _fShift = [value integerValue];
        }
        
    } if ([key isEqualToString:@"currentC"]) {
        
        if ([value isKindOfClass:[NSNull class]]) {
            _currentC = 0;
        } else {
            _currentC = value;
        }
        
    }  if ([key isEqualToString:@"aqi"]) {
        
        if ([value isKindOfClass:[NSNull class]]) {
            _aqi = 0;
        } else {
            _aqi = value;
        }
        
    }  if ([key isEqualToString:@"cleanFilterScreen"]) {
        
        if ([value isKindOfClass:[NSNull class]]) {
            _cleanFilterScreen = 0;
        } else {
            _cleanFilterScreen = [value integerValue];
        }
        
    }  if ([key isEqualToString:@"changeFilterScreen"]) {
        
        if ([value isKindOfClass:[NSNull class]]) {
            _changeFilterScreen = 0;
        } else {
            _changeFilterScreen = [value integerValue];
        }
        
    }  if ([key isEqualToString:@"pm25"]) {
        
        if ([value isKindOfClass:[NSNull class]]) {
            _pm25 = 0;
        } else {
            _pm25 = value;
        }
        
    } if ([key isEqualToString:@"light"]) {
        
        if ([value isKindOfClass:[NSNull class]]) {
            _light = 0;
        } else {
            _light = [value integerValue];
        }
        
    }  if ([key isEqualToString:@"currentH"]) {
        
        if ([value isKindOfClass:[NSNull class]]) {
            _currentH = 0;
        } else {
            _currentH = [value integerValue];
        }
        
    } if ([key isEqualToString:@"co2"]) {
        
        if ([value isKindOfClass:[NSNull class]]) {
            _co2 = 0;
        } else {
            _co2 = [value integerValue];
        }
        
    } if ([key isEqualToString:@"durTime"]) {
        
        if ([value isKindOfClass:[NSNull class]]) {
            _durTime = 0;
        } else {
            _durTime = [value integerValue];
        }
        
    } if ([key isEqualToString:@"methanal"]) {
        
        if ([value isKindOfClass:[NSNull class]]) {
            _methanal = 0;
        } else {
            _methanal = [value integerValue];
        }
        
    }
}

- (NSString *)description {
    return [NSString stringWithFormat:@"fSwitch--%ld , _fWind--%ld , _fAnion--%ld , _fAuto--%ld , _light--%ld" , _fSwitch , _fWind , _fAnion , _fAuto , _light];
}


@end
