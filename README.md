# CNCParametricDraw

This Swift package is a scripting framework that helps me generate SVG files that I then feed to a LASER cutter to build wooden boxes and various storage units to store my LEGO collection. #iloveswift #ilovelego

![A picture with wooden boxes](picture_of_boxes.jpg)


## Overall design

### The Path type and PathRepresentable protocol

The `Path` type represents an abstract path composed of one or more commands.
Path commands are inspired by the SVG path spec but are meant to be independant of the rendering engine used.

Types can be created to represent arbitrarily complex shapes, that can all utltimately be expressed as a path.
Shape types implement the  `PathRepresentable` protocol which requires a readable `path` property of type `Path`.

### The PathsLayout type and PathsLayoutRepresentable protocol

The `PathsLayout` type is a collection of one or more paths that all have a fixed position.

Paths layouts are usefull for shapes that cannot be represented as a single path.
Types that represent shapes that cannot be represented as a single path implement the  `PathsLayoutRepresentable` protocol which requires a readable `pathsLayout` property of type `PathsLayout`.


## Simple shapes

### CrenelSegment

A line with crenelations.

![A line with crenelations](shape_crenelSegment.png)


### PunchesSegment

A set of rectangles aligned and spaces equally.

![A set of rectangles aligned and spaces equally](shape_punchesSegment.png)


### BoxFace

A rectangle that can have crenalations on its sides.
Uses CrenelSegments.

![A square with crenelations on all four sides](shape_boxFace.png)


## Multi components shapes

### CrenelBox

A template composed of five box faces that can be assembled to form an open box.
The top-most shape is the box's bottom, then come the four sides.

![Five box faces arranged vertically](shape_crenelBox.png)
