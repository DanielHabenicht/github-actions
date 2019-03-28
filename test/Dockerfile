FROM alpine:latest

LABEL "com.github.actions.name"="test"
LABEL "com.github.actions.description"="Executes test action"
LABEL "com.github.actions.icon"="activity"
LABEL "com.github.actions.color"="yellow"

RUN apk add --no-cache \
    bash \
    ca-certificates \
    curl \
    jq

COPY test-action.sh /usr/bin/test-action

ENTRYPOINT ["test-action"]