# File A Radar

In which I post some of the sample projects I've used for Radars to GitHub. 

### [Assorted `WKWebView` Shenanigans](WKWebViewShenanigans/README.md)

`WKWebView` behaves differently between simulator and device when loading local files. TL;DR: Always test on device.

**January 16, 2019**

- Open Radar: [http://openradar.appspot.com/radar?id=4944480041959424](http://openradar.appspot.com/radar?id=4944480041959424)
- Apple Radar: [rdar://47312413](rdar://47312413)

On device, the same instance of `WKWWebView` cannot load things from different folders, even when permission is explicitly granted to do so, because only the first URL passed in to `loadFileURL(_, allowingReadAccessTo:)` is actually given read permissions. 

**January 16, 2019**

- Open Radar: [http://openradar.appspot.com/radar?id=5022322029232128](http://openradar.appspot.com/radar?id=5022322029232128)
- Apple Radar: [rdar://47312604](rdar://47312604)

### [Named Colors == IBDesignables Crasher](IBDesignablesCrasher/README.md)

If you're trying to use named colors from an asset catalog in your main bundle in an IBDesignable which is also in your main bundle, they work fine when force-unwrapped at runtime and crash when force-unwrapped in IB unless you specify `Bundle(for: [any class in your main bundle)`. 

**January 8, 2019**

- Open Radar: [http://openradar.appspot.com/radar?id=4968845257211904](http://openradar.appspot.com/radar?id=4968845257211904)
- Apple Radar: [rdar://47113341](rdar://47113341)

### [Nav Bar Transition Funtimes](NavBarTransitionFuntimes/README.md)

When you have a transition between different colors for a nav bar's tint color and/or title text color, it works fine when the interactive transition is used and is a hot mess when you just pop the view controller.

**February 15, 2018**

- Open Radar: [http://openradar.appspot.com/radar?id=4950867170033664](http://openradar.appspot.com/radar?id=4950867170033664)
- Apple Radar: [rdar://37567828](rdar://37567828)

### [Appearance Proxy Bug Proof](AppearanceProxyBugProof/README.md)

Setting up appearance proxies on `UINavigationBar` directly instead of `appearanceWhenContainedInInstancesOfClass` and passing in a custom nav controller subclass leads to lots of bizarre stuff with `MFMail` or `MFMessage` compose view controllers. 

**February 17, 2017** (resubmitted)

- Open Radar: [http://openradar.appspot.com/radar?id=6165359065300992](http://openradar.appspot.com/radar?id=6165359065300992)
- Apple Radar: [rdar://30577177](rdar://30577177)

**November 21, 2013** (initial submission)

- Open Radar: [http://openradar.appspot.com/radar?id=5225793009483776](http://openradar.appspot.com/radar?id=5225793009483776)
- Apple Radar: [rdar://15526703](rdar://15526703)

