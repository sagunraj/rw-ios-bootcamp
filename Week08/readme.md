In your README, describe at least one other option for packaging seed data like this with an app. Which do you think makes the most sense if you were shipping SandwichSaturation, and why?

Another option for packaging seed data within an app is creating a property list. I think both property list and JSON make sense if I was shipping the app because both of them have their own advantages. JSON is good because it is readable and clear, and also it is widely used by different platforms. And property list is also nice because we are working on an iOS app and iOS apps properly support property lists.

We can ship a preloaded database with the application too, but since we have less data to populate, it can be handled easily by JSON or property list.
