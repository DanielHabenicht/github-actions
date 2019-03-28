#!/bin/sh
set -e
set -o pipefail

if [[ ! -z "$TOKEN" ]]; then
	GITHUB_TOKEN=$TOKEN
fi

if [[ -z "$GITHUB_TOKEN" ]]; then
	echo "Set the GITHUB_TOKEN env variable."
	exit 1
fi

URI=https://api.github.com
API_VERSION=v3
API_HEADER="Accept: application/vnd.github.${API_VERSION}+json"
AUTH_HEADER="Authorization: token ${GITHUB_TOKEN}"

# Github Actions will mark a check as "neutral" (neither failed/succeeded) when you exit with code 78
# But this will terminate any other Actions running in parallel in the same workflow.
# Configuring this Environment Variable `NO_BRANCH_DELETED_EXIT_CODE=0` if no branch was deleted will let your workflow continue.
# Docs: https://developer.github.com/actions/creating-github-actions/accessing-the-runtime-environment/#exit-codes-and-statuses
NO_BRANCH_DELETED_EXIT_CODE=${NO_BRANCH_DELETED_EXIT_CODE:-78}

main(){
	action=$(jq --raw-output .action "$GITHUB_EVENT_PATH")
	merged=$(jq --raw-output .pull_request.merged "$GITHUB_EVENT_PATH")

	echo "running $GITHUB_ACTION for PR #${NUMBER}"

	echo $action

	if [[ "$action" == "opened" ]]; then
		# execute action
		ref=$(jq --raw-output .pull_request.head.ref "$GITHUB_EVENT_PATH")
		owner=$(jq --raw-output .pull_request.head.repo.owner.login "$GITHUB_EVENT_PATH")
		repo=$(jq --raw-output .pull_request.head.repo.name "$GITHUB_EVENT_PATH")


		NUMBER=$(jq --raw-output .number "$GITHUB_EVENT_PATH")

		echo "running $GITHUB_ACTION for PR #${NUMBER}"
		curl -sSL -H "${AUTH_HEADER}" -H "${API_HEADER}" -d '{"body":"This is a pretty cool comment!"}' -H "Content-Type: application/json" -X POST "${URI}/repos/${GITHUB_REPOSITORY}/issues/${NUMBER}/comments"
	
		echo "sent message!"
		exit 0
	fi
}

main "$@"