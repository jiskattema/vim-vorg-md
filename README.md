Vorg
====
The plain text organizer for ViM

Format
------
The vorg format is designed to be easy on the eyes and readable
in any text editor.

```
- Today
  - [ ] Call Tom #office #2m
  - [ ] Pick-up my laundry #car #30m
- Someday
  - [ ] Read "Getting Things Done" #book
  - [ ] Watch "Men Of Valor" #movie
- Logbook
  2012-10-23 @ 12:00 | Found a nice CSS tool #tools
```

### Sections
Vorg is a hierarchical file format. You organize your notes, tasks and text in sections, sub-sections, sub-sub-sections etc.
The plugin will automatically fold sections based on their indentation level.

### Tasks
Vorg supports and automates task tracking. Existing mappings help with checkbox creation. Tasks can be toggled with **cx** mapping, both individually and in groups (visual mode or range)

A folded section text will show the number of tasks completed and total tasks, for example [ 3 / 5 ]

```
- Section
  - Sub-Section
     [ ] First Priority Task
     [x] Second Priority Task
```

### Free Text
Sections and tasks can contain any number of lines of free text
on the same level of indentation.

```
- Section
  Lorem ipsum dolor sit amet, consectetur adipisicing elit,
  sed do eiusmod tempor incididunt ut labore et dolore
  magna aliqua.
```

### Tags
Sections and tasks can be tagged. Tags can be used to indicate context
or category and are important when you need to gather items from
a large set of long vorg files.

```
- Section #tag1 #tag2
  - [ ] My Task #tag3
```

### Agenda
Vorg allows you to show an additional window that summarizes the scheduled dates and deadlines in your file. Use **?** to show the agenda window.
When inside the window, use **o** to jump to line containing the scheduled item. Use **q** to close the window.
Only dates prepended with **~** or **!** will be taken into account in the agenda window.

Shortcuts
---------

### insert mode
- **-[** begin a new task as list item
- **[[** begin a new task as free text
- **dd** add the current date
- **dt** add the current datetime
- **dd1 to dd9** add the date of today-plus-N-days
- **dw1 to dw9** add the date of today-plus-N-weeks
- **dm1 to dm9** add the date of first day of the next Nth month
- **dy1 to dy9** add the date of first day of this month plus N years

### normal mode
- **<CR>** fold or unfold a section
- **?** show agenda

### agenda and quickfix windows
- **o** jump to line
- **q** close the window

To mark a checkbox and set the corresponding datetime:
- **<leader>z** [ ] zero, no datetime
- **<leader>x** [x] crossed, set '=YYYY-MM-DD'
- **<leader>c** [-] cancelled, set '$YYYY-MM-DD'
- **<leader>v** [.] no mnemonic, set '.YYYY-MM-DD'


Commands
--------
These commands are not bound to a specific keymap

- **VorgGather** - search for a prompted word inside a current file, put results into a quickfix list
- **VorgGatherAll** - search for a prompted word inside vorg files, recursively, put results into a quickfix list

Constructs
----------
Using special notation can cause some parts of a vorg file to have special meaning
- **#tag** a tag
- **!datetime** a deadline
- **~datetime** a scheduled date
- **// ...** a comment

Indentation
-----------
A valid vorg file uses (exactly) 2 spaces to indent items. This scheme ensures your files will be readable in any editor.
This is not a technical constraint. It is an aesthetic constraint designed to make sure vorg files are easy to read.

Dates
-----
Vorg file uses dates in format: **YYYY-MM-DD @ HH:II**
The plugin will try to normalize the date (not the time) part, but it's best to keep this convention.

Vim requirements
----------------
TBD.
Required Vim version 8

Authors
---------------
The plugin was originally developed by Ithai Levi <https://github.com/rlofc>
Forked and currently maintained by Bartosz Jarzyna <https://github.com/brtastic>
