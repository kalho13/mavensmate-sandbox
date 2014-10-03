global with sharing class CustomExpenseController{

public String phoneGapUrl {
            get {
                String userAgent = ApexPages.currentPage().getHeaders().get('User-Agent');
                if (userAgent.contains('android'))
                    return 'phonegap-1.2.0-android.js';
                else
                    return 'phonegap-1.2.0-ios.js';
                    
                // iOS-specific checks that you could make.  Above, we assume it's iOS if it's not Android.
                //if (userAgent.contains('iPhone')
                //    || userAgent.contains('iPod')
                //    || userAgent.contains('iPad')
                //    || userAgent.contains('i386')
                //    || userAgent.contains('x86_64'))
                //    return 'phonegap-1.2.0-ios.js';
            }
    }
}