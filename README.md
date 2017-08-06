# Pre-work - *tippy*

**tippy** is a tip calculator application for iOS.

Submitted by: **Vijayanand Sankarasubramanian**

Time spent: **8** hours spent in total

## User Stories

The following **required** functionality is complete:

* [x] User can enter a bill amount, choose a tip percentage, and see the tip and total values.
* [x] Settings page to change the default tip percentage.

The following **optional** features are implemented:
* [ ] UI animations
* [ ] Remembering the bill amount across app restarts (if <10mins)
* [ ] Using locale-specific currency and currency thousands separators.
* [x] Making sure the keyboard is always visible and the bill amount is always the first responder. This way the user doesn't have to tap anywhere to use this app. Just launch the app and start typing.

The following **additional** features are implemented:

- [x] Used a PickerView instead of a Segmented Control to specify the tip percentage

## Video Walkthrough 

Here's a walkthrough of implemented user stories:

<img src='https://github.com/vijayanands/Tippy/blob/master/tipCalculatorDemo.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

GIF created with [LiceCap](http://www.cockos.com/licecap/).

## Project Analysis

As part of your pre-work submission, please reflect on the app and answer the following questions below:

**Question 1**: "What are your reactions to the iOS app development platform so far? How would you describe outlets and actions to another developer? Bonus: any idea how they are being implemented under the hood? (It might give you some ideas if you right-click on the Storyboard and click Open As->Source Code")

**Answer:** I find the xcode platform extremely intuitive and easy to use. The help that we get around syntax errors, properties of different UI objects, ability to get a WYSIWYG kind of feel by using both the story board and the source code side by side etc are some of the aspects of xcode that makes it very intuitive to a developer. We use outlets which can be described as a handle/reference to the UI component and actions which is nothing but callbacks or responders to a action we do on the UI. they seem to be implemented as key value pairs with the value pointing to the function or method that needs to be executed under the view controller class.

Question 2: "Swift uses [Automatic Reference Counting](https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/AutomaticReferenceCounting.html#//apple_ref/doc/uid/TP40014097-CH20-ID49) (ARC), which is not a garbage collector, to manage memory. Can you explain how you can get a strong reference cycle for closures? (There's a section explaining this concept in the link, how would you summarize as simply as possible?)"

**Answer:** [We can create a strong reference cycle by creating a cyclic dependencies between an object of class1 and an object of class2. In other words object of class1 has a property or a strong variable instance of class2 and object of class2 has a property or a strong variable instance of class1. So when one of the objects is destroyed there is still a reference to that from the other object].


## License

    Copyright [2017] [Vijayanand Sankarasubramanian]

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
