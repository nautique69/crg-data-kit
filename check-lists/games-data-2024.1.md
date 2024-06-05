# Games Data Checklists <span style="color: #aaa; font-style: italic; font-size: 16px !important;">v2024.1</span>

<style>
    h1 {
        font-size: 50px !important;
    }
    h2 {
        font-size: 40px !important;
    }
    h3 {
        font-size: 30px !important;
    }
    * {
        font-size: 20px !important;
    }
    input[type="checkbox"] {
        transform: scale(2);
        margin-right: 1em;
    }
    li { 
        list-style-type: none;
        line-height: 40px;
    }
</style>

<div style="page-break-after: always"></div>

## Equipment

- [ ] Main server Pi 1
- [ ] Main server Pi 2
- [ ] Score display Pi 1
- [ ] Score display Pi 2
- [ ] Bench display Pi 1
- [ ] Bench display Pi 2
- [ ] Penalty box Pi
- [ ] Stats Pi
- [ ] Proxy Pi
- [ ] JamCam
- [ ] Tripod
- [ ] Telescopic lens
- [ ] Wide angle lens
- [ ] 4 x Portable monitors

<div style="page-break-after: always"></div>

## Addresses

### Scoreboard
- Main control: http://scoreboard/
- Current live machine: http://scoreboard:8080/live
- Current staging machine: http://scoreboard:8080/staging
- SSH: pi@scoreboard
### Main server 1
- Main control: http://scoreboard1/
- SSH: pi@scoreboard1
### Main server 2
- Main control: http://scoreboard2/
- SSH: pi@scoreboard2
### Score display 1
- SSH: pi@scoredisplay1
### Score display 2
- SSH: pi@scoredisplay2
### Bench 1
- SSH: pi@bench1
### Bench 2
- SSH: pi@bench2
### Penalty box
- SSH: pi@penaltybox
### Stats/files
- SSH: pi@stats
- Files: http://stats:8080/
### JamCam
- SSH: pi@jamcam

<div style="page-break-after: always"></div>

## Scripts

### Connect to Pi

To connect to a Pi, open a Terminal and use:

`ssh pi@[address]`

For example, to connect to the penalty box Pi you would run:

`ssh pi@penaltybox`

### Restart Pi

To restart any Pi, run the following when connected to it:

`sudo reboot`

### Toggle live scoreboard

To toggle which scoreboard is live, connect to `pi@scoreboard` and run:

`~/toggle.sh`

### Enable scoreboard

If the proxy server is restarted, you must enable the scoreboard before http://scoreboard/ will be available. To do this, connect to `pi@scoreboard` and run:

`sudo nginx`

<div style="page-break-after: always"></div>

## Before event

- [ ] Put router in elevated position
- [ ] Put proxy, scoreboard 1, and scoreboard 2 Pis on GDM table
- [ ] Connect stats Pi to portable screen and setup on announcers' table
- [ ] Connect bench Pi 1 to portable screen and setup in home bench
- [ ] Connect bench Pi 2 to portable screen and setup in away bench
- [ ] Connect penalty Pi to portable screen and setup in penalty box
- [ ] Put scoreboard laptop, keyboard, and mouse on SBO table
- [ ] Put GDM laptop on GDM table
- [ ] Connect score display(s) to projector(s)
- [ ] Attach JamCam to tripod and setup to view jam line from opposite side to SBO desk

<div style="page-break-after: always"></div>

## Start of day

- [ ] Power on router
- [ ] Power on GDM laptop and connect to `DerbyStats` network
- [ ] Power on main servers and proxy
- [ ] Connect to proxy (`pi@scoreboard`) and run `sugo nginx`
- [ ] Run scoreboard controller on GDM laptop
- [ ] Ensure that the correct server is currently live
- [ ] Power on bench and penalty box Pis and ensure they connect to the network and display the penalty whiteboard
- [ ] Power on the announcers' Pi and ensure it connects to the network and displays JamStats
- [ ] Power on JamCam and start video stream
- [ ] Power on JamCam tablet and connect to video stream
- [ ] Attach lens to JamCam and adjust focus
- [ ] Put JamCam tablet on SBO table
- [ ] Power on SBO laptop, connect to `DerbyStats` network, and open `http://scoreboard/` in Chrome
- [ ] Power on ePLT tablets, switch to `Derby` account, and open Chrome to PLT page
- [ ] Power on projector(s) and score display(s) and ensure they dispay the correct scoreboard
- [ ] Start backup service on GDM laptop

<div style="page-break-after: always"></div>

## During game

- [ ] Export stats from previous game, if present, and copy to file server
- [ ] Use scoreboard controller to clean staging scoreboard
- [ ] Import statsbook for next game into _staging_ scoreboard
  
_After captains' meeting_

- [ ] Connect to _staging_ scoreboard and mark non-skating skaters as such

<div style="page-break-after: always"></div>

## Between games

- [ ] Take photo of final score
- [ ] Put ePLT tablets on charge
- [ ] Start game on _staging_ server
- [ ] Confirm start time of next game and ensure 'Time to derby' on _staging_ server is correct

_After enough time for people to view the scoreboard (5 minutes?)_

- [ ] Toggle live and staging scoreboard
- [ ] Ensure score displays, SBO laptop, and penalty displays show correct game

_Just before start of game_

- [ ] Provide ePLT tablets to PLTs

<div style="page-break-after: always"></div>

## End of day

- [ ] Power off all tablets
- [ ] Power off all laptops
- [ ] Power off all Pis
- [ ] Power off router
- [ ] Remove lens from JamCam and attach lens caps

<div style="page-break-after: always"></div>

## After event

- [ ] Collect all equipment