# Rewards API

## Deployment

The APIs require a Postgres database to function, so during creation you are able to specify your own Postgres Db details, or we can create you one at the same time as VM creation.

## How to Use

After deployment, two APIs must be called to initialise the Rewards Framework.

1. POST http://ip:8080/admin/tier/loadRefData

2. POST http://ip:8080/admin/transactionRewardPoints/loadRefData

Find the rest of the APIs that can be used [here](./api-docs.json), with a nice UI [here](./docs.html).

This swagger documentation can also be found on your deployed server at http://ip:8080/v2/api-docs, or a nicer ui of it at http://ip:8080/swagger-ui.html.

## Details

The default reward tier levels after calling `/admin/tier/loadRefData` are:

| Tier     | Required Points |
| -------- | --------------- |
| Blue     | 0               |
| Silver   | 1000            |
| Gold     | 5000            |
| Platinum | 10000           |

The default activities and roles after calling `/admin/transactionRewardPoints/loadRefData` are:

| Activity           | User       | Points gained |
| ------------------ | ---------- | ------------- |
| Safety Briefing    | Attendee   | 10            |
| Safety Briefing    | Supervisor | 10            |
| Safety Inspection  | Inspector  | 10            |
| Safety Observation | Observor   | 15            |
| Joining            | New User   | 0             |

## Support

### Sales

[Asim Salim](mailto:Asim.Salim@bcstechnology.com.au)

### Technical

[Ajitha Thayaharan](mailto:Ajitha.Thayaharan@bcstechnology.com.au)

[Daniel Krajnik](mailto:Daniel.Krajnik@bcstechnology.com.au)

[Harrison McKenzie](mailto:Harrison.Mckenzie@bcstechnology.com.au)
