workflow "Publish Helm chart(s)" {
  resolves = [
    "Package Helm Chart(s)",
    "Filter: not deleted",
  ]
  on = "push"
}

workflow "Pull Requests" {
  on = "pull_request"
  resolves = [
    "Lint changed chart(s) in pull request",
  ]
}

action "Package Helm Chart(s)" {
  uses = "billimek/gh-actions/helm-gh-pages@master"
  args = "https://wrmilling.github.io/wrmilling-charts/"
  secrets = [
    "GITHUB_TOKEN",
    "COMMIT_EMAIL",
    "ACCESS_TOKEN",
  ]
  needs = ["Filter: not deleted"]
  env = {
    SKIP_LINTING = "true"
  }
}

action "Filter: action 'opened|synchronize'" {
  uses = "actions/bin/filter@master"
  args = "action 'opened|synchronize'"
  secrets = ["GITHUB_TOKEN"]
  needs = ["Filter: not master branch"]
}

action "Lint changed chart(s) in pull request" {
  uses = "billimek/gh-actions/helm-gh-pages@master"
  args = "https://wrmilling.github.io/wrmilling-charts/"
  secrets = ["GITHUB_TOKEN"]
  needs = ["Filter: action 'opened|synchronize'"]
}

action "Filter: master branch" {
  uses = "actions/bin/filter@master"
  args = "branch master"
  secrets = ["GITHUB_TOKEN"]
}

action "Filter: not deleted" {
  uses = "actions/bin/filter@master"
  args = "not deleted"
  secrets = ["GITHUB_TOKEN"]
  needs = ["Filter: master branch"]
}

action "Filter: not master branch" {
  uses = "actions/bin/filter@master"
  args = "not branch master"
  secrets = ["GITHUB_TOKEN"]
}

workflow "on pull request merge, delete the branch" {
  on = "pull_request"
  resolves = ["branch cleanup"]
}

action "branch cleanup" {
  uses = "jessfraz/branch-cleanup-action@master"
  secrets = ["GITHUB_TOKEN"]
}
