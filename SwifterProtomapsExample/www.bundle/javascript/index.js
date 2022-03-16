var xhr = new XMLHttpRequest();
xhr.open('HEAD', "http://localhost:9001/");
xhr.onreadystatechange = function() {
    if (this.readyState == this.DONE) {
        console.log("HELLO WORLD", this.status);
    }
};

xhr.send();

const map = L.map('map');

const p = new protomaps.PMTiles("http://localhost:9001/pmtiles/sfo.pmtiles");

p.metadata().then(m => {
    let bounds_str = m.bounds.split(',');
    let bounds = [[+bounds_str[1],+bounds_str[0]],[+bounds_str[3],+bounds_str[2]]];
    layer = new protomaps.LeafletLayer({attribution:'<a href="https://protomaps.com">Protomaps</a> © <a href="https://openstreetmap.org/copyright">OpenStreetMap</a>',url:p,bounds:bounds})
    layer.addTo(map);
    map.fitBounds(bounds);
})
