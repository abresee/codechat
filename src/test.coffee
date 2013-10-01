options =
    highlight: (code, lang) -> hljs.highlight(lang, code).value
    gfm: true
    breaks: true
    sanitize: false

marked.setOptions options

render = () ->
    $("#output").html marked $("#input").val()
    return

init = () ->
    $("#input").keypress render  
    render()
    return

$(document).ready init
