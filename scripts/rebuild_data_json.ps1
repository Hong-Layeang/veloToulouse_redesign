$ErrorActionPreference = 'Stop'
$path = 'lib/data/example/data.json'

$subscriptions = @(
    @{id = 'day_pass'; label = 'Day Pass'; description = 'Unlimited 30 minutes rides`nValid for 24 hours'; price = 3; durationSeconds = 86400; rideDurationSeconds = 1800 },
    @{id = 'monthly_pass'; label = 'Monthly Pass - Best Deal'; description = 'Unlimited 45 minutes rides`nValid for 1 month'; price = 25; durationSeconds = 2592000; rideDurationSeconds = 2700 },
    @{id = 'annual_pass'; label = 'Annual Pass'; description = 'Unlimited 45 minutes rides`nValid for 1 year'; price = 50; durationSeconds = 31536000; rideDurationSeconds = 2700 }
)

$bikes = @(
    @{id = 'bike_1'; name = 'Velo Red'; imageUrl = 'https://www.cincinnatiexperience.com/wp-content/uploads/2020/05/Cincy-Redbikes.jpg' },
    @{id = 'bike_2'; name = 'Velo Blue'; imageUrl = 'https://thumbnails.thecrimson.com/photos/2022/11/30/233645_1360004.JPG.2000x1333_q95_crop-smart_upscale.jpg' },
    @{id = 'bike_3'; name = 'Velo Yellow'; imageUrl = 'https://vanderbilthustler.com/wp-content/uploads/2018/03/IMG-7187.jpg' },
    @{id = 'bike_4'; name = 'Velo Green'; imageUrl = 'https://www.cincinnatiexperience.com/wp-content/uploads/2020/05/Cincy-Greenbikes.jpg' },
    @{id = 'bike_5'; name = 'Velo Black'; imageUrl = 'https://www.cincinnatiexperience.com/wp-content/uploads/2020/05/Cincy-Blackbikes.jpg' }
)

$stationDefs = @(
    @{ id = 'station_1'; name = 'Independence Monument'; latitude = 11.5564; longitude = 104.9282; availableSlots = 4; totalSlots = 10 },
    @{ id = 'station_2'; name = 'Sisowath Quay Riverside'; latitude = 11.5700; longitude = 104.9310; availableSlots = 6; totalSlots = 10 },
    @{ id = 'station_3'; name = 'Royal Palace'; latitude = 11.5640; longitude = 104.9316; availableSlots = 3; totalSlots = 12 },
    @{ id = 'station_4'; name = 'Wat Phnom'; latitude = 11.5765; longitude = 104.9223; availableSlots = 5; totalSlots = 10 },
    @{ id = 'station_5'; name = 'Central Market (Phsar Thmei)'; latitude = 11.5697; longitude = 104.9213; availableSlots = 2; totalSlots = 14 },
    @{ id = 'station_6'; name = 'Russian Market (Phsar Toul Tom Poung)'; latitude = 11.5437; longitude = 104.9201; availableSlots = 7; totalSlots = 12 },
    @{ id = 'station_7'; name = 'Orussey Market'; latitude = 11.5608; longitude = 104.9177; availableSlots = 4; totalSlots = 10 },
    @{ id = 'station_8'; name = 'Olympic Stadium'; latitude = 11.5595; longitude = 104.9122; availableSlots = 8; totalSlots = 15 },
    @{ id = 'station_9'; name = 'National Museum'; latitude = 11.5647; longitude = 104.9303; availableSlots = 5; totalSlots = 10 },
    @{ id = 'station_10'; name = 'Wat Ounalom'; latitude = 11.5695; longitude = 104.9307; availableSlots = 3; totalSlots = 8 },
    @{ id = 'station_11'; name = 'Wat Langka'; latitude = 11.5552; longitude = 104.9232; availableSlots = 6; totalSlots = 10 },
    @{ id = 'station_12'; name = 'BKK Market'; latitude = 11.5517; longitude = 104.9198; availableSlots = 4; totalSlots = 12 },
    @{ id = 'station_13'; name = 'Tuol Sleng Genocide Museum'; latitude = 11.5492; longitude = 104.9176; availableSlots = 5; totalSlots = 10 },
    @{ id = 'station_14'; name = 'Hun Sen Park'; latitude = 11.5507; longitude = 104.9304; availableSlots = 9; totalSlots = 15 },
    @{ id = 'station_15'; name = 'Koh Pich (Diamond Island)'; latitude = 11.5469; longitude = 104.9372; availableSlots = 7; totalSlots = 14 },
    @{ id = 'station_16'; name = 'NagaWorld'; latitude = 11.5545; longitude = 104.9329; availableSlots = 6; totalSlots = 12 },
    @{ id = 'station_17'; name = 'Aeon Mall Phnom Penh'; latitude = 11.5502; longitude = 104.9323; availableSlots = 10; totalSlots = 20 },
    @{ id = 'station_18'; name = 'Chroy Changvar Bridge'; latitude = 11.5829; longitude = 104.9357; availableSlots = 4; totalSlots = 10 },
    @{ id = 'station_19'; name = 'Royal University of Phnom Penh'; latitude = 11.5685; longitude = 104.8898; availableSlots = 8; totalSlots = 16 },
    @{ id = 'station_20'; name = 'Aeon Mall Sen Sok City'; latitude = 11.6042; longitude = 104.8869; availableSlots = 11; totalSlots = 20 },
    @{ id = 'station_21'; name = 'Stung Meanchey'; latitude = 11.5246; longitude = 104.9097; availableSlots = 5; totalSlots = 10 }
)

