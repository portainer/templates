# App Templates

This repository hosts the official templates (**'Apps Templates'**) definitions for Portainer.

For more information about the template definition format and how to deploy your own templates, see the [relevant documentation section](https://documentation.portainer.io/v2.0/templates/deploy_stack/).


I highly recommend using [Lissy93's templates](https://github.com/Lissy93/portainer-templates).
But if you want to use this repo's templates, you'll want to reference the following URL in the Portainer template settings:
```
https://raw.githubusercontent.com/shmolf/portainer-templates/main/templates-2.0.json
```

## Category List
<!--
Acquired by pasting the template JSON into browser DevTools, then running:
```js
Array.from(new Set(json.templates.flatMap((t) => t.categories))).sort()
```
-->
- backup
- docker
- photos

## Application List
<!--
Acquired by pasting the template JSON into browser DevTools, then running:
```js
Array.from(new Set(json.templates.map((t) => t.title))).sort()
```
-->
- Immich
- Watchtower
