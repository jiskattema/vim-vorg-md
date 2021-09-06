function! vorg#dates#nextWeekdayTimestamp(nDays)
	let dir  = a:nDays < 0 ? -1 : 1
	let day  = abs(a:nDays) % 7
	let sday = 60 * 60 * 24 * dir
	let time = localtime() + sday
	while strftime('%w', time) != day
		let time += sday
	endwhile
	return time
endfunction

function! vorg#dates#nextWeekday(nDays)
	return strftime('%Y-%m-%d', vorg#dates#nextWeekdayTimestamp(a:nDays))
endfunction

" Go to the first day of the nth next month
function! vorg#dates#nextMonth(nMonths)
  let year = strftime('%Y', localtime())
  let month = strftime('%m', localtime())
  let day = 1

  let month += a:nMonths
  while month > 12
    let year += 1
    let month -= 12
  endwhile

  return printf('%04d-%02d-%02d', year, month, day)
endfunction

" Add a full year to current date
function! vorg#dates#nextYear(nYears)
  let year = strftime('%Y', localtime())
  let month = strftime('%m', localtime())
  let day = 1

  let year += a:nYears

  return printf('%04d-%02d-%02d', year, month, day)
endfunction

function! vorg#dates#today()
	return strftime('%Y-%m-%d', localtime())
endfunction

function! vorg#dates#normalize(date, ...)
	let date = split(a:date, "-")
	if strlen(date[2]) == 4
		let [date[0], date[2]] = [date[2], date[0]]
	endif
	return join(date, a:0 > 0 ? a:1 : "-")
endfunction

function! vorg#dates#compare(d1, d2)
	let dates = []
	for date in [a:d1, a:d2]
		call add(dates, vorg#dates#normalize(date, ""))
	endfor
	return dates[0] - dates[1]
endfunction

function! vorg#dates#commonName(date)
	let date_dist = vorg#dates#compare(a:date, vorg#dates#today())

	let date = a:date
	if date_dist == -1
		let date = "Yesterday"
	elseif date_dist == 0
		let date = "Today"
	elseif date_dist == 1
		let date = "Tomorrow"
	elseif date_dist > 0 && date_dist < 7
		let date = substitute(strftime("%A", vorg#dates#nextWeekdayTimestamp(date_dist)), '\<.', '\u&', "")
	endif

	return date
endfunction
