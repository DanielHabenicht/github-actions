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

WORKDIR /action

COPY test-action.sh ./test-action
RUN ["chmod", "+x", "./test-action"]
CMD ["./test-action"]