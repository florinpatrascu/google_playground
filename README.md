# A Google Cloud Playground

A repository containing small random scripts that I use to manage some GCP infrastructure chores, notes, etc. Mostly Elixir of course 🍺

## You need

- [Elixir](https://elixir-lang.org), latest version ideally
- [Erlang](https://www.erlang.org/), of course

Optional support:

- [Homebrew](https://brew.sh)
- [asdf](https://asdf-vm.com/#/core-manage-asdf-vm?id=install-asdf-vm)
- [direnv](https://direnv.net)

and a Google Cloud project you have access to.

I assume you already have a valid account and sufficient permissions to use the scripts in this repo. Most of the scripts rely on the following two environment variables:

```sh
export ACCESS_TOKEN=$(gcloud auth print-access-token)
export GCLOUD_PROJECT_ID=my_gcp_project
```

Your access token will expire from time to time, in case you're wondering where the error got from running some scripts.

Here is a small example of how you can use one of the scripts in this repo.

```sh
cd service_accounts
elixir list_keys.exs

# or: ACCESS_TOKEN=$(gcloud auth print-access-token) elixir list_keys.exs, and skip some steps ;P
# or: elixir service_accounts/list_keys.exs
# ..
```

And you will see every service account and its associated keys, those managed by the system (by Google) or those created by the user [him- or herself](https://english.stackexchange.com/questions/79643/him-or-herself-v-himself-or-herself):

```txt
+---------------------------------------------------------------------------------------------------------+
|  hobbit-admin-sa@hole-dweller-lower.iam.gserviceaccount.com (Project Admin Pro Dweller Hobbit Account)  |
+------------------------------------------+----------------+----------------------+----------------------+
| Key                                      | Type           | Valid from           | Valid to             |
+------------------------------------------+----------------+----------------------+----------------------+
| f99........***...***...xxxxxxx...1b2fd68 | USER_MANAGED   | 2023-04-28T14:49:10Z | 9999-12-31T23:59:59Z |
| 799.........***..***...xyxyxyx.....d6ef1 | USER_MANAGED   | 2020-06-16T07:22:26Z | 9999-12-31T23:59:59Z |
| a123.........***..***...xyxyxyx.....236a | SYSTEM_MANAGED | 2023-04-18T17:59:09Z | 2023-05-04T17:59:09Z |
+------------------------------------------+----------------+----------------------+----------------------+

+---------------------------------------------------------------------------------------------------------+
|      hobbit-staging-sa@hole-dweller-lower.iam.gserviceaccount.com (Hobbit Staging Hole SA)              |
+------------------------------------------+----------------+----------------------+----------------------+
| Key                                      | Type           | Valid from           | Valid to             |
+------------------------------------------+----------------+----------------------+----------------------+
| a1239.......***...***...xxxxxxx..aa1fe32 | SYSTEM_MANAGED | 2023-04-18T17:37:44Z | 2023-05-04T17:37:44Z |
+------------------------------------------+----------------+----------------------+----------------------+
```

## Contributing

If you have found something wrong, please raise an issue.

Developers are encouraged to contribute at any time, but for substantial pieces of work, please create an issue beforehand to prevent any potential wastage of effort. Thank you!

## License

[GNU AFFERO GENERAL PUBLIC LICENSE, Version 3](LICENSE)
