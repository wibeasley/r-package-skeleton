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

1. **Branching Demo**

    This isn't a real issue for the package.  It's a placeholder for the SCUG meeting.  While the Travis & AppVeyor environments are building & caching, we'll spend ~15 minutes covering branching/forking, merging, and rebasing.

    See https://github.com/wibeasley/class-branching.

1. **Establish GitHub "topics"**

    Add `r`, `r-package`, and whatever is relevant to your content.

    https://github.com/blog/2309-introducing-topics

1. **Establish dev branch**

    All the real work is here. Pull the finished features in to the master branch with Pull Requests.

    Any changes that happen in the master, away from the dev, use [rebase](https://help.github.com/articles/about-git-rebase/) to update dev.

1. **Establish repo-wide config files**

    Copy and adapt from https://github.com/OuhscBbmc/referral-exposure/.

    - [ ] `DESCRIPTION`
    - [ ] `README.md` with badges and installation instructions
    - [ ] `.gitignore`
    - [ ] `.gitattributes`
    - [ ] `.Rbuildignore`
    - [ ] code of conduct https://help.github.com/articles/adding-a-code-of-conduct-to-your-project/
    - [ ] license (eg, GPL)
    - [ ] Verify it passes a local "build" (ctrl+shift+B)
    - [ ] Verify it passes a local "check" (ctrl+shift+E)
    - [ ] Thin out the dependencies & suggests you won't be using soon

1. **Establish first unit tests**

    For automated testing on Travis (#2) and AppVeyor (#3).  Adapt from https://github.com/OuhscBbmc/referral-exposure/tree/master/tests.

    - [ ] Create `./tests/test-all.R`.  Make sure there's an empty last line (not even a space or tab).

        ```r
        #Modeled after the R6 testing structure: https://github.com/wch/R6/blob/master/tests/testthat.R
        library(testthat)
        library(ReferralExposure)

        testthat::test_check("ReferralExposure")

        ```        

    - [ ] Create `.tests/testhat/rest-basic.R`.  Make sure there's an empty last line (not even a space or tab).

        ```r
        library(testthat)
        context("Basic Functions")

        test_that("smoke-test", {
          returned <- basic(3)
          expect_true(!is.null(returned))
        })

        test_that("vector-test", {
          expected <- 4:7
          returned <- basic(3:6)
          expect_equal(returned, expected)
        })

        ```

    - [ ] Verify that this fails your local check (because we haven't yet created the function `basic()`).

1. **Establish first function**

    Create `.R/basic.R`.  Make sure there's an empty last line (not even a space or tab).

    ```r
    #' Short title
    #'
    #' Longer sentence description
    #'
    #' @param a integer.  Required
    #' @export
    #' @importFrom magrittr %>%
    #' @md
    #'
    basic <- function( a ) {
      b <- a + 1

      return( b )
    }

    ```

1. **Package-wide documentation**

    Assume your username is 'uuu'.  Assume your package name is 'ppp'.  Create `./R/ppp-package.R`.  Make sure there's an empty last line (not even a space or tab).

    ```r
    #' @docType package
    #' @name ppp-package
    #' @aliases ppp
    #'
    #' @title Short-book-title
    #'
    #' @description
    #' The description should be a longer complete sentence.
    #'
    #' TODO: consider adding links to your project's funders.
    #'
    #' @note
    #' The most recent development version is available through [GitHub](https://github.com/uuu/ppp) by
    #' running.
    #'
    #' `devtools::install_github('uuu/ppp')`
    #' (make sure [devtools](https://cran.r-project.org/package=devtools) is already installed).
    #' If you're having trouble with the package, please install the development version.  If this doesn't solve
    #' your problem, please create a [new issue](https://github.com/uuu/ppp/issues), or email uuu.
    #'
    #' @examples
    #' \dontrun{
    #' # Install/update ReferralExposure with the development version from GitHub
    #' #install.packages('devtools') #Uncomment if `devtools` isn't installed already.
    #' devtools::install_github('uuu/ppp')
    #' }
    NULL
    ```
