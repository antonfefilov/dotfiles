[Effortless Ctags with Git](https://tbaggery.com/2011/08/08/effortless-ctags-with-git.html) by tpope

Effortless Ctags with Git

08 Aug 2011

In case you’ve been living under a programming rock, Ctags (specifically Exuberant Ctags, not the BSD version shipped with OS X) indexes source code to make it easy to jump to functions, variables, classes, and other identifiers in (among other editors) Vim (see :help tags). The major downside to Ctags is having to manually rebuild that index all the time. That’s where the not-so-novel idea of re-indexing from various Git commit hooks comes in.

Git hooks are repository specific. Some would recommend using a script to install said hooks into a given repository. But for me, that’s too manual. Let’s set up a default set of hooks that Git will use as a template when creating or cloning a repository (requires Git 1.7.1 or newer):

git config --global init.templatedir '~/.git_template'
mkdir -p ~/.git_template/hooks
Now onto the first hook, which isn’t actually a hook at all, but rather a script the other hooks will call. Place in .git_template/hooks/ctags and mark as executable:

#!/bin/sh
set -e
PATH="/usr/local/bin:$PATH"
trap 'rm -f "$$.tags"' EXIT
git ls-files | \
  ctags --tag-relative -L - -f"$$.tags" --languages=-javascript,sql
mv "$$.tags" "tags"
March 2020 edit: Changed to generate tag file in work tree, not Git dir, because Fugitive no longer provides built-in support for the latter.

Making this a separate script makes it easy to invoke .git/hooks/ctags for a one-off re-index (or git config --global alias.ctags '!.git/hooks/ctags', then git ctags), as well as easy to edit for that special case repository that needs a different set of options to ctags. For example, I might want to re-enable indexing for JavaScript or SQL files, which I’ve disabled here because I’ve found both to be of limited value and noisy in the warning department.

Here come the hooks. Mark all four of them executable and place them in .git_template/hooks. Use this same content for the first three: post-commit, post-merge, and post-checkout (actually my post-checkout hook includes hookup as well).

#!/bin/sh
.git/hooks/ctags >/dev/null 2>&1 &
I’ve forked it into the background so that my Git workflow remains as latency-free as possible.

One more hook that oftentimes gets overlooked: post-rewrite. This is fired after git commit --amend and git rebase, but the former is already covered by post-commit. Here’s mine:

#!/bin/sh
case "$1" in
  rebase) exec .git/hooks/post-merge ;;
esac
Once you get this all set up, you can use git init in existing repositories to copy these hooks in.

So what does this get you? Any new repositories you create or clone will be immediately indexed with Ctags and set up to re-index every time you check out, commit, merge, or rebase. Basically, you’ll never have to manually run Ctags on a Git repository again.
