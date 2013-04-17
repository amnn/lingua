$ ->
    $( '.vkeyboard-target' ).blur(  (e) -> window.vKBTarget = $(this) )

    $( '.vkeyboard .btn' ).click( (e) ->

        e.preventDefault( )
        e.stopPropagation()
        key = this.firstChild.nodeValue

        if window.vKBTarget?
            target =     window.vKBTarget
            val    =         target.val()
            pos    = target.caret().start
            newStr = [val.slice(0, pos), key, val.slice(pos)].join('')

            target.val( newStr ).caret( pos+1, pos+1 )
            target[0].focus()

    )


