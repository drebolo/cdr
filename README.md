# Call Detail Record

This is new a call detail record (CDR) business intelligence platform. The idea behind it is that the call records can be queried to find information such as average call cost, longest calls, average number of calls in a given time period.

## Getting Started

This system is composed of 2 parts:
A mojolicious web app and a minion queue to process the file after it is uploaded.
I decided to use a queue to remove the load from the web app and make it more robust.

These are current end points:

```
/upload      POST

/cost
  +/average  GET
  +/max      GET
  +/min      GET

/duration
  +/average  GET
  +/max      GET
  +/min      GET

/calls
  +/average/:period  GET
  +/min/:period      GET
  +/max/:period      GET
```

Where period is one of [year|month|week|day]

Other routes could be created to extract information with specific time frames or about specific calls.
One thing that could be improved is the way that the queue inserts the data, it inserts the content of the file in batches of 1000 rows, if for some reason there is a duplicated `reference` it stops there but the content already inserted is not rollback, probably the best would be to always insert all content or if not possible rollback everything.

Please follow this instructions to setup the application
When creating the db use the user and password of your mysql setup.


### Prerequisites

```
perl
mysql
cpanm
```

### Installing

Run sql to create application and queue databases.
* Only user and password if your mysql requires it.

```
mysql $user -p < aurora.sql
```

Install Perl required modules

```
cpanm --instaldeps .
```

Copy configuration from example file

```
cp aurora.conf.example aurora.conf
```

Start the Web app

```
morbo script/aurora
```

Start the queue

```
./script/minion_start minion worker
```

A file can now be uploaded with

```
curl -X POST -F 'data=@techtest_cdr.csv' http://localhost:3000/upload
```

Some information can now be retrieved

Max call cost

```
curl -s http://127.0.0.1:3000/cost/max | jq
```

Average call cost

```
curl -s http://127.0.0.1:3000/cost/average | jq
```

Max call duration

```
curl -s http://127.0.0.1:3000/duration/max | jq
```

Average number of calls per day

```
curl -s http://127.0.0.1:3000/calls/average/day | jq
```

Max number of calls per month

```
curl -s http://127.0.0.1:3000/calls/max/month | jq
```

## Running the tests

The tests can be run with

```
prove -l
```
