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
  - Evening
    ( ) Watch a movie
    (x) Hang out with friends
    ( ) Study
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

### Radios
Radio boxes are special kinds of tasks that work in groups. Upon checking a radio box all other boxes in a group are going to be unchecked. A group of radio boxes is based on indentation (same level for all boxes in a group) and on proximity (a line without a radio box breaks the group).

Radio boxes are not taken into account when counting the number of tasks for a section.

```
- Section
  ( ) Either one
  (x) Or the other
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

### Tables
Vorg supports tables. Any line that starts and ends with a pipe symbol **|** will be treated as a table row.
Tables feature automated aligning, cell text objects, cell navigation and exporting.

```
| Person | Phone       | Email          |
|--------|-------------|----------------|
| Frank  | 123 456 789 | frank@mail.com |
| Rob    | 555 556 557 | rob@mail.com   |
```

Shortcuts
---------

### insert mode
- **-[** begin a new task as list item
- **-[** begin a new radio as list item
- **[[** begin a new task as free text
- **((** begin a new radio as free text
- **dd** add the current date
- **dt** add the current datetime
- **dl** add the current datetime as a log entry
- **dn1 to dn7** add the date of the next closest weekday (monday to sunday)
- **dp1 to dp7** add the date of the previous closest weekday (monday to sunday)

### normal mode
- **-** fold or unfold a section
- **?** fold or unfold a section recursively
- **cx** toggle a task checkbox (works with count)
- **=** force table alignment
- **<Tab>** jump to next table cell
- **<Shift-Tab>** jump to previous table cell

### visual mode
- **cx** toggle all checkboxes in lines

### text objects
- **ic** inner table cell
- **ac** outer table cell

Commands
--------
These commands are not bound to a specific keymap

- **VorgTableExport** - exports a table under cursor to a prompted format. Currently supported formats are csv and json
- **VorgGather** - search for a prompted word inside a current file, put results into a quickfix list
- **VorgGatherAll** - search for a prompted word inside vorg files, recursively, put results into a quickfix list

The quickfix list opened by some of these commands has the following custom key maps:
- **o** - jump to line
- **q** - close the window

Constructs
----------
Using special notation can cause some parts of a vorg file to have special meaning
- **|...|** a table
- **!date** a deadline
- **... | datetime** a timestamp (log entry)
- **// ...** a comment
- **#tag** a tag

Indentation
-----------
A valid vorg file uses (exactly) 2 spaces to indent items. This scheme ensures your files will be readable in any editor.
This is not a technical constraint. It is an aesthetic constraint designed to make sure vorg files are easy to read.

