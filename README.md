# SVG Generator

This project is a simple scripting framework to generate SVG files to use with a LASER cutter.

## Usage

1. Edit the code in `main.swift` to make it generate the shape you want
2. Run the program directly in Xcode. Path to the generated SVG file is printed in the output console

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