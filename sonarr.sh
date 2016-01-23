#!/bin/sh
exec /sbin/setuser nobody mono /opt/NzbDrone/NzbDrone.exe -data=/volumes/config/sonarr
