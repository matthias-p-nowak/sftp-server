FROM alpine:latest
RUN apk add openssh
RUN ssh-keygen -A
ADD opt /opt
RUN sh /opt/install.sh
VOLUME [ "/data" ]
CMD [ "/opt/run.sh" ]
