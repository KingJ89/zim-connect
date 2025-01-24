async function initMap() {
    try {
        const response = await fetch('http://localhost:3000/api/locations');
        const location = await response.json();

        const map = new google.maps.Map(document.getElementById('map'), {
            zoom: 15,
            center: { lat: location.latitude, lng: location.longitude }
        });

        new google.maps.Marker({
            position: { lat: location.latitude, lng: location.longitude },
            map: map,
            title: 'ZimConnect Headquarters'
        });
    } catch (error) {
        console.error('Error fetching location data:', error);
    }
}
