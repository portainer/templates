# Contributing Guidelines

Some basic conventions for contributing to this project.

### General

Please make sure that there aren't existing pull requests attempting to address the issue mentioned. Likewise, please check for issues related to update, as someone else may be working on the issue in a branch or fork.

* Non-trivial changes should be discussed in an issue first
* Develop in a topic branch, not `main`

### Testing your template changes
```sh
docker compose up
```

You can manually review the JSON in the web browser at http://192.168.1.1:8426/templates.json.
But the real benefit is pointing your Portainer Template URL to the local address.
- However, to successfully deploy the stack/container that has a `repository.url` field, you'll need to modify the `url` property in the template to
  your own repo, and specifically the change will need to be in the `main` branch. Example:
  - ```
    "repository": {
        "stackfile": "stacks/immich/docker-compose.yml",
        "url": "https://github.com/<your-user-name>/portainer-templates"
    }
    ```

### Commit Message Format
Each commit message should include a **type**, a **scope** and a **subject**:

```
 <type>(<scope>): <subject>
```

Lines should not exceed 100 characters. This allows the message to be easier to read on github as well as in various git tools and produces a nice, neat commit log ie:

```
 #271 feat(template): add new mongodb template
 #270 fix(dockerfile): fix an issue with source image in Dockerfile
 #269 docs(project): update available templates section
```

#### Type

Must be one of the following:

* **feat**: A new feature
* **fix**: A bug fix
* **docs**: Documentation only changes
* **style**: Changes that do not affect the meaning of the code (white-space, formatting, missing
  semi-colons, etc)
* **refactor**: A code change that neither fixes a bug or adds a feature
* **test**: Adding missing tests
* **chore**: Changes to the build process or auxiliary tools and libraries such as documentation
  generation

#### Scope

The scope could be anything specifying place of the commit change. For example `template`,
`dockerfile`, `project` etc...

#### Subject

The subject contains succinct description of the change:

* use the imperative, present tense: "change" not "changed" nor "changes"
* don't capitalize first letter
* no dot (.) at the end
