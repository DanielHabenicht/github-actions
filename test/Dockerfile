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

COPY ./test-action.sh ./test-action.sh
RUN ["chmod", "+x", "./test-action.sh"]
ENTRYPOINT ["./test-action.sh"]