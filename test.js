hl = function (code, lang) {
    var out = hljs.highlight(lang, code).value;
    alert(out);
    return out;
}

options = {
    highlight: hl,
    gfm: true,
    breaks: true,
    sanitize: false
};

marked.setOptions(options);

initialize = function() {
    var input = "``` python \ndef lol(): \n\treturn False; \n```"
    var output = marked(input);
    $("#output").append(output);
};

