# CSS cheatsheet

https://devhints.io/css

### Selectors

* `.class {
    font-weight: bold; 
    }`
* `*`    All elements
* `div`    Element
* `.class`    Class
* `#id`    ID
* `[disabled]`    Attribute
* `[role="dialog"]`    Attribute

### Combinators

* `.parent .child`    Descendant
* `.parent > .child`    Direct descendant
* `.child + .sibling`    Adjacent sibling
* `.child ~ .sibling`    Far sibling
* `.class1.class2`    Have both classes

### Attribute selectors

* `[role="dialog"]`    = Exact
* `[class~="box"]`    ~= Has word
* `[class|="box"]`    |= Exact or prefix (eg, value-)
* `[href$=".doc"]`    $= Ends in
* `[href^="/index"]`    ^= Begins with
* `[class*="-is-"]`    *= Contains

### Pseudo-classes

1. `:target`    eg, h2#foo:target
2. `:disabled`
3. `:focus`
4. `:active`
5. `:nth-child(3)`    3rd child
6. `:nth-child(3n+2)`    2nd child in groups of 3
7. `:nth-child(-n+4)`
8. `:nth-last-child(2)`
9. `:nth-of-type(2)`
10. `:checked`    Checked inputs
11. `:disabled`    Disabled elements
12. `:default`    Default element in a group
13. `:empty`    Elements without children

### Pseudo-class variations

1. `:first-of-type`
2. `:last-of-type`
3. `:nth-of-type(2)`
4. `:only-of-type`
5. `:first-child`
6. `:last-child`
7. `:nth-child(2)`
8. `:only-child`

# Fonts

## Properties

1. `font-family:`       <font>, <fontN>
2. `font-size:`            <size>
3. `letter-spacing:`    <size>
4. `line-height:`        <number>
5. `font-weight:`        bold / normal
6. `font-style:`        italic / normal
7. `text-decoration:`    underline / none
8. `text-align:`        left / right / center / justify
9. `text-transform:`    capitalize / uppercase / lowercase

## Example

* font-family: Arial;
* font-size: 12pt;
* line-height: 1.5;
* letter-spacing: 0.02em;
* color: #aa3322;

## Case

* text-transform: capitalize; /* Hello */
* text-transform: uppercase; /* HELLO */
* text-transform: lowercase; /* hello */

# Background

## Properties

1. `background:`             (Shorthand)
2. `background-color:`       <color>
3. `background-image:`       `url(...)`
4. `background-position:`    `left/center/right ` `top/center/bottom`
5. `background-size:`        `cover` `X Y`
6. `background-clip:`        `border-box` `padding-box` `content-box`
7. `background-repeat:`      `no-repeat` `repeat-x` `repeat-y`
8. `background-attachment:`  `scroll` `fixed` `local`


## Multiple backgrounds:
background: linear-gradient(to bottom, rgba(0, 0, 0, 0.5), rgba(0, 0, 0, 0.5)),
  url('background.jpg') center center / cover, #333;


# Animation

## Properties
1. `animation:`	(shorthand)
2. `animation-name:`	`<name>`
3. `animation-duration:`	`<time>ms`
4. `animation-timing-function:`	`ease` `linear` `ease-in` `ease-out` `ease-in-out`
5. `animation-delay:`	`<time> ms`
6. `animation-iteration-count:` `infinite` `<number>`
7. `animation-direction:` `normal`  `reverse`  `alternate`  `alternate-reverse`
8. `animation-fill-mode:` `none`  `forwards`  `backwards`  `both`  `initial`  `inherit`
9. `animation-play-state:` `normal`  `reverse`  `alternate`  `alternate-reverse`

## Example:
* animation: bounce 300ms linear 0s infinite normal;
* animation: bounce 300ms linear infinite;
* animation: bounce 300ms linear infinite alternate-reverse;
* animation: bounce 300ms linear 2s infinite alternate-reverse forwards normal;

# Event
`.one('webkitAnimationEnd oanimationend msAnimationEnd animationend')`
