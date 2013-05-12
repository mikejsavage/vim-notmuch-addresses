fun! MatchEmails( findstart, base )
	if a:findstart
		let line = getline( '.' )
		let start = col( '.' ) - 1

		while start > 0 && line[ start - 1 ] =~ '\S'
			let start -= 1
		endwhile

		return start
	endif

	let matches = [ ]

	for m in split( system( 'grep -i ' . shellescape( a:base ) . ' ~/.config/nottoomuch/addresses.active' ), '\n' )
		call add( matches, m )
	endfor

	return matches
endfun

fun! AddressComplete( findstart, base )
	let line = getline( line( '.' ) )

	if line =~ '^\(To\|Cc\|Bcc\|From\|Reply-To\):'
		return MatchEmails( a:findstart, a:base )
	endif
endfun

set omnifunc=AddressComplete
