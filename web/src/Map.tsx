import mapboxgl from 'mapbox-gl';
import {useEffect, useRef} from "react"; // or "const mapboxgl = require('mapbox-gl');"


export const Map = () => {
    const mapRef = useRef<mapboxgl.Map>()

    useEffect(() => {
        mapboxgl.accessToken = 'pk.eyJ1IjoiYW1tYW52ZWRpIiwiYSI6IkdJa1NubU0ifQ.eq7TdMagDvLgXz8BSrciXA';
        const map = new mapboxgl.Map({
            container: 'map', // container ID
            style: 'mapbox://styles/mapbox/streets-v11', // style URL
            center: [-74.5, 40], // starting position [lng, lat]
            zoom: 15, // starting zoom
        });

        mapRef.current = map

        const geoControl = new mapboxgl.GeolocateControl({
            positionOptions: {
                enableHighAccuracy: true

            },
            fitBoundsOptions: {
              zoom: 18,
                maxDuration: 0
            },
// When active the map will receive updates to the device's location as it changes.
            trackUserLocation: true,
// Draw an arrow next to the location dot to indicate which direction the device is heading.
            showUserHeading: true
        })

        map.addControl(
            geoControl
        );

        map.on('load', function () {

            geoControl.trigger()


        });
    }, [])

    const onTargetClick = () => {

        const {current: map} = mapRef
        if(!map) {
            return;
        }

        const center = map.getCenter()
        const marker1 = new mapboxgl.Marker()
            .setLngLat(center)
            .addTo(map);
    }

    return (
        <>
            <div style={{
                position: 'fixed',
                top: 0,
                bottom: 0,
                left: 0,
                right: 0,
            }} id='map' />
            <div onClick={onTargetClick} style={{
                top: '50%',
                left: '50%',
                transform: 'translate(-50%, -50%)',
                position: 'absolute',
                width: 20,
                height: 20,
                backgroundColor: 'red'
            }} />
        </>

    )
}

