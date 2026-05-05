
# [Xpath cheatsheet](https://devhints.io/xpath)


<!-- TOC -->
* [XPath cheatsheet](#xpath-cheatsheet)
    * [Online XPath Tester](#online-xpath-tester)
    * [Selectors](#selectors)
    * [Axes](#axes)
    * [Functions](#functions)
    * [Predicates](#predicates)
<!-- TOC -->

# XPath Cheatsheet

### Online XPath Tester
- https://extendsclass.com/xpath-tester.html
- http://www.whitebeam.org/library/guide/TechNotes/xpathtestbed.rhtm
- **Browser console**: `$x("//div")` - Works in Firefox and Chromium

### Selectors

**Descendant selectors**
| CSS | XPath |
|-----|-------|
| `h1` | `//h1` |
| `div p` | `//div//p` |
| `ul > li` | `//ul/li` |
| `ul > li > a` | `//ul/li/a` |
| `div > *` | `//div/*` |
| `:root` | `/` |

**Attribute selectors**
| CSS | XPath |
|-----|-------|
| `#id` | `//*[@id="id"]` |
| `.class` | `//*[@class="class"]` |
| `input[type="submit"]` | `//input[@type="submit"]` |
| `a[rel]` | `//a[@rel]` |
| `a[href^='/']` | `//a[starts-with(@href, '/')]` |
| `a[href$='pdf']` | `//a[ends-with(@href, '.pdf')]` |
| `a[href*='://']` | `//a[contains(@href, '://')]` |

**Order selectors**
| CSS | XPath |
|-----|-------|
| `ul > li:first-of-type` | `//ul/li[1]` |
| `ul > li:last-of-type` | `//ul/li[last()]` |
| `ul > li:nth-of-type(2)` | `//ul/li[2]` |

**Siblings**
| CSS | XPath |
|-----|-------|
| `h1 ~ ul` | `//h1/following-sibling::ul` |
| `h1 + ul` | `//h1/following-sibling::ul[1]` |

**jQuery equivalents**
| CSS | XPath |
|-----|-------|
| `$('ul > li').parent()` | `//ul/li/..` |
| `$('li').closest('section')` | `//li/ancestor-or-self::section` |
| `$('a').attr('href')` | `//a/@href` |
| `$('span').text()` | `//span/text()` |

**Other expressions**
| Description | XPath |
|-------------|-------|
| Not attribute | `//h1[not(@id)]` |
| Text match | `//button[text()="Submit"]` |
| Text substring | `//button[contains(text(),"Go")]` |
| Arithmetic | `//product[@price > 2.50]` |
| Has children | `//ul[*]` |
| Has specific child | `//ul[li]` |
| Or logic | `//a[@name or @href]` |
| Union | `//a | //div` |

### Axes

**Axis abbreviations**
| Axis | Abbrev | Example |
|------|--------|---------|
| child | (implicit) | `//ul/li` |
| descendant | `//` | `//div//p` |
| attribute | `@` | `//a[@href]` |
| self | `.` | `./a` |
| parent | `..` | `//ul/li/..` |
| following-sibling | - | `//h1/following-sibling::ul` |
| preceding-sibling | - | - |
| ancestor | - | `//li/ancestor::ul` |
| ancestor-or-self | - | `//li/ancestor-or-self::section` |

**Prefixes**
| Prefix | Example | What |
|--------|---------|------|
| `//` | `//hr[@class='edge']` | Anywhere (descendant-or-self) |
| `./` | `./a` | Relative (self) |
| `/` | `/html/body/div` | Root (child) |

### Functions

**Node functions**
- `name()` - `//*[starts-with(name(), 'h')]`
- `text()` - `//button[text()="Submit"]`
- `count()` - `count(//*)` or `//table[count(tr)=1]`
- `position()` - `//ol/li[position()=2]`

**String functions**
- `contains()` - `//a[contains(@href, '://')]`
- `starts-with()` - `//a[starts-with(@href, '/')]`
- `ends-with()` - `//a[ends-with(@href, '.pdf')]`
- `concat()` - `concat($var1, $var2)`
- `normalize-space()` - `normalize-space(text())`
- `string-length()` - `string-length(text())`

**Boolean functions**
- `not()` - `//h1[not(@id)]`

**Type conversion**
- `string()`, `number()`, `boolean()`

### Predicates

**Indexing**
```xpath
//a[1]                  # first <a>
//a[last()]             # last <a>
//ol/li[2]              # second <li>
//ol/li[position()=2]   # same as above
//ol/li[position()>1]   # except first
```

**Class check (complex)**
```xpath
//div[contains(concat(' ', normalize-space(@class), ' '), ' foobar ')]
```

**Chaining order matters**
```xpath
a[1][@href='/']         # first, then filter
a[@href='/'][1]         # filter then first
```

**Nesting**
```xpath
//section[.//h1[@id='hi']]
```

**Examples**
```xpath
//*                     # all elements
(//h1)[1]/text()        # text of first h1
//li[span]              # li containing span
//ul/li/..              # select parent
//section[h1[@id='section-name']]     # directly contains
./ancestor-or-self::[@class="box"]   # closest ancestor
```

