FROM sysdig/kube-psp-advisor:1.7.0
ADD ./entrypoint.sh /entrypoint.sh
RUN chmod u+x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
