In this demo we're going to follow along with a very common developer workflow. We're going to build an application from source to a secure image, then store that image in a registry and scan it for vulnerabilities, then deploy that image to Kubernetes, as well as check out some metrics from the image and look at how the platform team can help developers stay productive. The application that will be built and deployed is called spring-petclinic, which is a Spring Boot app, but you can use whatever application and language you would like.


The first step in a traditional workflow is to commit some code changes to Git. 
* Make some code change to your branch of spring-petclinic

Now that the change has been made we can go to our pipeline tool, which is what controls the whole workflow. You can refer to a pipeline tool as a "CI" tool or an "integration" tool. All those names are fairly common. Our pipeline has two responsibilities: first, to get our source code built into a secure image, and then to get that image deployed to Kubernetes.

* Once the Concourse job "Build with TBS" lights up, click into it

Here we can see that our pipeline doesn't do the work of building our image, it's simply telling Tanzu Build Service to build the image. Tanzu Build Service (TBS) does not replace traditional pipelines, it only replaces parts of those pipelines.

* Switch to Harbor

Once TBS builds an image, it pushes it to a registry and then that's the end of TBS' responsibility. In our case TBS pushed our image to Harbor.

Harbor has a lot of built-in security features. You can see our original spring-petclinic image here in Harbor, and it's already been scanned. It's got X vulnerabilities. I didn't have to tell Harbor to scan that image, you can just tell Harbor to scan all images.

* Refresh Harbor to show the new image that TBS just built

You can see that our new image has X less vulnerabilities than the first image. This is because we use Tanzu Build Service. The Tanzu Build Service team creates and distributes patched, secure base images for customers to consume. All I had to do was keep TBS up-to-date and my images got more secure.

Harbor not only provides information about image vulnerabilities but gives you some options on how to act on that information. 

* Switch to Configuration tab for the project

Here you can see the option "Prevent vulnerable images from running". This lets you decide what level of vulnerability you want to let your images be while still being deployed. This is just one option in Harbor's very security-forward configuration.

* Switch to Tanzu Application Catalog

spring-petclinic, the spring boot app that we're following through a pipeline, is not a stateless application. It needs a backing database, in this case MySQL. Since we're deploying MySQL on K8s, a great place to find MySQL is Tanzu Application Catalog. Like TBS, the sibling product to Tanzu App Catalog, Tanzu App Catalog builds software on your enterprises base image. TBS and TAC help increase the ROI in your base image. 

* Show the Build Time Reports section
TAC, aside from building popular third party software on your base image, also runs a variety of tests and scans on the image. You can learn what open source licenses were used to build the app, any CVEs found in the image, as well as antivirus scans and functional tests.

* Switch to Concourse
* Once the Deploy to Kubernetes job highlights, click on it to go inside

Ok, the image has already been pushed to the registry so it is time to go back to our pipeline. Remember that our pipeline has two jobs. First, to build our source code into a secure image. That was taken care of by TBS. Now, we need to get our image deployed. Since we're using Kubernetes, and Kubernetes has a lot of knowledge on how to deploy apps well, we leave this task to Kubernetes to figure out. The pipeline just tells Kubernetes to get started.

The last thing the pipeline does is create a Wavefront Event. An event is something a developer can create using the Wavefront API and is used to mark a significant event in your charts. 

* Switch to Tanzu Obs

In this case the significant event is a deploy. If the charts and graphs looked great until they reach a deploy event, and then the graphs look bad, its clear your deploy was at fault and should be rolled back.

* Switch to Tanzu Mission Control
We've been looking at this workflow through the eyes of a developer, but a developer-focused workflow still includes the platform team. Tanzu Mission Control is the UI for infrastructure operators and devops team members. It has a lot of features but the two I want to talk about today are the integration with Tanzu Observability and the feature called Data Protection.

Data Protection lets you backup the state of your cluster, either the whole cluster or just parts of it. For this demo we'll just backup the spring-petclinic parts. You can also setup these backups to be on a schedule for a more fire-and-forget experience.

The second feature is the TO integration. From inside TMC you can link directly to the K8s dashboard for whatever cluster you're interested in.

* Click the TO integration button to link to the dashboard

This highlights an important part of TO, which is that its a unified metrics platform. Infrastructure teams and DevOps teams and Application development teams can all use TO. It's a focused product that scales very well. 


* Summary
Ok, that is the end of this demo. We saw a number of things:
* We saw TBS be triggered by a standard pipeline tool and build our app source into an image
* We saw TBS push the image to Harbor, which automatically scanned our image for vulnerabilites and provides us with some actions we can take based on the vulnerabilities
* We looked at TAC and how its a secure place to get third-party software as well as get a higher ROI on your base image
* We looked at TO and how you can use the API to create marks on your graphs to signify meaningful events
* We saw how TO is a great metrics platform for all teams, from infrastructure to application teams
* We saw how Tanzu Mission Control can help operators see the metrics they want for clusters inside TO, as well as how operators can backup clusters to prevent disruption to their developers in case of an incident




