# Contributing

Thanks for your interest in contributing to this project!

The following is a set of guidelines for contributing to this library. Most of them will make the life of the reviewer easier and therefore decrease the time required for the patch be included in the next version.

Because this project forms a part of Alfresco Content Services, the guidelines are hosted in the [Alfresco Social Community](http://community.alfresco.com/community/ecm) where they can be referenced from multiple projects.

Read an [overview on how this project is governed](https://community.alfresco.com/docs/DOC-6385-project-overview-repository).

You can also perform the following:

- Raise issues directly against the project (GitHub bug).  Please read the [instructions for a good issue report](https://community.alfresco.com/docs/DOC-6263-reporting-an-issue).

- Supply pull requests. Please read the [instructions for making a contribution](https://community.alfresco.com/docs/DOC-6269-submitting-contributions).

Please follow the [coding standards](https://community.alfresco.com/docs/DOC-4658-coding-standards).

Code of Conduct is adapted from the [Contributor Covenant][homepage], version 1.4,
available at [http://contributor-covenant.org/version/1/4][version]

[homepage]: http://contributor-covenant.org
[version]: http://contributor-covenant.org/version/1/4/

## How to handle pull requests (for maintainers)

Pull requests for contributing to the helm charts that are coming from forked
repositories, needs to be pushed to the main repository by an user with write
privileges so that integration tests running on EKS can be run successfully (AWS
credentials are not available in the build context otherwise).

> Make sure to carefully check the pull request code to avoid any [pwn request](https://securitylab.github.com/research/github-actions-preventing-pwn-requests/)

Here follows the procedure to push a new branch on the main repository the code from a forked repository.

Add the forked repository as an additional remote to your local git:

```bash
git remote add $PR_AUTHOR_USERNAME $PR_FORKED_REPO_HTTPS_URL
git fetch $PR_AUTHOR_USERNAME
```

Checkout a new branch and align it to the PR branch (you can see the upstream branch at the top of the PR page):

```bash
git checkout -b pr-$PR_NUMBER
git reset --hard $PR_AUTHOR_USERNAME/$PR_BRANCH
```

Optionally rebase to make sure that the branch is aligned with our current master and then push:

```bash
git rebase origin/master
git push origin pr-$PR_NUMBER
```

The new workflow triggered will execute helm integration tests as usual using the pull request code.
