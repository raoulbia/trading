// https://github.com/kelaberetiv/TagUI/issues/485

function pad2(n) { // return 2-character string
    return (n < 10 ? '0' : '') + n;
}

function timestamp() { // return YYMMDDHHMMSS string
    var d = new Date();
    return d.getFullYear().toString() + "-" +
        pad2(d.getMonth() + 1) + "-" +
        pad2(d.getDate()) 
        //pad2(d.getHours()) + ":" +
        //pad2(d.getMinutes()) //+
        //pad2(d.getSeconds())
        ;
}

