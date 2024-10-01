<!-- TOC -->
* [CSS](#css)
  * [max](#max)
  * [margin:](#margin)
  * [linear-gradient:](#linear-gradient)
  * [border-left:](#border-left)
  * [box-shadow:](#box-shadow)
  * [width:](#width)
  * [filter:](#filter)
  * [box-sizing:](#box-sizing)
  * [display:](#display)
    * [flex-direction:](#flex-direction)
    * [flex-wrap:](#flex-wrap)
    * [justify-content:](#justify-content)
    * [align-items:](#align-items)
  * [object-fit:](#object-fit)
  * [gap:](#gap)
  * [::after](#after)
  * [font-family:](#font-family)
  * [letter-spacing:](#letter-spacing)
  * [rem:](#rem)
  * [:not](#not)
<!-- TOC -->


# CSS

## max

**max** function which returns the largest of a set of comma-separated values. For example:

```css
img {
  width: max(250px, 25vw);
}
```

In the above example, the width of the image will be 250px if the viewport width is less than 1000 pixels. If the viewport width is greater than 1000
pixels, the width of the image will be 25vw. This is because 25vw is equal to 25% of the viewport width.

## margin:

```
margin: 10px auto  ;
```

When the shorthand **margin** property has two values, it sets **margin-top** and **margin-bottom** to the first value, and **margin-left** and
**margin-right** to the second value.

## linear-gradient:

```
linear-gradient(gradientDirection, color1, color2, ...);
```

**gradientDirection** is the direction of the line used for the transition. **color1** and **color2** are color arguments, which are the colors that
will be used in the transition itself. These can be any type of color, including color keywords, hex, rgb, or hsl.

While the **linear-gradient** function needs a minimum of two color arguments to work, it can accept many color arguments.

Color-stops allow you to fine-tune where colors are placed along the gradient line. They are a length unit like px or percentages that follow a color
in the **linear-gradient** function.
For example, in this red-black gradient, the transition from red to black takes place at the 90% point along the gradient line, so red takes up most
of the available space:

```
linear-gradient(90deg, red 90%, black);
```

The first color is at the start (0%), the second is in the middle (50%), and the last is at the end (100%) of the gradient line.
The **linear-gradient** function automatically calculates these values for you, and places colors evenly along the gradient line by default.

## border-left:

The **border-left** shorthand property lets you set the left border's width, style, and color at the same time.
Here is the syntax:

```
border-left: width style color;
```

## box-shadow:

```
box-shadow: offsetX offsetY blurRadius color;
```

If a **blurRadius** value isn't included, it defaults to **0** and produces sharp edges. The higher the value of **blurRadius**, the greater the
blurring effect is.
But what if you wanted to expand the shadow out further? You can do that with the optional **spreadRadius** value:

`box-shadow: offsetX offsetY blurRadius spreadRadius color;`

Like blurRadius, spreadRadius defaults to 0 if it isn't included.

## width:

**width** of **unset**. This will remove the earlier rule which set all the **input** elements to **width: 100%**.

## filter:

Use the filter property to blur the painting by 2px in the .canvas element.

Here's an example of a rule that add a 3px blur:

```css
p {
  filter: blur(3px);
}
```

## box-sizing:

The **border-box** sizing model does the opposite of **content-box**. The total width of the element, including padding and border, will be the
explicit width set. The content of the element will shrink to make room for the padding and border.
Change the **box-sizing** property to **border-box**. Notice how your blue image borders now fit within your red gallery border.

## display:

Flexbox is a one-dimensional CSS layout that can control the way items are spaced out and aligned within a container.

To use it, give an element a **display** property of flex. This will make the element a _flex container_. Any direct children of a flex container are
called
_flex items_.

### flex-direction:

Flexbox has a main and cross axis. The main axis is defined by the **flex-direction** property, which has four possible values:

* row (default): horizontal axis with flex items from left to right
* row-reverse: horizontal axis with flex items from right to left
* column: vertical axis with flex items from top to bottom
* column-reverse: vertical axis with flex items from bottom to top

> **Note:** The axes and directions will be different depending on the text direction. The values shown are for a left-to-right text direction.

### flex-wrap:

The **flex-wrap** property determines how your flex items behave when the flex container is too small. Setting it to `wrap` will allow the items to
wrap to the next row or column. `nowrap` (default) will prevent your items from wrapping and shrink them if needed.

### justify-content:

The **justify-content** property determines how the items inside a flex container are positioned along the **_main axis_**, affecting their position
and the space around them.

### align-items:

The **align-items** property positions the flex content along the **_cross axis_**. In this case, with your **flex-direction** set to **row**, your
**_cross axis_** would be vertical.

## object-fit:

Notice how some of your images have become distorted. This is because the images have different aspect ratios. Rather than setting each aspect ratio
individually, you can use the **object-fit** property to determine how images should behave.
`cover` will tell the image to fill the **img** container while maintaining aspect ratio, resulting in cropping to fit

## gap:

The **gap** CSS shorthand property sets the gaps, also known as gutters, between rows and columns. The **gap** property and its **row-gap** and
**column-gap** sub-properties provide this functionality for flex, grid, and multi-column layout.

## ::after

The **::after** pseudo-element creates an element that is the last child of the selected element. You can use it to add an empty element after the
last image. If you give it the same width as the images it will push the last image to the left when the gallery is in a two-column layout.

```css
.container::after {
    content: "";
    width: 860px;
}
```

## font-family:

give it a **font-family** set to _Open Sans_ with a fallback of _sans-serif_.

```
font-family: 'Open Sans', sans-serif
```

## letter-spacing:

The **letter-spacing** property can be used to adjust the space between each character of text in an element.

## rem:

The **rem** unit stands for **root em**, and is relative to the font size of the **html** element.

> **Eg:**
> If you set your **html** to have a font-size of 16px, create a **.small-text** selector and set the font-size to **0.85rem**, it would calculate to
> roughly **13.6px**.

## :not

The **:not** pseudo-selector can be used to select all elements that do not match the given CSS rule.

**Example Code**

```css
div:not(#example) {
  color: red;
}
```

The above selects all div elements without an id of example.

