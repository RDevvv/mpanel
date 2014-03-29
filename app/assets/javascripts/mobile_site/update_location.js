function update_location(location){
    links = $('.filldiv');
    for(i=0;i<links.length;i++){
        url = $(links[i]).attr('href').split('?');
        parsed = queryString.parse(url[1]);
        parsed.location = location;
        new_href = '/outlet_search?'+queryString.stringify(parsed);
        $(links[i]).attr('href',new_href);
    }
}
