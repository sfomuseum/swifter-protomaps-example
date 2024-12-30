var map_el = document.getElementById("map");
map_el.innerText = "Loading map";

var xhr = new XMLHttpRequest();
xhr.open('HEAD', "http://localhost:9001/");
xhr.onreadystatechange = function() {
    if (this.readyState == this.DONE) {
        
        map_el.innerHTML = "";
        const map = L.map('map');
            
        const tile_url = "http://localhost:9001/pmtiles/sfo_v3.pmtiles";
        const tile_theme = "white";
        const tile_bounds = [ [37.601617, -122.408061], [37.640167, -122.354907] ];
        const tile_layer = protomapsL.leafletLayer({url: tile_url, theme: tile_theme});
            
        tile_layer.addTo(map);
        map.fitBounds(tile_bounds);
    }
};

xhr.send();


