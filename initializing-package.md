Initializing Package
=============================================

Recommended steps for creating an R package, almost regardless of its content.  The list below is roughly a copy-and-paste list into new Issues in your GitHub repository.

Prereqs:
* Create a free personal [GitHub account](https://github.com/join).
* *Optional*: Enable [two-factor authentication](https://help.github.com/articles/about-two-factor-authentication/).
* Create a public [GitHub repository](https://help.github.com/articles/create-a-repo/).
* Create a [GitHub milestone](https://help.github.com/articles/creating-and-editing-milestones-for-issues-and-pull-requests/) called "package skeleton".  Example: https://github.com/cibsr/stanirs/milestone/1

Copy & paste each item into a new issue.  Each should be assigned to the "package skeleton" milestone.

1. **Establish Rproj file**
    It's important to set good build/check defaults. Copy from https://github.com/OuhscBbmc/referral-exposure/blob/master/referral-exposure.Rproj

1. **Establish Travis-CI**

    Travis-CI tests your package on different Linux environments.  It starts with a new environment/machine every build, so it flushes out deployment problems that may not manifest on your development machine.

    - [ ] Create an account that's authenticate through your GitHub account.  Go to https://travis-ci.org/ and "Sign Up".
    - [ ] On Travis, activate the new GitHub repo.
    - [ ] Copy and adapt the `.travis.yml` config file from https://github.com/OuhscBbmc/referral-exposure/blob/master/.travis.yml.
    - [ ] Commit the repo & push.
    - [ ] Add the Travis badge to the repo README file.  I recommend a badge for the 'master' branch and a badge for the 'dev' branch.

    Further details:
      * The first test will take Travis a long time (maybe 20 min?) because it's caching a lot of the environment setup.  Once cached, a minimal package will take just a few minutes each push.
      * Only the last commit of a push is tested.
      * Travis-CI can to a lot of things beyond this simple scenario.  There's a lot to read.
      * https://travis-ci.org/getting_started
      * https://docs.travis-ci.com/user/languages/r/

1. **Establish AppVeyor** *Optional*

    AppVeyor tests your package on different Windows environments.  It starts with a new environment/machine every build, so it flushes out deployment problems that may not manifest on your development machine.

    - [ ] Create an account that's authenticate through your GitHub account.  Go to https://ci.appveyor.com/login and click "GitHub".
    - [ ] On Travis, activate the new GitHub repo.
    - [ ] Copy and adapt the `.travis.yml` config file from https://github.com/OuhscBbmc/referral-exposure/blob/master/appveyor.yml.
    - [ ] Commit the repo & push.
    - [ ] Add the Travis badge to the repo README file.  I recommend a badge for the 'master' branch and a badge for the 'dev' branch.

    Further details:
    * The first test will take AppVeyor a long time (but not as long as Travis) because it's caching a lot of the environment setup.  Once cached, a minimal package will take just a few minutes each push.
    * Only the last commit of a push is tested.
    * AppVeyor can to a lot of things beyond this simple scenario.  There's a lot to read.
    * https://www.appveyor.com/docs/
    * https://github.com/krlmlr/r-appveyor

1.  **Install Package-Creation Packages**
    * [`devtools`](https://CRAN.R-project.org/package=devtools)
        * [`testthat`](https://CRAN.R-project.org/package=testthat) --for testing
        * [`knitr`](https://CRAN.R-project.org/package=knitr)  --for vignettes
        * [`roxygen2`](https://CRAN.R-project.org/package=roxygen2)  --for easier documentation creation & maintenance
        * [`covr`](https://CRAN.R-project.org/package=covr)  --for code coverage

    * [`magrittr`](https://CRAN.R-project.org/package=magrittr)  --for piping

    ```r
    install.packages("devtools", dependencies=TRUE)
    install.packages("magrittr")
    ```
