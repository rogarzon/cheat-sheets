<!-- TOC -->
* [CSS cheatsheet](#css-cheatsheet)
  * [Selectors](#selectors)
  * [Combinators](#combinators)
  * [Attribute selectors](#attribute-selectors)
  * [Pseudo-classes](#pseudo-classes)
  * [Pseudo-class variations](#pseudo-class-variations)
  * [Fonts](#fonts)
    * [Properties](#properties)
    * [Example](#example)
    * [Case](#case)
  * [Background](#background)
    * [Properties](#properties-1)
    * [Multiple backgrounds:](#multiple-backgrounds)
  * [Animation](#animation)
    * [Properties](#properties-2)
    * [Example:](#example-1)
  * [Event](#event)
<!-- TOC -->


# CSS cheatsheet

https://devhints.io/css

## Selectors

```
.class {
    font-weight: bold; 
    }
*    All elements
div    Element
.class    Class
#id    ID
[disabled]    Attribute
[role="dialog"]    Attribute
```

## Combinators

```
.parent .child    Descendant
.parent > .child    Direct descendant
.child + .sibling    Adjacent sibling
.child ~ .sibling    Far sibling
.class1.class2    Have both classes
```

## Attribute selectors

```
[role="dialog"]    = Exact
[class~="box"]    ~= Has word
[class|="box"]    |= Exact or prefix (eg, value-)
[href$=".doc"]    $= Ends in
[href^="/index"]    ^= Begins with
[class*="-is-"]    *= Contains
```
## Pseudo-classes

```
:target    eg, h2#foo:target
:disabled
:focus
:active
:nth-child(3)    3rd child
:nth-child(3n+2)    2nd child in groups of 3
:nth-child(-n+4)
:nth-last-child(2)
:nth-of-type(2)
:checked    Checked inputs
:disabled    Disabled elements
:default    Default element in a group
:empty    Elements without children
```

## Pseudo-class variations

```
:first-of-type
:last-of-type
:nth-of-type(2)
:only-of-type
:first-child
:last-child
:nth-child(2)
:only-child
```

## Fonts

### Properties

```
font-family:       <font>, <fontN>
font-size:            <size>
letter-spacing:    <size>
line-height:        <number>
font-weight:        bold / normal
font-style:        italic / normal
text-decoration:    underline / none
text-align:        left / right / center / justify
text-transform:    capitalize / uppercase / lowercase
```

### Example

```
font-family: Arial;
font-size: 12pt;
line-height: 1.5;
letter-spacing: 0.02em;
color: #aa3322;
```

### Case

```
text-transform: capitalize; /* Hello */
text-transform: uppercase; /* HELLO */
text-transform: lowercase; /* hello */
```

## Background

### Properties

```
background:             (Shorthand)
background-color:       <color>
background-image:       url(...)
background-position:    left/center/right  top/center/bottom
background-size:        cover X Y
background-clip:        border-box padding-box content-box
background-repeat:      no-repeat repeat-x repeat-y
background-attachment:  scroll fixed local
```


### Multiple backgrounds:
```
background: linear-gradient(to bottom, rgba(0, 0, 0, 0.5), rgba(0, 0, 0, 0.5)),
  url('background.jpg') center center / cover, #333;
```


## Animation

### Properties
```
animation:	(shorthand)
animation-name:	<name>
animation-duration:	<time>ms
animation-timing-function:	ease linear ease-in ease-out ease-in-out
animation-delay:	<time> ms
animation-iteration-count: infinite <number>
animation-direction: normal  reverse  alternate  alternate-reverse
animation-fill-mode: none  forwards  backwards  both  initial  inherit
animation-play-state: normal  reverse  alternate  alternate-reverse
```

### Example:
```
animation: bounce 300ms linear 0s infinite normal;
animation: bounce 300ms linear infinite;
animation: bounce 300ms linear infinite alternate-reverse;
animation: bounce 300ms linear 2s infinite alternate-reverse forwards normal;
```

## Event
```
.one('webkitAnimationEnd oanimationend msAnimationEnd animationend')
```
