$ ->
    $('.star-rating').mouseleave( (e) ->
            
            $(this).children( '.rating' ).each (i,e) -> turnOnStar this, ($(this).data( 'on' ) == 1)

    )

    $('.star-rating .rating').mouseenter( (e) ->
            pos = $(this).index()
    
            $( '.star-rating' ).children( '.rating' ).each (i,e) -> turnOnStar this, (i <= pos )

    )

    $('.star-rating .rating').click( (e) ->
    
            id    = $( '.star-rating' ).data( 'id' )
            score = 1 + $( this ).index(           )

            $.ajax {
    
                type     :                                     'PUT',
                url      :                           "/rate/#{ id }",

                data     :                         { score : score },

                dataType :                                    "json",
                success  : ( data, stat ) -> location.reload( true )
    
            }

    )

    $( '.sort-column' ).click( (e) ->

        new_col  = $(this).data( 'column' )
        curr_col = $('#sortBy').val(      )

        dir      = if new_col == curr_col then {

            asc  : 'desc', 
            desc :  'asc'

        }[ $('#dir').val() ] else 'asc'


        console.log( new_col, curr_col, dir )

        $( '#sortBy' ).val( new_col )
        $(    '#dir' ).val(     dir )

        $( '#filter_apply' ).click( )

    )


turnOnStar = (star, enabled) ->
    $(star).removeClass().addClass "rating #{if enabled then 'icon-star' else 'icon-star-empty'}"

