# Nav Bar Transition Funtimes

Let's say you have two view controllers, one of which you want to have a different color navigation bar and/or navigation bar title color than the other.

Theoretically, you'd want the `barTintColor` and `titleTextAttributes` changes to change along with the view controller transition instead of popping in to place. 

In practice: 

- Pushing the second view controller works as expected
- Performing a swipe back from the second to the first works as expected
- Tapping the back button causes the `barTintColor` to pop in, and the `titleTextAttributes` to fail to change entirely. 

![](bug_gif.gif)

**February 15, 2018**

- Open Radar: [http://openradar.appspot.com/radar?id=4950867170033664](http://openradar.appspot.com/radar?id=4950867170033664)
- Apple Radar: [rdar://37567828](rdar://37567828)


A couple workarounds, both of which involve grabbing a `transitionCoordinator` and calling `animateAlongside` as you change the nav bar's `barTintColor` and/or `titleTextAttributes`: 

- [TestNavBarTransition](https://github.com/josshad/TestNavBarTransition), which does some interesting stuff with `UIViewController` subclasses
- [ColorableNavigationController](https://gist.github.com/Sorix/1d8543b18cfd76c12c36525bc280a35d), which overrides the push and pop methods in `UINavigationController` and uses a protocol to set up coloring the nav bar
