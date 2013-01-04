$ ->
    $( '.list_form tbody' ).on( 'click', 'button.close', (e) -> 

        $(this).siblings( 'input[id$=_destroy]' ).val( "true" );
        $(this).closest(                   'tr' ).hide(       );

    )