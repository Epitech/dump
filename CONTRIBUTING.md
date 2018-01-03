# **Contributing to EpitechContent**
____
## **Found an Issue?**
____
If you find a bug in the source code or a mistake in the documentation, you can help us by
submitting an issue to the project issues page.
Each issue should be tagged with at least an "issue type and priority" tag, either "tech-debt" for technical debt issues, or one of improvement, defect or critical for bugs.

Even better you can submit a Merge Request with a fix.

## **Submitting a Merge Request**
____
Before you submit your merge request consider the following guidelines:

* Search for an open or closed Merge Request
  that relates to your submission. You don't want to duplicate effort.
* Fork the project and clone it locally
* Make your changes in a new git branch:

    ```shell
    git checkout -b my-fix-branch master
    ```

* Create your patch, **including appropriate test cases**.
* Run the full project test suite (if any exists),
  and ensure that all tests pass.
* Commit your changes using a descriptive commit message that follows our
  [commit message conventions](#git-commit-guideline). Adherence to the [commit message conventions](#git-commit-guideline) is required,
  because release notes are automatically generated from these messages.

    ```shell
    git commit -a
    ```
  Note: the optional commit `-a` command line option will automatically "add" and "rm" edited files.

* Push your branch to Gitlab:

    ```shell
    git push --set-upstream origin my-fix-branch
    ```

In Gitlab, send a merge request to `master` accross forks.
If we suggest changes, then:

* Make the required updates.
* Re-run the full test suite to ensure tests are still passing.
* Commit your changes to your branch (e.g. `my-fix-branch`).
* Push the changes to your Gitlab repository (this will update your Pull Request).

If the PR gets too outdated we may ask you to rebase and force push to update the PR:

```shell
git rebase master -i
git push origin my-fix-branch -f
```

_WARNING: Squashing or reverting commits and force-pushing thereafter may remove Gitlab comments
on code that were previously made by you or others in your commits. Avoid any form of rebasing
unless necessary._

#### After your merge request is merged

After your merge request is merged, you can safely delete your branch and pull the changes
from the main (upstream) repository:

* Delete the remote branch on Gitlab either through the Gitlab web UI or your local shell as follows:

    ```shell
    git push origin --delete my-fix-branch
    ```

* Check out the master branch:

    ```shell
    git checkout master -f
    ```

* Delete the local branch:

    ```shell
    git branch -D my-fix-branch
    ```

* Update your master with the latest upstream version:

    ```shell
    git pull --ff upstream master
    ```

## **Git Commit Guideline**
____
We have very precise rules over how your git commit messages can be formatted.  This leads to **more
readable messages** that are easy to follow when looking through the **project history**.
But also, we use the git commit messages to **generate releases changelogs**.

### Commit Message Format
Each commit message consists of a **header**, a **body** and a **footer**.  The header has a special
format that includes a **type**, a **scope** and a **subject**:

```
<type>(<scope>): <subject>
<BLANK LINE>
<body>
<BLANK LINE>
<footer>
```

The **header** is mandatory and the **scope** of the header is optional.

Any line of the commit message cannot be longer 100 characters! This allows the message to be easier
to read in various git tools.

### Type
Must be one of the following:

* **feat**: A new feature
* **fix**: A bug fix
* **docs**: Documentation only changes
* **style**: Changes that do not affect the meaning of the code (white-space, formatting, missing
  semi-colons, etc)
* **refactor**: A code change that neither fixes a bug nor adds a feature
* **perf**: A code change that improves performance
* **test**: Adding missing or correcting existing tests
* **chore**: Changes to the build process or auxiliary tools and libraries such as documentation
  generation
* **other**: Anything else that do not really matter

### Scope
The scope could be anything specifying place of the commit change.<br />
For example `api`, `entities`, etc...

You can remove the scope when the change affects more than a single scope.<br />
Ex : `chore: Bump to next snapshot iteration`

### Subject
The subject contains succinct description of the change:

* use the imperative, present tense: "change" not "changed" nor "changes"
* don't capitalize first letter
* no dot (.) at the end

### Body
Just as in the **subject**, use the imperative, present tense: "change" not "changed" nor "changes".
The body should include the motivation for the change and contrast this with previous behavior.

### Footer
The footer should contain any information about **Breaking Changes**

**Breaking Changes** should start with the word `BREAKING CHANGE:` with a space or two newlines.
The rest of the commit message is then used for this.

