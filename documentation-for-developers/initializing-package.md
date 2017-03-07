Initializing Package
=============================================

Recommended steps for creating an R package, almost regardless of its content.  The list below is roughly a copy-and-paste list into new Issues in your GitHub repository.  This curriculum was developed by [Will Beasley](https://github.com/wibeasley) and [Andrey Koval](https://github.com/andkov) to serve the workshops for [OU SCUG](https://github.com/OuhscBbmc/StatisticalComputing) and [Stanford's CIBSR](https://github.com/cibsr).

## Prerequisites:
* Create a free personal [GitHub account](https://github.com/join).
* *Optional*: Enable [two-factor authentication](https://help.github.com/articles/about-two-factor-authentication/).
* Create a public [GitHub repository](https://help.github.com/articles/create-a-repo/).  
    * The name is case-sensitive, and cannot have spaces, dashes, or [even underscores](http://stackoverflow.com/questions/24201568/whats-a-good-r-package-name).
    * Select the options: (a) initialize with a README, (b) use the 'R' template for the `.gitignore` file, and (c) select a license (The MIT license is a good fit for a demo R package).
* Create a [GitHub milestone](https://help.github.com/articles/creating-and-editing-milestones-for-issues-and-pull-requests/) called "package skeleton".  Example: https://github.com/cibsr/stanirs/milestone/1
* Install 'RTools' if it's not already installed.
    * Windows: https://cran.r-project.org/bin/windows/Rtools/.
    * Linux (make sure you have `r-base-dev`): http://www.jason-french.com/blog/2013/03/11/installing-r-in-linux/.
    * OSX (maybe): http://r.research.att.com/.
* Install RStudio Desktop: https://www.rstudio.com/products/rstudio/download/.
* Install R packages (from within the RStudio 'Console').  The [`magrittr`](https://CRAN.R-project.org/package=magrittr) package is for piping.  The  [`devtools`](https://CRAN.R-project.org/package=devtools) package makes package development much easier; its dependencies include [`testthat`](https://CRAN.R-project.org/package=testthat) (for testing),  [`knitr`](https://CRAN.R-project.org/package=knitr) (for vignettes, and other reporting), [`roxygen2`](https://CRAN.R-project.org/package=roxygen2) (for easier documentation creation & maintenance), and [`covr`](https://CRAN.R-project.org/package=covr) (for code coverage).

    ```r
install.packages("devtools", dependencies=TRUE)
install.packages("magrittr")
    ```
* Install GitHub Desktop (for Windows & OSX): https://desktop.github.com/

## Issues
Copy & paste each item into a new issue.  Each should be assigned to the "package skeleton" milestone.  

As this document grows older, some things may get out of date; R evolves, CRAN policies catch more mistakes, and coding styles change.  Look at live packages for reference too.  [ReferralExposure](https://github.com/OuhscBbmc/referral-exposure/) might continue to be a simple project of ours, while [REDCapR](https://github.com/OuhscBbmc/REDCapR/) has more complicated dependencies, and hopefully should be maintained for many years.  Of course, look at examples from [Hadley](https://github.com/hadley) and [tidyverse](https://github.com/tidyverse), though their C code requires much more complexity than your first package will.

#### Establish Rproj file

It's important to set good build/check defaults. Copy from https://github.com/OuhscBbmc/referral-exposure/blob/master/referral-exposure.Rproj.  In the repo's root directory, create a plain text file; the name should match the repo, and have the extension 'Rproj' (case-sensitive).  Alternatively, run `devtools::use_rstudio()`, and add the extra fields.


```
Version: 1.0

RestoreWorkspace: No
SaveWorkspace: No
AlwaysSaveHistory: No

EnableCodeIndexing: Yes
UseSpacesForTab: Yes
NumSpacesForTab: 2
Encoding: UTF-8

RnwWeave: knitr
LaTeX: pdfLaTeX

AutoAppendNewline: Yes
StripTrailingWhitespace: Yes

BuildType: Package
PackageUseDevtools: Yes
PackageInstallArgs: --no-multiarch --with-keep.source
PackageRoxygenize: rd,collate,namespace

```

#### Establish DESCRIPTION file

This is the most important file of the package structure.  

- [ ] Create a plain-text file called `DESCRIPTION` (without any extension) in the repo's root directory.  Ideally, the Package name (in the first field) should match the repo's name.  Alternatively, run `devtools::create_description()`, and add the extra fields.

```
Package: ReferralExposure
Title: Calculating exposure over multiple referrals
Description: Reusable functions for calculating exposure during repeated spans.
Version: 0.0.1.9000
Date: 2017-02-21
Authors@R: c(person("Will", "Beasley", role = c("aut", "cre"), email =
    "wibeasley@hotmail.com"), person("David", "Bard", role = "ctb"))
URL: https://github.com/OuhscBbmc/referral-exposure, http://ouhsc.edu/bbmc/
BugReports: https://github.com/OuhscBbmc/referral-exposure/issues
Depends:
    R(>= 3.0.0),
    stats
Imports:
    methods,
    magrittr
Suggests:
    devtools,
    knitr,
    rmarkdown,
    testthat (>= 0.9)
License: MIT + file LICENSE
LazyData: TRUE
RoxygenNote: 6.0.1
Roxygen: list(markdown = TRUE)

```

- [ ] Verify the package successfully 'Builds' (ctrl+shift+B in RStudio).
- [ ] Verify the package passes the 'Check' (ctrl+shift+E in RStudio).


#### Establish Travis-CI

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
* Alternatively, use `devtools::use_travis()` and complete the extra fields.

#### Establish AppVeyor *Optional*

AppVeyor tests your package on different Windows environments.  It starts with a new environment/machine every build, so it flushes out deployment problems that may not manifest on your development machine.

- [ ] Create an account that's authenticate through your GitHub account.  Go to https://ci.appveyor.com/login and click "GitHub".
- [ ] On Travis, activate the new GitHub repo.
- [ ] Copy and adapt the `appveyor.yml` config file from https://github.com/OuhscBbmc/referral-exposure/blob/master/appveyor.yml.
- [ ] Commit the repo & push.
- [ ] Add the Travis badge to the repo README file.  I recommend a badge for the 'master' branch and a badge for the 'dev' branch.

Further details:
* The first test will take AppVeyor a long time (but not as long as Travis) because it's caching a lot of the environment setup.  Once cached, a minimal package will take just a few minutes each push.
* Only the last commit of a push is tested.
* AppVeyor can to a lot of things beyond this simple scenario.  There's a lot to read.
    * https://www.appveyor.com/docs/
    * https://github.com/krlmlr/r-appveyor
* Alternatively, use `devtools::use_appveyor()` and complete the extra fields.

#### Branching Demo

This isn't a real issue for the package.  It's a placeholder for the SCUG meeting.  While the Travis & AppVeyor environments are building & caching, we'll spend ~15 minutes covering branching/forking, merging, and rebasing.

See https://github.com/wibeasley/class-branching.

#### Establish GitHub "topics"

Add `r`, `r-package`, and whatever is relevant to your content.

https://github.com/blog/2309-introducing-topics

#### Establish dev branch

All the real work should be committed to this development branch. Pull the finished features in to the master branch with Pull Requests.

Any changes that happen in the master, away from the dev, use [rebase](https://help.github.com/articles/about-git-rebase/) to update dev.

#### Establish repo-wide config files

Copy and adapt from https://github.com/OuhscBbmc/referral-exposure/.

- [ ] `README.md` with badges and installation instructions
- [ ] `.gitignore`
- [ ] `.gitattributes`
- [ ] `.Rbuildignore`
- [ ] code of conduct https://help.github.com/articles/adding-a-code-of-conduct-to-your-project/
- [ ] license (eg, GPL)
- [ ] Verify it passes a local "build" (ctrl+shift+B)
- [ ] Verify it passes a local "check" (ctrl+shift+E)
- [ ] Thin out the dependencies & suggests you won't be using soon

#### Establish first unit tests

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

#### Establish first function

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

#### Package-wide documentation

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

Next Steps
=======================
After the package structure has been initialized, attendees will add functions to their own packages.  So please come with ideas for recurring challenges/tasks faced in your personal research.  Depending on attendees' interests, we can discuss:

**Important Topics**

1. Identifying which parts of your research challenges/tasks can be cast as a problem for a common tool/function.
1. Strategies for coding these common tasks.
1. Approaches to testing the reusable functions with an automated test suite that runs at every checkpoint of development.
1. Making the reusable functions robust to corner cases and input you haven't anticipated.
1. Adding internal and external data sets.
    * rda files in `data/`
    * csv files in `inst/extdata/`

**Optional Topics**

1. Providing support to users with reasonable boundaries.
1. "Releases" and versioning.
1. Creating helpful documentation that minimizes maintenance.
1. Supplementing documentation with vignettes.
1. Online documentation with [RDocumentation.org](http://rdocumentation.org/) and [pkgdown](https://github.com/hadley/pkgdown)
1. Using repositories to supplement publications.
1. Assigning a DOI to repository with [Zenodo](https://guides.github.com/activities/citable-code/).  Benefits of archiving by a 3rd party.
1. Tradeoffs of [deploying your package to CRAN](https://cran.r-project.org/web/packages/available_packages_by_name.html).

Further Reading
=======================
* Wickham, Hadley (2015). *R Packages*.  http://r-pkgs.had.co.nz/
* R Core (2017). *Writing R Extensions*. https://cran.r-project.org/doc/manuals/r-release/R-exts.html
* R Core (2017). *CRAN Repository Policy*. https://cran.r-project.org/web/packages/policies.html
