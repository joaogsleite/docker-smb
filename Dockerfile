FROM alpine:3.19.1

RUN apk update && \
    apk add --no-cache samba

COPY entrypoint.sh /entrypoint.sh
COPY smb.conf /etc/samba/smb.conf

RUN chmod +x /entrypoint.sh

CMD ["/entrypoint.sh"]