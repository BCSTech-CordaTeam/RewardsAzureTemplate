# Rewards API

## Deployment

The APIs require a Postgres database to function, so during creation you are able to specify your own Postgres Db details, or we can create you one at the same time as VM creation.

## How to Use

After deployment, you need to create two important configurations. The first is to create the different tiers and at how many points each tier requires to be achieved. The second is the list of different activities, user types and the amount of points they gain from completing an activity.

### Sample Configurations

To see how the sample works invoke the below apis:

1. POST `http://ip:8080/admin/tier/loadRefData`

2. POST `http://ip:8080/admin/transactionRewardPoints/loadRefData`

The sample reward tier levels after calling `/admin/tier/loadRefData` are:

| Tier     | Required Points |
| -------- | --------------- |
| Blue     | 0               |
| Silver   | 1000            |
| Gold     | 5000            |
| Platinum | 10000           |

The sample activities and user types after calling `/admin/transactionRewardPoints/loadRefData` are:

| Activity           | User Type  | Points gained |
| ------------------ | ---------- | ------------- |
| Safety Briefing    | Attendee   | 10            |
| Safety Briefing    | Supervisor | 10            |
| Safety Inspection  | Inspector  | 10            |
| Safety Observation | Observor   | 15            |
| Joining            | New User   | 0             |

### Custom Configurations

Instead of using our sample configurations, you can instead add your own tiers and activities with these two APIs:

1. POST `http://ip:8080/admin/tier/add`

2. POST `http://ip:8080/admin/transactionRewardPoints/add`

### API Documentation

The rest of the APIs can be found [here](./api-docs.json), with a nice UI [here](./docs.html).

This OpenApi documentation can also be found on your deployed server at `http://ip:8080/v2/api-docs`, or a nicer ui of it at `http://ip:8080/swagger-ui.html`.

## Support

### Sales

[Asim Salim](mailto:Asim.Salim@bcstechnology.com.au)

### Technical

[Ajitha Thayaharan](mailto:Ajitha.Thayaharan@bcstechnology.com.au)

[Daniel Krajnik](mailto:Daniel.Krajnik@bcstechnology.com.au)

[Harrison McKenzie](mailto:Harrison.Mckenzie@bcstechnology.com.au)
