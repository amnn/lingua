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
    
                type     :                                      'PUT',
                url      :                            "/rate/#{ id }",

                data     : { 

                    score   : score 

                },

                dataType :                                    "json",
                success  : ( data, stat ) -> location.reload( true )
    
            }

            console.log( "Sent request #{ id }" )

    )


turnOnStar = (star, enabled) ->
    $(star).removeClass().addClass "rating #{if enabled then 'icon-star' else 'icon-star-empty'}"

