all:

cron: pull etag check

pull:
#	@docker pull node:12 > .log-12
#	@docker pull node:14 > .log-14
#	@docker pull node:16 > .log-16
	@docker pull node:18 > .log-18
	@docker pull node:20 > .log-20
	@docker pull node:22 > .log-22
	@docker pull node:24 > .log-24
	@docker pull node:26 > .log-26
#	@docker image inspect node:12 | jq -r '.[0].Id' > .id-node-12
#	@docker image inspect node:14 | jq -r '.[0].Id' > .id-node-14
#	@docker image inspect node:16 | jq -r '.[0].Id' > .id-node-16
	@docker image inspect node:18 | jq -r '.[0].Id' > .id-node-18
	@docker image inspect node:20 | jq -r '.[0].Id' > .id-node-20
	@docker image inspect node:22 | jq -r '.[0].Id' > .id-node-22
	@docker image inspect node:24 | jq -r '.[0].Id' > .id-node-24
	@docker image inspect node:26 | jq -r '.[0].Id' > .id-node-26

etag:
	@curl -s -D- --head HEAD https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip | \
	grep ^ETag | uniq | sed -e 's|^ETag: ||' | jq -r . > .etag-awscli

check:
	@-./prepare-log-message.sh
	@if [ -s .log-message ]; then\
		git add `cat .log-files` && git commit -F .log-message && git push;\
	fi
