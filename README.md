# UI templates

This repository hosts the official templates (**'Apps'**) definitions for CloudInovasi UI.

It also describes how to host your own Apps.

## Template definition format

Template definitions are written in *JSON*.

It must consist of an array with every template definition consisting of one element.

### Template format

A template element must be a *JSON* object with the following mandatory fields:

* `title`: Title of the template
* `description`: Description of the template
* `logo`: URL for the template logo
* `image`: the Docker image associated to the template

The following fields are optional:

* `env`: An array describing the environment variables required by the template.
For each variable, an input will be created in the UI.

*Format*:

```json
{
  "name": "the name of the environment variable, as supported in the container image (mandatory)",
  "label": "label for the input in the UI (mandatory)",
  "set": "pre-defined value for the variable, will not generate an input in the UI (optional)"
}
```

Example:

```json
{
  "name": "MYSQL_ROOT_PASSWORD",
  "label": "Root password"
}
```

* `volumes`: An array describing the associated volumes of the template.
For each volume, a Docker volume will be created and associated when starting the template.
* `ports`: An array describing the ports exposed by template.
Each port will be automatically bound on the host by Docker when starting the container.

**Example**:

```json
{
  "title": "MySQL",
  "description": "The most popular open-source database",
  "logo": "https://upload.wikimedia.org/wikipedia/en/thumb/6/62/MySQL.svg/640px-MySQL.svg.png",
  "image": "mysql:latest",
  "env": [
    {
      "name": "MYSQL_ROOT_PASSWORD",
      "label": "Root password"
    }
  ],
  "volumes": ["/var/lib/mysql"],
  "ports": ["3306/tcp"]
}
```

## Host your own templates

You can build your own container that will use **nginx** to serve the templates definitions.

Clone the repository, edit the templates file, build and run the container:

```shell
$ git clone https://github.com/cloud-inovasi/ui-templates.git
$ cd ui-templates
# Edit the file templates.json
$ docker build -t cloudinovasi-ui-templates .
$ docker run -d -p "8080:80" cloudinovasi-ui-templates
```

Now you can access your templates definitions at `http://docker-host:8080/templates.json`.

You can also mount the `templates.json` file inside the container, so you can edit the file and see live changes:

```shell
$ docker run -d -p "8080:80" -v "${PWD}/templates.json:/usr/share/nginx/html/templates.json" cloudinovasi-ui-templates
```

## Available apps:

* Docker registry (based on `registry:latest`)
* Nginx (based on `nginx:latest`)
* Httpd (based on `httpd:latest`)
* MySQL (based on `mysql:latest`)
* MariaDB (based on `mariadb:latest`)
* PostgreSQL (based on `postgres:latest`)
* Mongo (based on `mongo:latest`)
* Elasticsearch (based on `elasticsearch:latest`)
* Solr (based on `solr:latest`)
* Redis (based on `redis:latest`)
* RabbitMQ (based on `rabbitmq:latest`)
* Jenkins (based on `jenkins:latest`)
* WordPress (based on `wordpress:latest`)
* Joomla (based on `joomla:latest`)
* Drupal (based on `drupal:latest`)
* Magento 2 (based on `alankent/gsd:latest`)
