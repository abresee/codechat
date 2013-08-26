
options =
    highlight: (code, lang) -> hljs.highlight(lang, code).value
    gfm: true
    breaks: true
    sanitize: false

marked.setOptions options

init = () ->
    input = "``` python\ndef lol():\n\treturn False;\n```"
    output = marked input
    $("#output").append output

$(document).ready init
