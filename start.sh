#! /bin/sh -
ufw enable
ufw deny 8091/tcp

/entrypoint.sh couchbase-server &

timeout 60 bash -c 'until echo > /dev/tcp/phpunit-couchbase/8091; do sleep 1; done'

# Setup Services
curl -u Administrator:password -v -X POST \
  http://localhost:8091/node/controller/setupServices \
  -d 'services=kv%2Cn1ql%2Cindex%2Cfts'

# Initialize Node
curl -v -X POST \
  http://localhost:8091/nodes/self/controller/settings \
  -d 'path=%2Fopt%2Fphpunit-couchbase%2Fvar%2Flib%2Fphpunit-couchbase%2Fdata&index_path=%2Fopt%2Fphpunit-couchbase%2Fvar%2Flib%2Fphpunit-couchbase%2Fdata'

# Setup Administrator username and password
curl -v -X POST \
  http://localhost:8091/settings/web \
  -d 'password=password&username=Administrator&port=SAME'

# Setup Bucket
curl -u Administrator:password -v -X POST \
  http://localhost:8091/pools/default/buckets \
  -d 'flushEnabled=1&threadsNumber=3&replicaIndex=0&replicaNumber=0&evictionPolicy=valueOnly&ramQuotaMB=597&bucketType=membase&name=default&authType=sasl&saslPassword='

ufw disable

sleep infinity

