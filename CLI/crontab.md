# [Cron cheatsheet](https://devhints.io/cron)

## Format

```
Min  Hour Day  Mon  Weekday
*    *    *    *    *  command to be executed
┬    ┬    ┬    ┬    ┬
│    │    │    │    └─  Weekday  (0=Sun .. 6=Sat)
│    │    │    └──────  Month    (1..12)
│    │    └───────────  Day      (1..31)
│    └────────────────  Hour     (0..23)
└─────────────────────  Minute   (0..59)
```

## Operators

| Operator | Description                |
|----------|----------------------------|
| `*`      | all values                 |
| `,`      | separate individual values |
| `-`      | a range of values          |
| `/`      | divide a value into steps  |

## Examples

| Cron Expression | Description                 |
|-----------------|-----------------------------|
| `0 * * * *`     | every hour                  |
| `*/15 * * * *`  | every 15 mins               |
| `0 */2 * * *`   | every 2 hours               |
| `0 18 * * 0-6`  | every week Mon-Sat at 6pm   |
| `10 2 * * 6,7`  | every Sat and Sun on 2:10am |
| `0 0 * * 0`     | every Sunday midnight       |
 
## Special strings

| Special String | Description                              |
|----------------|------------------------------------------|
| `@reboot`      | every reboot                             |
| `@hourly`      | once every hour - same as `0 * * * *`    |
| `@daily`       | once every day - same as `0 0 * * *`     |
| `@midnight`    | once every midnight - same as `@daily`   |
| `@weekly`      | once every week - same as `0 0 * * 0`    |
| `@monthly`     | once every month - same as `0 0 1 * *`   |
| `@yearly`      | once every year - same as `0 0 1 1 *`    |

## Crontab

```bash
    # Adding tasks easily
    echo "@reboot echo hi" | crontab
    
    # Open in editor - optional for another user
    crontab -e [-u user]
    
    # List tasks - optional for another user
    crontab -l [-u user]
    
    # Delete crontab file - optional for another user
    crontab -r [-u user]
```
