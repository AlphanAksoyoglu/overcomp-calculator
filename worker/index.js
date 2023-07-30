const keys = require('./keys');
const redis = require('redis');

//create the redis client here
const redisClient = redis.createClient({
    //these are coming from the keys.js file, we defined them there
    host: keys.redisHost,
    port: keys.redisPort,
    //in miliseconds
    retry_strategy: () => 1000
});
//we make a duplicate of the client here for some reason
const sub = redisClient.duplicate();


//this is of course the recursive fibo solution
function fib(index){
    if (index < 2 ) return 1;
    return fib(index - 1) + fib(index -2);
}

//when a message is received at the redis server run this
sub.on('message', (channel, message) => {
    
    redisClient.hset('values', message, fib(parseInt(message)));
});
sub.subscribe('insert');