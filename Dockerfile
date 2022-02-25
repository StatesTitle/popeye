FROM derailed/popeye
RUN apk --no-cache add wget jq
ENTRYPOINT [ "/bin/popeye" ]
