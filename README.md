Microservice Architecture (Load balanced + High availability)
=============================================================

The components of this design are

- [Spring Boot Microservice](#mlservice)
- [Spring Eureka Server](#eureka-server)
- [Spring Zipkin Server](#zipkin-server)
- [Zuul Proxy](#msapigateway)
- [Hystrix Circuit Breaker](#mlservice)


This is a work in progress, but existing parts are stable

# MLService

`Uses Spring Boot, Loadbalanced Rest Template, Eureka Client, Hystrix Circuit Breaker`

This project holds the service layer. There is only one microservice here. However, the sample is done in such a way that invoking another microservice is done through Eureka Server and Load balnced Rest template. Hence each service here acts like a separate microservice, for demonstration pruposes. The sample will help you design fully scalable microservices, fully functional. 

Only change that has to be done in production is, same module microservices chain calls has to go through camel routes, or request forwarding and not allowed to hit the load balanced resttemplate. An efficient and deisgn approved way of implementing it is via a proxy, that would redirect calls to method calls or rest template deciding which services we host. I agree, need not complicate it that much, can harcode internal calls as plain java function calls and be done with it.


# Eureka Server

`Uses Spring Eureka Server`

* Eureka Sever is fully functional
* Eureka Server does failover 
* Eureka Server takes Peer Info as environment variable

Eureka Server is configured with a peer and per region. For Demo purposes we call the region east. Servers are statrted with following VM arguments

Server 1
========
`-Dspring.profiles=PeerEast1 -DEUREKA-SERVER-HOST=localhost -DSERVER-PORT=8761 -DPEER-SERVER-HOST=localhost -DPEER-SERVER-PORT=8762`

Server 2
========
`-Dspring.profiles=PeerEast2 -DEUREKA-SERVER-HOST=localhost -DSERVER-PORT=8762 -DPEER-SERVER-HOST=localhost -DPEER-SERVER-PORT=8761`


# MSApiGateway

`Uses Zuul Proxy`

This project implements the concept of Zuul Gateway. All microservices are exposed here from one baseurl of the gateway. The methos is desireable when you want to expose one global URL. The load balancing is done by Zuul. Each call will round robin fashion hit a new server. The Gateway is configured to listen to the Eureka server.

# Zipkin Server

`Uses Spring Zipkin Server`

Zipkin Server listens on localhost and can log events. Any event that involves a restfull microservice invocation, or Zull proxy ivoke is logged by Zipkin server.  Zipkin server also maintains the context of a call. This actually means the following

Let us discuss a scenario where several microservices are present. They run on three servers named as below

* Server1 hosts Microservice MS1
* Server2 hosts Microservice MS2
* Server3 hosts Microservice MS3

`Server1:MS1` -> `Server2:MS2` -> `Server3:MS3`

`Server1:MS1` invokes `Server2:MS2` which invokes `Server3:MS3`

Zipkin will log this as one Span or call, it will include child spans for individual servers running Microservice

# Happy coding! 

Good Luck and spend time and code slow. It is not the size of the docker ship, it is the motion in the ocean - Santhosh 

## Contribute

* Fork the project
* Create a feature branch based on the 'master' branch
* Create a PR and feel proud.


## License

MicroServicesArchitecture is released under the MIT license, see [LICENSE](https://github.com/BonifyByForteil/react-native-piwik/blob/master/LICENSE).

`# Microservices Architecture`
`# Microservices`
