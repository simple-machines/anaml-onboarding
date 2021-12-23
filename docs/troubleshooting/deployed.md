# Troubleshooting Problems That Occur After Deployment

## unable to load feature set data preview

While using Anaml, you may see the following error in the logs and data (e.g. preview data) will not load:

```
"unable to load feature set data preview" e.g. Failed to preview feature set: System memory X must be at least Y. Please increase heap size using the --driver-memory option or spark.driver.memory in Spark configuration
```

This is caused by the docker containers not having enough memory.

Stop the docker containers with `docker-compose down` and re-configure docker with more memory (e.g. 8GB) before trying again.
