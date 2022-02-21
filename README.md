Vorg
====
A plain text organizer for ViM

Format
------
The vorg format is designed to be easy on the eyes and readable
in any text editor.
It works for any text based file formats, but using Markdown is recommended.

```
- Today
  - [ ] Call Tom #office #2m
  - [ ] Pick-up my laundry #car #30m
- Someday
  - [ ] Read "Getting Things Done" #book
  - [ ] Watch "Men Of Valor" #movie

# Logbook

## 2012
  2012-10-23 Found a nice CSS tool #tools
```

### Tasks
Vorg supports and automates task tracking.  Existing mappings help with checkbox
creation and manipulation.

A folded section text will show the number of open tasks.

### Tags
Sections and tasks can be tagged. Tags can be used to indicate context
or category and are important when you need to gather items from
a large set of long vorg files.

```
- Section @tag1 @tag2
  - [ ] My Task @tag3
```

Shortcuts
---------

### insert mode
- **-[** begin a new task as list item
- **[[** begin a new task as free text
- **dl** add a logbook note
- **dd** add the current date
- **dt** add the current datetime
- **dd1 to dd9** add the date of today-plus-N-days
- **dw1 to dw9** add the date of today-plus-N-weeks
- **dm1 to dm9** add the date of first day of the next Nth month
- **dy1 to dy9** add the date of first day of this month plus N years

### normal mode
- **<Leader>f** Open the quickfix window with all TODO ([ ]) and in progress ([.]) tasks.
- **<Leader>r** Open the quickfix window with all in progress ([.]) tasks.

To mark a checkbox and set the corresponding datetime:
- **<leader>z** [ ] zero, no datetime
- **<leader>x** [x] crossed, set '=YYYY-MM-DD'
- **<leader>-** [-] cancelled, set '$YYYY-MM-DD'
- **<leader>.** [.] in progress, set '.YYYY-MM-DD'

Commands
--------

Constructs
----------
Using special notation can cause some parts of a vorg file to have special
meaning:
- **@tag** a tag
- **!date** a deadline
  **^date** creation date
  **=date** completion date
  **.date** started date
  **$date** cancellation date

Dates
-----
Vorg file uses dates in format: **YYYY-MM-DD @ HH:II**, with the '@' part (the
hours and minutes) optional.  The plugin will try to normalize the date (not the
time) part, but it's best to keep this convention.

Vim requirements
----------------
TBD.
Required Vim version 8

Authors
---------------
The plugin was originally developed by Ithai Levi <https://github.com/rlofc>
Forked and currently maintained by Bartosz Jarzyna <https://github.com/brtastic>
Again forked and drastically hacked upon by Jisk Attema <https://github.com/jiskattema>
