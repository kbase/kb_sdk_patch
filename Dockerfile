FROM kbase/kb-sdk:1.2.1

COPY update.sh /update.sh
RUN /update.sh
RUN rm -rf /tmp /boot && mkdir /tmp && mkdir /boot
RUN chmod 777 /.docker /boot /tmp
