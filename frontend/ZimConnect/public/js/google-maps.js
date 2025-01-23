function initMap() {
    const location = { lat: -17.8292, lng: 31.0522 }; // Harare, Zimbabwe coordinates
    const map = new google.maps.Map(document.getElementById('map'), {
        zoom: 15,
        center: location
    });

    const marker = new google.maps.Marker({
        position: location,
        map: map,
        title: 'ZimConnect Headquarters'
    });
}
