FROM couchbase/server:community-4.1.1

RUN apt-get update && \
    apt-get install -y ufw

ADD start.sh /start.sh
RUN chmod +x /start.sh

ENTRYPOINT ["/start.sh"]

