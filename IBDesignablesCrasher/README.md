# IBDesignables Crasher

Using named colors in an asset catalog causes the IBDesignables agent to crash and leave IB in an unusable state if you attempt to access and force-unwrap those colors in `prepareForInterfaceBuilder`. 

If your asset catalog is in the `main` bundle, passing `Bundle.main` is still not sufficient, you have to pass something like `Bundle(for: AppDelegate.self)` (or some other class in the main bundle) for the agent to stop crashing. 

**January 8, 2019**

- Open Radar: [http://openradar.appspot.com/radar?id=4968845257211904](http://openradar.appspot.com/radar?id=4968845257211904)
- Apple Radar: [rdar://47113341](	rdar://47113341)


This *can* be worked around by passing in `Bundle(for: AppDelegate.self)` but that’s really not obvious at all. See `Color.swift` in this project for the 3 options I tried and how they worked.

## Note

If you're trying to figure out why the hell the `IBDesignablesAgent` is crashing, open `Console.app` and search for `IBDesignable` - error messaging you get there is way more useful than what you get in Xcode.