FROM couchbase/server:community-6.5.1

ENV MEMORY_QUOTA 256
ENV INDEX_MEMORY_QUOTA 256
ENV FTS_MEMORY_QUOTA 256

ENV SERVICES "kv,n1ql,index,fts"

ENV USERNAME "Administrator"
ENV PASSWORD "password"

ENV CLUSTER_HOST ""
ENV CLUSTER_REBALANCE ""

ADD start.sh /root/start.sh

RUN chmod +x /root/start.sh

ENTRYPOINT /root/start.sh
