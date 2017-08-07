FROM python:3.5-alpine

EXPOSE 3141
ENV DEVPI_ROLE "standalone"
ENV DEVPI_SERVERDIR "/opt/devpi"
VOLUME $DEVPI_SERVERDIR

RUN apk add --update-cache libffi \
 && apk add --virtual .deps musl-dev gcc libffi-dev \
 && pip3 install devpi-server \
 && apk del --purge .deps \
 && rm -fr /root/.cache /var/cache/apk
ADD entrypoint.sh /app/entrypoint.sh
RUN chmod a+x /app/entrypoint.sh
ENTRYPOINT ["/app/entrypoint.sh"]
