# DevOps Assessment

The DevOps Assessment project is a simple web application which counts the number of times a unique visitor visits the application. In this exercise, I was required to deploy this application to any service of choice, while employing DevOps practices and utilizing the power of the cloud.

This documentation will walk you through the various parts of the project.

## Architecture diagram
<p text-align=center>
<img src=./.assets/architecture.png width=90% >
</p>

This is a simple web application, so it was deployed on Azure App Service and connected to a Postgresql database running in a secure virtual machine.

Requirements:

- Azure Cli
- Terraform
- GitHub Actions
- Ansible




## Configuration

As for any Docker-ready application - It can be easily configured via environment variables. So, here is a list of them:

- `DATABASE_URL` (required) - connection string to your database, you can find examples [here][flask-sqlalchemy-connstr].
- `USER_NAME` - your name, which will be shown on the page
- `USER_URL` - something like your personal URL (CV, blog, contact page, etc.)

# Task


## Infrastructure

`Terraform` was used to provision all the aspects of the cloud infastructure and **`Ansible`** was then used to configure the Postgresql server and database.

## Containerisation

A `Dockerfile` was write for the application and the build image was pushed to DockerHub using a GitHub Action Workflow.

I also prepared a Docker-compose file to use for local testing. You can take a look [here](./app/compose.yaml).



## CI/CD

I chose to use GitHub Actions for CI/CD workflows. It was my first time using it. It think it was efficient because compared with similar tools, it is flexible and robust.


- Database Migrations<br/>
    Upon deployment, the application runs DB migrations as expected
- Versioning<br/>
    The current project version can be seen in the file `version.txt` and it will be shown as the version on a web page.
    What about adding a build number to this version and auto-increment it on each build? ....Done!
    

## Starting the Application
In order to start the application just follow the following steps
 - Locally: <br/>
   Clone the repo, cd into /app directory and run ```docker compose up```

 - On Cloud: <br/>
   I have prepared a couple of workflows. First, I'll run the `CI workflow`, next I'll run the `Terraform Apply` workflow, and finally I'll run the `Configure Database` workflow whilw passing in the ip address of the DB server. Finally I'll remove the public ip from the database server (for security reasons). This should have everything up and running.



## Questions?

If you still have some questions about this task, feel free to [ask me](mailto:davidstone097@gmail.com).

# License

[![Creative Commons License](https://i.creativecommons.org/l/by-sa/4.0/88x31.png)][license]

This work is licensed under a [Creative Commons Attribution-ShareAlike 4.0 International License][license].

[github-clone]: git@github.com:soar/devops-test.git
[github-repository]: https://github.com/soar/devops-test

[license]: http://creativecommons.org/licenses/by-sa/4.0/

[demo]: https://devopstesttask.pythonanywhere.com/

[ansible]: https://www.ansible.com
[aws]: https://aws.amazon.com
[bitbucket-pipelines]: https://confluence.atlassian.com/bitbucket/build-test-and-deploy-with-pipelines-792496469.html
[chef]: https://www.chef.io
[asciiflow]: http://asciiflow.com
[cloudcraft]: https://cloudcraft.co
[codecov]: https://codecov.io
[coverage]: https://coverage.readthedocs.io
[coveralls]: https://coveralls.io
[drawio]: http://draw.io
[flake8]: http://flake8.pycqa.org/en/latest/index.html
[flask]: http://flask.pocoo.org
[flask-deploy]: http://flask.pocoo.org/docs/1.0/deploying/#deployment
[flask-sqlalchemy-connstr]: http://flask-sqlalchemy.pocoo.org/2.3/config/#connection-uri-format
[gitlab-ci-yml]: https://docs.gitlab.com/ee/ci/yaml/
[iac]: https://en.wikipedia.org/wiki/Infrastructure_as_code
[jenkins-pipelines]: https://jenkins.io/doc/book/pipeline/
[mypy]: https://mypy.readthedocs.io/en/stable/index.html
[terraform]: https://www.terraform.io
