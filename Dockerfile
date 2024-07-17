FROM kbase/kb-sdk:1.2.1

COPY update.sh /update.sh
RUN /update.sh
