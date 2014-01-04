DDHTextView
===========

A `UITextView` subclass which let's you move the cursor with a pan gesture. You can move the cursor by panning left and right in the `inputAccessoryView`.
If you pan with two fingers you can select text.

Screenshot
----------

![](https://raw.github.com/dasdom/DDHTextView/master/screenshot.png)

How to use it
-------------

Add the `DDHTextView.h/.m` to your project, include `DDHTextView.h` in classes where you want to use the text view.

How it works
------------

Actually it's very simple. The `DDHTextView` just adds two pan gesture recoginzer to the text view and moves
the cursor when a pan happends.

License
-------

MIT license
