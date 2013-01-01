$ ->
    $( '#filter_select_all' ).click  -> $( '[id^=lang_]' ).prop( 'checked',  true )

    $( '#filter_select_none' ).click -> $( '[id^=lang_]' ).prop( 'checked', false )

    $( '#filter_reset' ).click       -> 

        $( '[id^=lang_]'   ).prop( 'checked',  true ) # Languages
        $( '#my_lists'     ).prop( 'checked',  true ) # My Lists
        $( '#public_lists' ).prop( 'checked', false ) # Public Lists
        # Send get request for js to update lists list