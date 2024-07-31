#!/bin/sh
docker login
docker build -t joaogsleite/smb .
docker tag joaogsleite/smb joaogsleite/smb:4.18.9
docker push joaogsleite/smb:4.18.9