FROM cluster-base
LABEL maintainer="zsu58@icloud.com"

HEALTHCHECK CMD curl -f http://localhost:8088/ || exit 1

ADD ./resourcemanager/run.sh /run.sh
RUN chmod a+x /run.sh

# Web
EXPOSE 8088
# Scheduler
EXPOSE 8030
# Tracker
EXPOSE 8031
# Default
EXPOSE 8032

CMD ["/run.sh"]
