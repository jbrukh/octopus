# create a global connection to redis
$redis = Redis.new(:host => 'localhost', :port => 6379)