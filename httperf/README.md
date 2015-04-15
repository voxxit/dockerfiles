# httperf

[httperf](http://www.hpl.hp.com/research/linux/httperf/) is a tool for measuring
web server performance. It provides a flexible facility for generating various
HTTP workloads and for measuring server performance. The focus of httperf is not
on implementing one particular benchmark but on providing a robust, high-
performance tool that facilitates the construction of both micro- and 
macro-level benchmarks.

The three distinguishing characteristics of httperf are its robustness, which 
includes the ability to generate and sustain server overload, support for the 
HTTP/1.1 and SSL protocols, and its extensibility to new workload generators and
performance measurements.

**Relevant Projects:**

  * [autoperf](http://mervine.net/projects/gems/autoperf) - a Ruby driver for httperf

Running a test with Docker
--------------------------

```shell
docker run --rm -it \
  -v <log directory>:/logs voxxit/httperf \
    --hog \
    --server=<server hostname> \
    --port=<server port> \
    --wlog=n,/logs/<log to replay> \
    --num-conn=<number of connections>
```
You should then get a bunch of output (which you can redirect to a file, or see with `docker logs`)

```
Total: connections 1012 requests 1924 replies 969 test-duration 266.821 s

Connection rate: 3.8 conn/s (263.7 ms/conn, <=100 concurrent connections)
Connection time [ms]: min 20003.7 avg 20441.1 max 24993.2 median 20203.5 stddev 668.7
Connection time [ms]: connect 2.0
Connection length [replies/conn]: 1.062

Request rate: 7.2 req/s (138.7 ms/req)
Request size [B]: 199.0

Reply rate [replies/s]: min 0.0 avg 3.6 max 9.8 stddev 2.6 (53 samples)
Reply time [ms]: response 434.1 transfer 0.2
Reply size [B]: header 750.0 content 2383.0 footer 0.0 (total 3133.0)
Reply status: 1xx=0 2xx=470 3xx=45 4xx=454 5xx=0

CPU time [s]: user 76.37 system 187.23 (user 28.6% system 70.2% total 98.8%)
Net I/O: 12.5 KB/s (0.1*10^6 bps)

Errors: total 952 client-timo 40 socket-timo 0 connrefused 0 connreset 912
Errors: fd-unavail 0 addrunavail 0 ftab-full 0 other 0

Session rate [sess/s]: min 0.00 avg 0.00 max 0.00 stddev 0.00 (0/40)
Session: avg 0.00 connections/session
Session lifetime [s]: 0.0
Session failtime [s]: 96.0
Session length histogram: 7 4 5 5 4 0 1 5 2 1 2 2 2
```
