$ ->
    $( '.list_form tbody' ).on( 'click', 'button.close', (e) -> 

        $(this).siblings( 'input[id$=_destroy]' ).val( "true" );
        $(this).closest(                   'tr' ).fadeOut(    );

    )

    $( '#add_definition' ).click( addFields )

inputField = (field, i, type = 'text', ph = null) -> 
    """<input id="list_list_items_attributes_#{i}_#{field}" type="#{type}" #{ if ph then "placeholder=\"#{ph}\" " else "" }name="list[list_items_attributes][#{i}][#{field}]" ></input>"""

itemForm  = (i) ->
    """
    <tr data-index="#{i}" >
        <td >
            #{ inputField 'word1_str', i, 'text', 'Word' }
        </td>
        <td>
            #{ inputField 'word2_str', i, 'text', 'Word' }
        </td>
        <td class="close-button-cell" >
            #{ inputField '_destroy', i, 'hidden' }
            <button class="close" type="button">
                &times;
            </button>
        </td>
    </tr>
    """

addFields = (e) -> 

    last_row  = $( '.list_form tr' ).last()
    new_index = 1 + last_row.data('index' )

    last_row.after(    itemForm new_index )
