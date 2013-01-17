# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ -> 

    $('#test_word').keyup( (e) -> checkWord() if e.keyCode == 13 )

    nextWord()
    

nextWord = () ->
    if !testData then return

    progress = $( '#test-progress' )
    question = $( '#test_question' )
    word     = $(     '#test_word' )

    progress.html( Math.ceil( 100 * testQ / testData.words.length ) + '%')
    question.html(                      testData.words[ testQ ].question )
    word.closest( '.control-group' ).removeClass(                'error' )

    word.val('')

checkWord = () ->

    if correction 
        window.correction = false

        testQ += 1
        nextWord()
        return

    ansField = $(            '#test_word' )
    word     = ansField.val().toLowerCase()


    $.ajax {
        type     :                              'PUT',
        url      :                     "/test/update",

        data     : { 
            item_id : testData.words[ testQ ].item_id, 
            ans     :                    testData.ans
        },

        dataType :                             "json",
        success  : ( data, stat ) ->

            if hex_md5( word ) == testData.words[ testQ ].answer

                testQ += 1
                if testQ < testData.words.length
                    nextWord()
                else
                    window.location = '/lists/' + testData.id

            else
                window.correction = true
                ansField.closest( '.control-group' ).addClass( 'error' )
                ansField.val( data.correct )
    }

    

    
