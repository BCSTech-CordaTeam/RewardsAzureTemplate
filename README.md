# Rewards API

## Deployment

The APIs require a Postgres database to function, so during creation you are able to specify your own Postgres Db details, or we can create you one at the same time as VM creation.

## How to Use

After deployment, two APIs must be called to initialise the Rewards Framework.

1. POST http://ip:8080/admin/tier/loadRefData

2. POST http://ip:8080/admin/transactionRewardPoints/loadRefData

Find the rest of the APIs that can be used [here](./api-docs.json), with a nice UI [here](./index.html).

This swagger documentation can also be found on your deployed server at http://ip:8080/v2/api-docs, or a nicer ui of it at http://ip:8080/swagger-ui.html.

## Support

### Sales

[Asim Salim](Asim.Salim@bcstechnology.com.au)

### Technical

[Ajitha Thayaharan](Ajitha.Thayaharan@bcstechnology.com.au)

[Daniel Krajnik](Daniel.Krajnik@bcstechnology.com.au)

[Harrison McKenzie](Harrison.Mckenzie@bcstechnology.com.au)
