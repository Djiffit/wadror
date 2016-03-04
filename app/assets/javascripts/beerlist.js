var BEERS = {};
var lastsort = "";
BEERS.show = function(){
    $("#beertable tr:gt(0)").remove();

    var table = $("#beertable");

    $.each(BEERS.list, function (index, beer) {
        table.append('<tr><td>'+beer['name']+'</td><td>'+beer['style']['name']+'</td><td>'+beer['brewery']['name']+'</td></tr>');
    });
};
BEERS.sort_by_name = function(){
    BEERS.list.sort( function(a,b){
        return a.name.toUpperCase().localeCompare(b.name.toUpperCase());
    });
};

BEERS.sort_by_style = function(){
    BEERS.list.sort( function(a,b){
        return a.style.name.toUpperCase().localeCompare(b.style.name.toUpperCase());
    });
};

BEERS.sort_by_brewery = function(){
    BEERS.list.sort( function(a,b){
        return a.brewery.name.toUpperCase().localeCompare(b.brewery.name.toUpperCase());
    });
};

$(document).ready(function () {
    $("#name").click(function (e) {
        if (lastsort != 'name') {
            BEERS.sort_by_name();
            BEERS.show();
            e.preventDefault();
            lastsort = 'name';
        } else {
            BEERS.list.reverse();
            BEERS.show();
            e.preventDefault();
            lastsort = '';
        }
    });

    $("#style").click(function (e) {
        if (lastsort != 'style') {
            BEERS.sort_by_style();
            BEERS.show();
            e.preventDefault();
            lastsort = 'style';
        } else {
            BEERS.list.reverse();
            BEERS.show();
            e.preventDefault();
            lastsort = '';
        }

    });

    $("#brewery").click(function (e) {
        if (lastsort != 'brewery') {
            BEERS.sort_by_brewery();
            BEERS.show();
            e.preventDefault();
            lastsort = 'brewery';
        } else {
            BEERS.list.reverse();
            BEERS.show();
            e.preventDefault();
            lastsort = '';
        }
    });

    $.getJSON('beers.json', function (beers) {
        BEERS.list = beers;
        BEERS.sort_by_name();
        BEERS.show();
    });

});