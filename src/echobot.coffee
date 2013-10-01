BOSH_SERVICE = 'http://localhost/http-bind'

connection = null

log = (msg) ->
    $('#log').append "<div>#{msg}</div>"

onConnect = (status) ->
    if status is Strophe.Status.CONNECTION
        log 'Strophe is connecting.'

    else if status is Strophe.Status.CONNFAIL
        log 'Strophe failed to connect.'
        $('#connect').get(0).value = 'connect'

    else if status is Strophe.Status.DISCONNECTING
        log 'Strophe is disconnecting.'

    else if status is Strophe.Status.DISCONNECTED
        log 'Strophe is disconnected.'
        $('#connect').get(0).value = 'connect'

    else if status is Strophe.Status.CONNECTED
        log 'Strophe is connected.'
        log "ECHOBOT: Send a message to #{connection.jid} to talk to me."
        connection.addHandler onMessage, null, 'message', null, null, null 
        connection.send $pres().tree()

onMessage = (msg) ->
    to = msg.getAttribute 'to'
    from = msg.getAttribute 'from'
    type = msg.getAttribute 'type'
    elems = msg.getElementsByTagName 'body'

    if type is 'chat' and elems.length > 0
        body = elems[0]
        hey = Strophe.getText body
        ho = "Na Nah Hey Hey, #{hey}, ho, ho #{hey}"

        log "ECHOBOT: I got a message from #{from}: #{hey}"

        reply = $msg(
            to: from
            from: to
            type: 'chat'
        ).c 'body', null, ho
        connection.send reply.tree()

        log "ECHOBOT: I sent #{from}: #{ho}"

    true

$ = jQuery

$(document).ready ->
    connection = new Strophe.Connection BOSH_SERVICE
    
    #connection.rawInput = (data) -> log "RECV: #{data}"
    #connection.rawOutput = (data) -> log "SEND: #{data}"
    #Strophe.log = (level,msg) -> log "LOG: #{msg}"

    $('#connect').bind 'click', -> 
        button = $('#connect').get 0
        if button.value is 'connect'
            button.value = 'disconnect'
            jid = 'echo@localhost'
            pass = 'a'
            connection.connect jid, pass, onConnect
        else
            button.value = 'connect'
            connection.disconnect()

