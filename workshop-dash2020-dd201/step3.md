You just discovered the root cause of an issue in your spree services using advanced dashboarding tools. To capture and share your knowledge, let's create a runbook that you can share with your team.

## Adding a Notebook
In your navigation bar, find the Notebook icon and click “New Notebook”, or go to https://app.datadoghq.com/notebook. Give it a name like `Debugging Spree Services`.  

Let’s start by adding an overview of your services. You can paste this overview that a teammate has already written.

```
## Service Overview
`ads-service`: Service to manage advertisement scheduling and displays  
`discounts-service`: Service to manage discount codes and validation  
`store-frontend`: Service for the store’s web frontend  
```

## Custom Troubleshooting
Next, let's add links to some of the graphs you used to debug your service. Since we worked on `store-frontend`, we can create a custom link to the graph of `store-frontend` performance. Go to the dashboard of your [RUM Performance Overview(https://app.datadoghq.com/screen/integration/30292/rum---performance-overview?from_ts=1595949761945&to_ts=1595953361945&live=true).  

This is an out-of-the-box dashboard for real-user-monitoring (RUM) that monitors metrics like page views and frontend errors. We can clone it to make changes.  

For our spree services, we know that problems often happen in the production environment with frontend errors. Let’s set our template variable `env` to `prod`. This updates our dashboard URL.  

We can link to this dashboard in our runbook and add some context around it.. Paste this into your runbook or add your own context:  

```
[RUM Performance Overview for Prod](https://app.datadoghq.com/screen/integration/30292/rum---performance-overview?from_ts=1595968236673&live=true&to_ts=1595971836673&tpl_var_env=prod)
```

## Exporting Graphs
We can also export individual graphs to this notebook. Go to the `Frontend Errors` graph and export it to the notebook we’ve created.  

Each graph can easily be unlinked from global time and set to a new time, manually or by dragging to select. Trying unlinking this graph from global time and changing the time range.  

You can also adjust the size of your graph.  

We can add some context to this graph for our teammates or even add code snippets for applying a fix.  

```
Typical behavior is to have most errors from `error.origin:network`- if other categories are spiking, should be investigated.  

## Solving Bottlenecks
By changing the line:
```
discounts = Discount.query.all()
```
To the following:
```
discounts = Discount.query.options(joinedload('*')).all()
```
We eager load the `discount_type` relation on the `discount`, and can grab all information without multiple trips to the database:
```

## Custom Links
Going back to our cloned performance overview dashboard, we can link to our runbook directly from the `Frontend Errors` graph.  

Edit the `Frontend Errors` graph and click the `Custom Links` tab.

Copy in the URL of our notebook and give it a name, like `Sprees Runbook for {{$env.value}}`. This will populate the link name with our `env` template variable. Click Done and Save.  

Now, when we set `env` to `prod`, we can click on the `Frontend Errors` graph and see that our custom link has updated.  

## Shared Context
Now your dashboard and runbook link to each other. You can easily link to a runbook from a Monitor, a graph, or even an external team wiki. You can see notebooks you and teammates have created in the Notebooks list page.

```
