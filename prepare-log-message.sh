#!/bin/sh

git status -s > .log-work
rm -f .log-msg-* .log-message

parts=""
files=""

grep -q .etag-awscli .log-work && { parts=" awscli"; files=".etag-awscli"; (echo -n "awscli: "; cat .etag-awscli) > .log-msg-awscli; }
ls .id-node-?? | sed -e 's|.id-node-||' > .log-versions
while read v; do
	grep -q .id-node-$v .log-work && { parts="$parts node-$v"; files="$files .id-node-$v"; (echo -n "node-$v: "; cat .id-node-$v) > .log-msg-node-$v; }
done < .log-versions

if [ -n "$parts" ]; then
	cat <<EOF > .log-message
Update$parts

EOF
	cat .log-msg-* >> .log-message
	echo "$files" > .log-files
else
	touch .log-message
fi

# Local Variables:
# sh-basic-offset: 8
# sh-indentation: 8
# End:
