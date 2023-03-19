FROM alpine:latest as stage

RUN apk add openssh
ADD opt /opt
ADD data /data

RUN sh /opt/install.sh

# ----- -----
FROM scratch

COPY --from=stage /stage /

VOLUME [ "/data" ]
EXPOSE 22/TCP

CMD [ "/bin/run.sh" ]
