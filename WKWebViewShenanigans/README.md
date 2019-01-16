#  WKWebViewShenanigans

This is a project for several radars around `WKWebView` behavior that becomes an enormous pain, particularly on iPad. 

## `WKWebView` behaves differently between the Simulator and a device. 

On an iPhone or iPad simulator, you can do a whole bunch of things which are not possible on a device: 

- You can load documents using a `URLRequest` with a file URL passed into `load(_)`. 
- When loading using the `loadFileURL(_, allowingReadAccessTo:)` method to load a file from a URL,  you can pass in any URL to the `allowingReadAccessTo` parameter and loading will work, albeit occasionally with errors printed to the console. The files still load correctly though.

It's very frustrating to have this work very differently on device and on the Simulator, because things break in flagrantly obvious ways for users in a way that's not predictable or testable from the Sim.

Yes, yes, yes: Test on device. But this is a big enough functionality change that it seems really incongruous to have it work fine on the Sim and die on device.

## You can only load files from one URL at a time. 

This is particularly annoying on iPads. On iPhones, the odds are a lot higher that you'd be recreating the web view by creating and pushing a new view controller if you're looking at a new document. On iPads, you're likely going to prefer reusing an existing view controller, and that's where everything goes pear-shaped.

Once you have called `loadFileURL(_, allowingReadAccessTo:)` and passed a particular URL into `allowingReadAccessTo`, that same instance of `WKWebView` cannot read any other URLs.

If you pass in the URL of a single file, trying to load any other single file from anywhere on your filesystem will fail with a security error. You have to create a new instance of `WKWebView` to read any other file. 

### Directories

You **can** pass the URL of a directory into `allowingReadAccessTo`, but while you can read other items from that directory, you are not able to access other directories without creating a new instance of `WKWebView`.

For example, if you have items in the Caches folder and in the Documents folder depending on whether the user has decided to permanently download these items, you can only show things from one of these directories at a time. 

There is no way to reset the folder the `WKWebView` has access to. Subsequent calls to `loadFileURL(_, allowingReadAccessTo:)` ignore the second parameter, and there is no separate variable to allow the read access directory to change.

### You can't pass in the application's sandbox directory to `allowingReadAccessTo`. 

Attempting to pass your application's sandbox directory (which is the direct parent of the user's Documents directory and the grandparent of the Caches directory) doesn't do anything. 

Even though this is a shared parent of both  Documents and Caches, you still receive security errors attempting to load any local file when this is passed in.