$bikeNames = @('Velo Red', 'Velo Blue', 'Velo Yellow', 'Velo Green', 'Velo Black')
$bikeImages = @(
    'https://www.cincinnatiexperience.com/wp-content/uploads/2020/05/Cincy-Redbikes.jpg',
    'https://thumbnails.thecrimson.com/photos/2022/11/30/233645_1360004.JPG.2000x1333_q95_crop-smart_upscale.jpg',
    'https://vanderbilthustler.com/wp-content/uploads/2018/03/IMG-7187.jpg',
    'https://www.cincinnatiexperience.com/wp-content/uploads/2020/05/Cincy-Greenbikes.jpg',
    'https://www.cincinnatiexperience.com/wp-content/uploads/2020/05/Cincy-Blackbikes.jpg'
)
$prefixes = @('A', 'B', 'C', 'D')

$subsObj = @{}
foreach ($s in $subscriptions) { $subsObj[$s.id] = $s }

$bikesObj = @{}
foreach ($b in $bikes) { $bikesObj[$b.id] = $b }

$stationsObj = @{}
foreach ($st in $stationDefs) {
    $slots = @{}
    for ($i = 0; $i -lt $st.totalSlots; $i++) {
        $prefix = $prefixes[[math]::Floor($i / 5)]
        $slotId = '{0}_slot_{1}' -f $st.id, $i
        $slots[$slotId] = @{
            id          = $slotId
            slotNumber  = ('{0}{1}' -f $prefix, (($i % 5) + 1))
            isAvailable = ($i -lt $st.availableSlots)
            bikeId      = ('bike_{0}' -f ($i + 1))
            bikeName    = $bikeNames[$i % $bikeNames.Count]
            bikeImage   = $bikeImages[$i % $bikeImages.Count]
        }
    }

    $stationsObj[$st.id] = @{
        id             = $st.id
        name           = $st.name
        latitude       = $st.latitude
        longitude      = $st.longitude
        totalSlots     = $st.totalSlots
        availableSlots = $st.availableSlots
        slots          = $slots
    }
}

$out = @{
    subscriptions = $subsObj
    bikes         = $bikesObj
    stations      = $stationsObj
}

$json = $out | ConvertTo-Json -Depth 100 -Compress
[System.IO.File]::WriteAllText((Join-Path (Get-Location) $path), $json, (New-Object System.Text.UTF8Encoding($false)))

$check = Get-Content -Raw $path | ConvertFrom-Json
Write-Output ('OK subs=' + $check.subscriptions.PSObject.Properties.Count + ' bikes=' + $check.bikes.PSObject.Properties.Count + ' stations=' + $check.stations.PSObject.Properties.Count)
